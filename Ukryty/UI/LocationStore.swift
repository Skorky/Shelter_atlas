@preconcurrency import CoreLocation
import Combine

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
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        status = manager.authorizationStatus
    }

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
            message = "Poloha není povolena. Mapu můžete procházet ručně nebo změnit oprávnění v Nastavení."
        @unknown default:
            requesting = false
            message = "Polohu nyní nelze získat."
        }
    }

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            status = self.manager.authorizationStatus
            if status == .authorizedAlways || status == .authorizedWhenInUse { request() }
            else if status == .denied || status == .restricted {
                location = nil
                requesting = false
                message = "Poloha není povolena. Mapu můžete procházet ručně nebo změnit oprávnění v Nastavení."
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            requesting = false
            guard let latest = locations.last, latest.horizontalAccuracy >= 0,
                  abs(latest.timestamp.timeIntervalSinceNow) < 120 else {
                location = nil
                message = "Nepodařilo se získat čerstvou polohu. Zkuste to znovu."
                return
            }
            location = latest
            message = nil
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            requesting = false
            location = nil
            message = "Polohu se nepodařilo získat. Zkuste to venku nebo zkontrolujte polohové služby."
        }
    }
}
