@preconcurrency import CoreLocation
import Combine
import Foundation

@MainActor
final class LocationStore: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published private(set) var location: CLLocation?
    @Published private(set) var status: CLAuthorizationStatus = .notDetermined
    @Published private(set) var message: String?
    @Published private(set) var requesting = false

    private let manager = CLLocationManager()

    override init() {
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        status = manager.authorizationStatus
    }

    // MARK: - Request

    func request() {
        message = nil

        switch manager.authorizationStatus {

        case .notDetermined:
            requesting = true
            manager.requestWhenInUseAuthorization()

        case .authorizedAlways, .authorizedWhenInUse:
            requesting = true
            manager.requestLocation()

        case .denied, .restricted:
            requesting = false
            location = nil
            message =
                "Poloha není povolena. Mapu můžete procházet ručně nebo změnit oprávnění v Nastavení."

        @unknown default:
            requesting = false
            message = "Polohu nyní nelze získat."
        }
    }

    // MARK: - Derived location data

    var latitude: Double? {
        location?.coordinate.latitude
    }

    var longitude: Double? {
        location?.coordinate.longitude
    }

    var horizontalAccuracy: CLLocationAccuracy? {
        guard let location,
              location.horizontalAccuracy >= 0
        else {
            return nil
        }

        return location.horizontalAccuracy
    }

    var altitude: CLLocationDistance? {
        location?.altitude
    }

    var verticalAccuracy: CLLocationAccuracy? {
        guard let location,
              location.verticalAccuracy >= 0
        else {
            return nil
        }

        return location.verticalAccuracy
    }

    var lastUpdatedAt: Date? {
        location?.timestamp
    }

    var locationAge: TimeInterval? {
        guard let location else {
            return nil
        }

        return Date().timeIntervalSince(
            location.timestamp
        )
    }

    var isLocationFresh: Bool {
        guard let age = locationAge else {
            return false
        }

        return age < 120
    }

    // MARK: - Accuracy status

    var accuracyLabel: String {

        guard let accuracy = horizontalAccuracy else {
            return "Neznámá přesnost"
        }

        switch accuracy {

        case 0..<10:
            return "Velmi dobrá"

        case 10..<25:
            return "Dobrá"

        case 25..<100:
            return "Přibližná"

        default:
            return "Nízká přesnost"
        }
    }

    var accuracyDescription: String {

        guard let accuracy = horizontalAccuracy else {
            return "Přesnost není k dispozici."
        }

        return "±\(Int(accuracy.rounded())) m"
    }

    // MARK: - Formatted coordinates

    var formattedLatitude: String {

        guard let latitude else {
            return "—"
        }

        let direction =
            latitude >= 0
            ? "N"
            : "S"

        return String(
            format: "%.6f° %@",
            abs(latitude),
            direction
        )
    }

    var formattedLongitude: String {

        guard let longitude else {
            return "—"
        }

        let direction =
            longitude >= 0
            ? "E"
            : "W"

        return String(
            format: "%.6f° %@",
            abs(longitude),
            direction
        )
    }

    var formattedAltitude: String {

        guard let altitude else {
            return "—"
        }

        return "\(Int(altitude.rounded())) m"
    }

    var formattedVerticalAccuracy: String? {

        guard let verticalAccuracy else {
            return nil
        }

        return "±\(Int(verticalAccuracy.rounded())) m"
    }

    var coordinateText: String? {

        guard let latitude,
              let longitude
        else {
            return nil
        }

        return String(
            format: "%.6f, %.6f",
            latitude,
            longitude
        )
    }

    // MARK: - Authorization

    nonisolated func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {

        Task { @MainActor [weak self] in

            guard let self else {
                return
            }

            status =
                self.manager.authorizationStatus

            if status == .authorizedAlways ||
                status == .authorizedWhenInUse {

                request()

            } else if status == .denied ||
                        status == .restricted {

                location = nil
                requesting = false

                message =
                    "Poloha není povolena. Mapu můžete procházet ručně nebo změnit oprávnění v Nastavení."
            }
        }
    }

    // MARK: - CLLocationManagerDelegate

    nonisolated func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        Task { @MainActor [weak self] in

            guard let self else {
                return
            }

            requesting = false

            guard let latest = locations.last,
                  latest.horizontalAccuracy >= 0,
                  abs(
                    latest.timestamp
                        .timeIntervalSinceNow
                  ) < 120
            else {

                location = nil

                message =
                    "Nepodařilo se získat čerstvou polohu. Zkuste to znovu."

                return
            }

            location = latest
            message = nil
        }
    }

    nonisolated func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        Task { @MainActor [weak self] in

            guard let self else {
                return
            }

            requesting = false
            location = nil

            message =
                "Polohu se nepodařilo získat. Zkuste to venku nebo zkontrolujte polohové služby."
        }
    }
}
