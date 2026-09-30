import XCTest
import CoreLocation
@testable import UkrytyCore

final class ShelterTests: XCTestCase {
    // Synthetic fixture based on verified metadata, not a captured production response.
    private let fixture = """
    {"spatialReference":{"wkid":4326},"features":[{"attributes":{
      "objectid":42,"misto":"  Test  ","kraj":null,"ev_číslo":123.0,"kapacita":150.0,
      "stav":"stav A","stav_terin":"stav B","urceni":"typ A","určení":"typ B",
      "odolnost":null,"platna_sour":1.0},"geometry":{"x":14.42,"y":50.08}}]}
    """

    func testCzechKeysNumericFieldsAndWGS84Axes() throws {
        let response = try ArcGISResponse.decode(Data(fixture.utf8))
        let shelter = try XCTUnwrap(response.features?.first?.shelter)
        XCTAssertEqual(shelter.id, 42)
        XCTAssertEqual(shelter.place, "Test")
        XCTAssertEqual(shelter.capacity, 150)
        XCTAssertEqual(shelter.registration, 123)
        XCTAssertEqual(shelter.latitude, 50.08)
        XCTAssertEqual(shelter.longitude, 14.42)
        XCTAssertEqual(shelter.purpose, "typ B")
        XCTAssertEqual(shelter.designation, "typ A")
        XCTAssertEqual(shelter.terinosState, "stav B")
        XCTAssertNil(shelter.region)
        XCTAssertNil(shelter.resistance)
    }

    func testMissingAndInvalidGeometryAreOmitted() throws {
        for geometry in ["null", "{\"x\":500,\"y\":50}", "{\"x\":14,\"y\":null}"] {
            let json = "{\"features\":[{\"attributes\":{\"objectid\":1},\"geometry\":\(geometry)}]}"
            let value = try ArcGISResponse.decode(Data(json.utf8))
            XCTAssertNil(value.features?.first?.shelter)
        }
    }

    func testArcGISErrorInsideSuccessfulHTTPResponse() {
        XCTAssertThrowsError(try ArcGISResponse.decode(Data("{\"error\":{\"code\":400,\"message\":\"Invalid query\"}}".utf8))) { error in
            XCTAssertTrue(error.localizedDescription.contains("400"))
        }
    }

    func testQueryEncodesCzechFieldNamesAndOutputProjection() {
        let url = ArcGISShelterService.queryURL(["outFields":"ev_číslo,určení", "outSR":"4326"])
        let items = URLComponents(url: url, resolvingAgainstBaseURL: false)!.queryItems!
        XCTAssertEqual(items.first { $0.name == "outFields" }?.value, "ev_číslo,určení")
        XCTAssertEqual(items.first { $0.name == "outSR" }?.value, "4326")
        XCTAssertEqual(items.first { $0.name == "f" }?.value, "json")
    }

    func testNearestUsesGeographicDistanceAndHandlesEmptyCollection() async throws {
        let snapshot = try await DemoShelterService().fetchShelters()
        let target = snapshot.shelters[1]
        let location = CLLocation(latitude: target.latitude, longitude: target.longitude)
        XCTAssertEqual(Shelter.nearest(in: snapshot.shelters, to: location)?.id, target.id)
        XCTAssertEqual(target.distance(from: location), 0, accuracy: 0.01)
        XCTAssertNil(Shelter.nearest(in: [], to: location))
    }

    func testBatchedServiceLoadsAllIDsAndRejectsIncompleteData() async throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubProtocol.self]
        let service = ArcGISShelterService(session: URLSession(configuration: config))
        StubProtocol.incomplete = false
        let snapshot = try await service.fetchShelters()
        XCTAssertEqual(snapshot.shelters.count, 301)
        XCTAssertEqual(Set(snapshot.shelters.map(\.id)).count, 301)
        StubProtocol.incomplete = true
        do {
            _ = try await service.fetchShelters()
            XCTFail("An incomplete batch must fail")
        } catch { XCTAssertTrue(error.localizedDescription.contains("neúplná")) }
    }
}

private final class StubProtocol: URLProtocol {
    static var incomplete = false
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        let items = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!.queryItems!
        let payload: [String: Any]
        if items.contains(where: { $0.name == "returnIdsOnly" }) {
            payload = ["objectIds": Array(1...301)]
        } else {
            let value = items.first { $0.name == "objectIds" }!.value!
            var ids = value.split(separator: ",").compactMap { Int($0) }
            if Self.incomplete { ids.removeLast() }
            payload = ["spatialReference": ["wkid":4326], "features": ids.map { id in
                ["attributes": ["objectid":id], "geometry":["x":14.42,"y":50.08]] as [String:Any]
            }]
        }
        let data = try! JSONSerialization.data(withJSONObject: payload)
        client?.urlProtocol(self, didReceive: HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() {}
}
