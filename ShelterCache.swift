//
//  ShelterCache.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 30.09.2026.
//
import Foundation

struct ShelterCache {

    private let fileURL: URL

    init() {
        let fileManager = FileManager.default

        let directory = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )[0]

        let folder = directory
            .appendingPathComponent(
                "ShelterCache",
                isDirectory: true
            )

        try? fileManager.createDirectory(
            at: folder,
            withIntermediateDirectories: true
        )

        fileURL = folder
            .appendingPathComponent("shelters.json")
    }

    // MARK: - Load

    func load() -> ShelterSnapshot? {
        do {
            let data = try Data(contentsOf: fileURL)

            let cached = try JSONDecoder()
                .decode(
                    CachedSnapshot.self,
                    from: data
                )

            return cached.snapshot
        } catch {
            return nil
        }
    }

    // MARK: - Save

    func save(_ snapshot: ShelterSnapshot) {
        do {
            let cached = CachedSnapshot(
                snapshot: snapshot
            )

            let encoder = JSONEncoder()
            encoder.outputFormatting = [
                .withoutEscapingSlashes
            ]

            let data = try encoder.encode(cached)

            try data.write(
                to: fileURL,
                options: .atomic
            )

        } catch {
            print(
                "Shelter cache save failed:",
                error
            )
        }
    }

    // MARK: - Clear

    func clear() {
        try? FileManager.default
            .removeItem(at: fileURL)
    }
}

// MARK: - Cache DTO

private struct CachedSnapshot: Codable {

    let shelters: [CachedShelter]
    let omittedCount: Int
    let loadedAt: Date

    init(snapshot: ShelterSnapshot) {

        shelters = snapshot.shelters.map {
            CachedShelter(shelter: $0)
        }

        omittedCount =
            snapshot.omittedCount

        loadedAt =
            snapshot.loadedAt
    }

    var snapshot: ShelterSnapshot {

        ShelterSnapshot(
            shelters: shelters.map {
                $0.shelter
            },
            omittedCount:
                omittedCount,
            loadedAt:
                loadedAt
        )
    }
}

// MARK: - Cached shelter

private struct CachedShelter: Codable {

    let id: Int

    let latitude: Double
    let longitude: Double

    let place: String?
    let region: String?

    let registration: Double?
    let capacity: Double?

    let state: String?
    let terinosState: String?

    let purpose: String?
    let designation: String?
    let resistance: String?

    let validCoordinate: Double?

    init(shelter: Shelter) {

        id = shelter.id

        latitude =
            shelter.latitude

        longitude =
            shelter.longitude

        place =
            shelter.place

        region =
            shelter.region

        registration =
            shelter.registration

        capacity =
            shelter.capacity

        state =
            shelter.state

        terinosState =
            shelter.terinosState

        purpose =
            shelter.purpose

        designation =
            shelter.designation

        resistance =
            shelter.resistance

        validCoordinate =
            shelter.validCoordinate
    }

    var shelter: Shelter {

        Shelter(
            id: id,
            latitude: latitude,
            longitude: longitude,
            place: place,
            region: region,
            registration: registration,
            capacity: capacity,
            state: state,
            terinosState: terinosState,
            purpose: purpose,
            designation: designation,
            resistance: resistance,
            validCoordinate: validCoordinate
        )
    }
}
