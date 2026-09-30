import Foundation

struct ShelterDataError: LocalizedError {
    let message: String
    var errorDescription: String? { message }
}

// ArcGIS can report application errors with HTTP 200.
struct ArcGISResponse: Decodable {
    struct ServerError: Decodable { let code: Int; let message: String }
    struct SpatialReference: Decodable { let wkid: Int?; let latestWkid: Int? }
    let error: ServerError?
    let objectIds: [Int]?
    let features: [Feature]?
    let exceededTransferLimit: Bool?
    let spatialReference: SpatialReference?

    struct Feature: Decodable {
        struct Geometry: Decodable { let x: Double?; let y: Double? }
        let attributes: Attributes
        let geometry: Geometry?
        var shelter: Shelter? {
            guard let x = geometry?.x, let y = geometry?.y,
                  x.isFinite, y.isFinite, (-180...180).contains(x), (-90...90).contains(y) else { return nil }
            let a = attributes
            return Shelter(id: a.objectid, latitude: y, longitude: x, place: a.misto,
                           region: a.kraj, registration: a.registration, capacity: a.kapacita,
                           state: a.stav, terinosState: a.stavTerin, purpose: a.purpose,
                           designation: a.urceni, resistance: a.odolnost, validCoordinate: a.platnaSour)
        }
    }

    struct Attributes: Decodable {
        let objectid: Int
        let misto: String?
        let kraj: String?
        let registration: Double?
        let kapacita: Double?
        let stav: String?
        let stavTerin: String?
        let purpose: String?
        let urceni: String?
        let odolnost: String?
        let platnaSour: Double?
        enum CodingKeys: String, CodingKey {
            case objectid, misto, kraj, kapacita, stav, urceni, odolnost
            case registration = "ev_číslo", stavTerin = "stav_terin", purpose = "určení", platnaSour = "platna_sour"
        }
        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            objectid = try c.decode(Int.self, forKey: .objectid)
            func string(_ key: CodingKeys) throws -> String? {
                let value = try c.decodeIfPresent(String.self, forKey: key)?.trimmingCharacters(in: .whitespacesAndNewlines)
                return value?.isEmpty == false ? value : nil
            }
            misto = try string(.misto); kraj = try string(.kraj)
            stav = try string(.stav); stavTerin = try string(.stavTerin)
            purpose = try string(.purpose); urceni = try string(.urceni); odolnost = try string(.odolnost)
            registration = try c.decodeIfPresent(Double.self, forKey: .registration)
            kapacita = try c.decodeIfPresent(Double.self, forKey: .kapacita)
            platnaSour = try c.decodeIfPresent(Double.self, forKey: .platnaSour)
        }
    }

    static func decode(_ data: Data) throws -> Self {
        let result = try JSONDecoder().decode(Self.self, from: data)
        if let error = result.error {
            throw ShelterDataError(message: "TERINOS: \(error.message) (\(error.code))")
        }
        return result
    }
}

struct ArcGISShelterService: ShelterService {
    static let endpoint = URL(string: "https://gis.izscr.cz/arcgis/rest/services/terinos_sluzby/ukryty_cr_evid/MapServer/0/query")!
    let session: URLSession

    init(session: URLSession? = nil) {
        let config = URLSessionConfiguration.ephemeral
        config.urlCache = nil // No persistent shelter database in this internal PoC.
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        self.session = session ?? URLSession(configuration: config)
    }

    static func queryURL(_ parameters: [String: String]) -> URL {
        var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)!
        components.queryItems = (parameters.merging(["f": "json"]) { _, new in new })
            .sorted { $0.key < $1.key }.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url!
    }

    private func request(_ parameters: [String: String]) async throws -> ArcGISResponse {
        try Task.checkCancellation()
        let (data, response) = try await session.data(from: Self.queryURL(parameters))
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw ShelterDataError(message: "Server TERINOS nevrátil úspěšnou odpověď. Zkuste načtení znovu.")
        }
        return try ArcGISResponse.decode(data)
    }

    func fetchShelters() async throws -> ShelterSnapshot {
        // IDs are not subject to maxRecordCount. Fetch fixed ID batches to avoid offset drift.
        let index = try await request(["where": "1=1", "returnIdsOnly": "true"])
        guard let rawIDs = index.objectIds else {
            throw ShelterDataError(message: "TERINOS nevrátil seznam záznamů. Schéma služby se mohlo změnit.")
        }
        let ids = Array(Set(rawIDs)).sorted()
        var shelters: [Shelter] = []
        var omitted = 0
        for start in stride(from: 0, to: ids.count, by: 300) {
            let batch = Array(ids[start..<min(start + 300, ids.count)])
            let page = try await request([
                "objectIds": batch.map(String.init).joined(separator: ","),
                "outFields": "objectid,misto,kraj,ev_číslo,kapacita,stav,stav_terin,urceni,určení,odolnost,platna_sour",
                "returnGeometry": "true", "outSR": "4326"
            ])
            guard let features = page.features, page.exceededTransferLimit != true,
                  Set(features.map { $0.attributes.objectid }) == Set(batch), features.count == batch.count else {
                throw ShelterDataError(message: "TERINOS vrátil neúplná data. Načtěte je znovu; nejbližší úkryt nelze spolehlivě určit.")
            }
            guard page.spatialReference?.latestWkid == 4326 || page.spatialReference?.wkid == 4326 else {
                throw ShelterDataError(message: "Neočekávaný souřadnicový systém odpovědi TERINOS.")
            }
            let valid = features.compactMap(\.shelter)
            shelters.append(contentsOf: valid)
            omitted += features.count - valid.count
        }
        return ShelterSnapshot(shelters: shelters, omittedCount: omitted, loadedAt: Date())
    }
}
