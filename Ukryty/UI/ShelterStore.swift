import Foundation
import Combine

@MainActor
final class ShelterStore: ObservableObject {
    @Published private(set) var snapshot: ShelterSnapshot?
    @Published private(set) var loading = false
    @Published private(set) var error: String?
    @Published private(set) var demo = false
    private let liveService: any ShelterService
    private var task: Task<Void, Never>?
    private var generation = 0

    init(service: any ShelterService = ArcGISShelterService()) { liveService = service }

    func load(demo: Bool = false) {
        task?.cancel()
        generation += 1
        let current = generation
        self.demo = demo
        snapshot = nil
        loading = true
        error = nil
        let service: any ShelterService = demo ? DemoShelterService() : liveService
        task = Task {
            do {
                let value = try await service.fetchShelters()
                try Task.checkCancellation()
                guard current == generation else { return }
                snapshot = value
                loading = false
            } catch {
                guard current == generation, !Task.isCancelled else { return }
                loading = false
                if error is DecodingError {
                    self.error = "Odpověď TERINOS má neočekávaný formát. Může jít o změnu schématu služby."
                } else {
                    self.error = "Data se nepodařilo načíst. \(error.localizedDescription)"
                }
            }
        }
    }
}
