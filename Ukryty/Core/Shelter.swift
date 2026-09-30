import Foundation
import CoreLocation

struct Shelter: Identifiable, Sendable {
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

    var coordinate: CLLocationCoordinate2D { .init(latitude: latitude, longitude: longitude) }
    var title: String { place ?? "Evidovaný úkryt č. \(id)" }
    func distance(from location: CLLocation) -> Double {
        location.distance(from: CLLocation(latitude: latitude, longitude: longitude))
    }
    static func nearest(in shelters: [Shelter], to location: CLLocation) -> Shelter? {
        shelters.min { $0.distance(from: location) < $1.distance(from: location) }
    }
}

struct ShelterSnapshot: Sendable {
    let shelters: [Shelter]
    let omittedCount: Int
    let loadedAt: Date
}

protocol ShelterService: Sendable {
    func fetchShelters() async throws -> ShelterSnapshot
}

struct DemoShelterService: ShelterService {
    func fetchShelters() async throws -> ShelterSnapshot {
        let shelters = [(50.081, 14.425), (50.091, 14.415), (50.074, 14.442)].enumerated().map { index, point in
            Shelter(id: index + 1, latitude: point.0, longitude: point.1,
                    place: "Fiktivní ukázka \(index + 1)", region: "Demonstrační data",
                    registration: nil, capacity: 100, state: "Ukázkový stav",
                    terinosState: nil, purpose: "Ukázkové určení", designation: nil,
                    resistance: "Ukázková hodnota", validCoordinate: nil)
        }
        return ShelterSnapshot(shelters: shelters, omittedCount: 0, loadedAt: Date())
    }
}
