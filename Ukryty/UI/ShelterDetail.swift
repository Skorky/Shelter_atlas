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

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {

                    headerCard

                    mapPreview

                    warningCard

                    keyFactsSection

                    navigationSection

                    technicalDetailsSection

                    sourceSection
                }
                .padding(16)
                .padding(.bottom, 24)
            }
            .navigationTitle("Detail úkrytu")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {

                ToolbarItem(
                    placement: .confirmationAction
                ) {

                    Button("Hotovo") {
                        dismiss()
                    }
                }
            }

            .alert(
                "Apple Maps se nepodařilo otevřít",
                isPresented: $state.navigationFailed
            ) {

                Button(
                    "OK",
                    role: .cancel
                ) {}
            }
        }
    }

    // MARK: - Header

    private var headerCard: some View {

        HStack(
            alignment: .top,
            spacing: 14
        ) {

            Image(
                systemName: "building.2.fill"
            )
            .font(.title2)
            .frame(
                width: 52,
                height: 52
            )
            .background(
                .thinMaterial,
                in: RoundedRectangle(
                    cornerRadius: 14,
                    style: .continuous
                )
            )

            VStack(
                alignment: .leading,
                spacing: 5
            ) {

                Text(shelter.title)
                    .font(.title2.bold())
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                if let region = shelter.region {

                    Text(region)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if let place = shelter.place {

                    Label(
                        place,
                        systemImage: "mappin.and.ellipse"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding(16)
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .background(
            .regularMaterial,
            in: RoundedRectangle(
                cornerRadius: 22,
                style: .continuous
            )
        )
    }

    // MARK: - Náhled mapy

    private var mapPreview: some View {

        Map(
            initialPosition: .region(
                MKCoordinateRegion(
                    center: shelter.coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.015,
                        longitudeDelta: 0.015
                    )
                )
            )
        ) {

            Marker(
                shelter.title,
                systemImage: "building.2.fill",
                coordinate: shelter.coordinate
            )
        }
        .frame(height: 190)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous
            )
        )
        .allowsHitTesting(false)
    }

    // MARK: - Upozornění

    private var warningCard: some View {

        Label(
            demo
            ? "Fiktivní ukázka — nejde o skutečný úkryt."
            : "Evidence neznamená aktuální zpřístupnění ani záruku bezpečí. Řiďte se pokyny HZS a místních úřadů.",
            systemImage: demo
            ? "testtube.2"
            : "exclamationmark.triangle.fill"
        )
        .font(.callout)
        .padding(14)
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .background(
            .thinMaterial,
            in: RoundedRectangle(
                cornerRadius: 16,
                style: .continuous
            )
        )
    }

    // MARK: - Základní údaje

    private var keyFactsSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Základní údaje")
                .font(.headline)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 12
            ) {

                factCard(
                    title: "Kapacita",
                    value: number(
                        shelter.capacity
                    ),
                    symbol: "person.3.fill"
                )

                factCard(
                    title: "Evidenční číslo",
                    value: number(
                        shelter.registration
                    ),
                    symbol: "number"
                )

                factCard(
                    title: "Stav",
                    value: shelter.state,
                    symbol: "checkmark.shield.fill"
                )

                factCard(
                    title: "Odolnost",
                    value: shelter.resistance,
                    symbol: "shield.fill"
                )
            }
        }
    }

    private func factCard(
        title: String,
        value: String?,
        symbol: String
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Image(
                systemName: symbol
            )
            .font(.headline)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value ?? "Neuvedeno")
                .font(.body.weight(.semibold))
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
        }
        .padding(14)
        .frame(
            maxWidth: .infinity,
            minHeight: 110,
            alignment: .leading
        )
        .background(
            .thinMaterial,
            in: RoundedRectangle(
                cornerRadius: 16,
                style: .continuous
            )
        )
    }

    // MARK: - Navigace

    private var navigationSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Navigace")
                .font(.headline)

            Button {

                let item = MKMapItem(
                    placemark: MKPlacemark(
                        coordinate: shelter.coordinate
                    )
                )

                item.name = shelter.title

                let opened = item.openInMaps(
                    launchOptions: [
                        MKLaunchOptionsDirectionsModeKey:
                            MKLaunchOptionsDirectionsModeWalking
                    ]
                )

                if !opened {
                    state.navigationFailed = true
                }

            } label: {

                Label(
                    "Navigovat přes Apple Maps",
                    systemImage:
                        "arrow.triangle.turn.up.right.diamond.fill"
                )
                .font(.headline)
                .frame(
                    maxWidth: .infinity
                )
                .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .disabled(demo)

            Text(
                "Trasa vede k evidovanému bodu. Ten nemusí označovat vstup ani přístupnou cestu."
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }

    // MARK: - Podrobné údaje

    private var technicalDetailsSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Podrobné údaje")
                .font(.headline)

            VStack(
                alignment: .leading,
                spacing: 14
            ) {

                detailRow(
                    "Místo",
                    shelter.place
                )

                Divider()

                detailRow(
                    "Kraj",
                    shelter.region
                )

                Divider()

                detailRow(
                    "Stav TERINOS",
                    shelter.terinosState
                )

                Divider()

                detailRow(
                    "Určení",
                    shelter.purpose
                )

                Divider()

                detailRow(
                    "Další určení",
                    shelter.designation
                )

                Divider()

                detailRow(
                    "Platnost souřadnic",
                    number(
                        shelter.validCoordinate
                    )
                )

                Divider()

                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {

                    Text("Souřadnice")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(
                        "\(shelter.latitude, specifier: "%.6f"), \(shelter.longitude, specifier: "%.6f")"
                    )
                    .font(.body.monospaced())
                    .textSelection(.enabled)
                }
            }
            .padding(16)
            .background(
                .thinMaterial,
                in: RoundedRectangle(
                    cornerRadius: 16,
                    style: .continuous
                )
            )
        }
    }

    private func detailRow(
        _ label: String,
        _ value: String?
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 4
        ) {

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value ?? "Neuvedeno")
                .textSelection(.enabled)
        }
    }

    // MARK: - Zdroj

    private var sourceSection: some View {

        VStack(
            alignment: .leading,
            spacing: 6
        ) {

            Text("Zdroj dat")
                .font(.caption.bold())

            Text(
                "TERINOS · MV–GŘ HZS ČR"
            )
            .font(.footnote)
            .foregroundStyle(.secondary)

            Text(
                "Interní PoC · licence dat zatím nepotvrzena"
            )
            .font(.caption2)
            .foregroundStyle(.tertiary)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }

    // MARK: - Helpers

    private func number(
        _ value: Double?
    ) -> String? {

        value.map {
            $0.formatted(
                .number.grouping(.never)
            )
        }
    }
}
