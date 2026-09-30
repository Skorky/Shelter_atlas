import Foundation
import Combine

@MainActor
final class ShelterStore: ObservableObject {

    @Published private(set)
    var snapshot: ShelterSnapshot?

    @Published private(set)
    var loading = false

    @Published private(set)
    var error: String?

    @Published private(set)
    var demo = false

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
        snapshot = cache.load()
    }

    func load(
        demo: Bool = false
    ) {

        task?.cancel()

        generation += 1

        let current =
            generation

        self.demo =
            demo

        // DŮLEŽITÉ:
        // snapshot už nemažeme.
        //
        // Pokud už máme starší data,
        // zůstanou na mapě během refreshu.

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

                // DEMO data do cache neukládáme.
                if !demo {
                    cache.save(value)
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
