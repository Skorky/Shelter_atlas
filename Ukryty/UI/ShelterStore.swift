import Foundation
import Combine

@MainActor
final class ShelterStore: ObservableObject {

    enum DataSource {
        case none
        case cache
        case live
        case demo
    }

    @Published private(set)
    var snapshot: ShelterSnapshot?

    @Published private(set)
    var loading = false

    @Published private(set)
    var error: String?

    @Published private(set)
    var demo = false

    @Published private(set)
    var dataSource: DataSource = .none

    private let liveService: any ShelterService
    private let cache = ShelterCache()

    private var task: Task<Void, Never>?
    private var generation = 0

    init(
        service: any ShelterService =
            ArcGISShelterService()
    ) {

        liveService = service

        // Nejprve zobrazíme poslední
        // úspěšně uložená data.
        if let cachedSnapshot = cache.load() {

            snapshot = cachedSnapshot
            dataSource = .cache

        } else {

            snapshot = nil
            dataSource = .none
        }
    }

    // MARK: - Stav dat

    var isShowingCachedData: Bool {
        dataSource == .cache
    }

    var isShowingLiveData: Bool {
        dataSource == .live
    }

    var isShowingDemoData: Bool {
        dataSource == .demo
    }

    var dataSourceTitle: String {

        switch dataSource {

        case .none:
            return "Data nejsou načtena"

        case .cache:
            return "Uložená data"

        case .live:
            return "Aktuální data"

        case .demo:
            return "Demonstrační data"
        }
    }

    var dataSourceSymbol: String {

        switch dataSource {

        case .none:
            return "questionmark.circle"

        case .cache:
            return "internaldrive"

        case .live:
            return "network"

        case .demo:
            return "testtube.2"
        }
    }

    // MARK: - Načtení dat

    func load(
        demo: Bool = false
    ) {

        task?.cancel()

        generation += 1

        let current =
            generation

        self.demo =
            demo

        // Snapshot nemažeme.
        //
        // Pokud už máme starší data,
        // zůstanou na mapě během aktualizace.

        loading = true
        error = nil

        let service:
            any ShelterService =
                demo
                ? DemoShelterService()
                : liveService

        task = Task {

            do {

                let value =
                    try await
                    service.fetchShelters()

                try Task
                    .checkCancellation()

                guard
                    current == generation
                else {
                    return
                }

                snapshot =
                    value

                loading =
                    false

                if demo {

                    dataSource =
                        .demo

                } else {

                    dataSource =
                        .live

                    cache.save(
                        value
                    )
                }

            } catch {

                guard
                    current == generation,
                    !Task.isCancelled
                else {
                    return
                }

                loading =
                    false

                // Pokud už nějaká data máme,
                // ponecháme je i po neúspěšném refreshi.
                //
                // dataSource zůstává beze změny.

                if error is DecodingError {

                    self.error =
                        "Odpověď TERINOS má neočekávaný formát. Může jít o změnu schématu služby."

                } else {

                    self.error =
                        "Data se nepodařilo načíst. \(error.localizedDescription)"
                }
            }
        }
    }
}
