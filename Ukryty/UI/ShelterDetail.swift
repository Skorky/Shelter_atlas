import SwiftUI
import MapKit

@MainActor
private final class DetailState: ObservableObject {
    @Published var navigationFailed = false
}

struct ShelterDetail: View {
    let shelter: Shelter
    let demo: Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject private var state = DetailState()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Label(demo ? "Fiktivní ukázka — nejde o skutečný úkryt." : "Evidence neznamená aktuální zpřístupnění ani záruku bezpečí. Řiďte se pokyny HZS a místních úřadů.", systemImage: "info.circle")
                        .font(.callout)
                }
                Section("Evidované údaje") {
                    row("Místo", shelter.place)
                    row("Kraj", shelter.region)
                    row("Evidenční číslo", number(shelter.registration))
                    row("Kapacita", number(shelter.capacity))
                    row("Stav (stav)", shelter.state)
                    row("Stav TERINOS (stav_terin)", shelter.terinosState)
                    row("Určení (určení)", shelter.purpose)
                    row("Určení (urceni)", shelter.designation)
                    row("Odolnost", shelter.resistance)
                    row("Platnost souřadnic (platna_sour)", number(shelter.validCoordinate))
                }
                Section {
                    Text("\(shelter.latitude, specifier: "%.6f"), \(shelter.longitude, specifier: "%.6f")")
                        .textSelection(.enabled)
                    Button {
                        let item = MKMapItem(placemark: MKPlacemark(coordinate: shelter.coordinate))
                        item.name = shelter.title
                        if !item.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]) {
                            state.navigationFailed = true
                        }
                    } label: { Label("Navigovat přes Apple Maps", systemImage: "arrow.triangle.turn.up.right.diamond.fill") }
                    .disabled(demo)
                    Text("Trasa vede k evidovanému bodu. Ten nemusí označovat vstup ani přístupnou cestu.").font(.caption).foregroundStyle(.secondary)
                }
                Section { Text("Zdroj: TERINOS · MV–GŘ HZS ČR\nInterní PoC · licence dat zatím nepotvrzena").font(.footnote).foregroundStyle(.secondary) }
            }
            .navigationTitle(shelter.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Hotovo") { dismiss() } } }
            .alert("Apple Maps se nepodařilo otevřít", isPresented: $state.navigationFailed) { Button("OK", role: .cancel) {} }
        }
    }
    private func row(_ label: String, _ value: String?) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.caption).foregroundStyle(.secondary)
            Text(value ?? "Neuvedeno")
        }.textSelection(.enabled)
    }
    private func number(_ value: Double?) -> String? { value.map { $0.formatted(.number.grouping(.never)) } }
}
