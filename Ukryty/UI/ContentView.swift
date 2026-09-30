import SwiftUI
import MapKit

@MainActor
private final class MapViewState: ObservableObject {
    @Published var camera: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: .init(latitude: 49.8, longitude: 15.5),
            span: .init(
                latitudeDelta: 3.3,
                longitudeDelta: 6.5
            )
        )
    )

    @Published var selectedID: Int?
    @Published var detail: Shelter?
}

struct ContentView: View {

    @StateObject private var store = ShelterStore()
    @StateObject private var location = LocationStore()
    @StateObject private var mapState = MapViewState()

    // Schováváme pouze GPS banner,
    // nikoli celou spodní kartu.
    @State private var isLocationBannerExpanded = true

    @Environment(\.scenePhase) private var scenePhase

    private static let country = MKCoordinateRegion(
        center: .init(
            latitude: 49.8,
            longitude: 15.5
        ),
        span: .init(
            latitudeDelta: 3.3,
            longitudeDelta: 6.5
        )
    )

    var body: some View {
        NavigationStack {

            Map(
                position: $mapState.camera,
                selection: $mapState.selectedID
            ) {

                UserAnnotation()

                ForEach(
                    store.snapshot?.shelters ?? []
                ) { shelter in

                    Marker(
                        shelter.title,
                        systemImage: "building.2",
                        coordinate: shelter.coordinate
                    )
                    .tint(
                        store.demo
                        ? .orange
                        : .blue
                    )
                    .tag(shelter.id)
                }
            }

            .mapControls {
                MapCompass()
                MapScaleView()
            }

            // MARK: - Horní informační pruh

            .safeAreaInset(
                edge: .top,
                spacing: 0
            ) {

                Text(
                    store.demo
                    ? "DEMO · Fiktivní body, nepoužívat k ukrytí"
                    : "Interní PoC · Evidence nepotvrzuje zpřístupnění úkrytu"
                )
                .font(.caption)
                .frame(
                    maxWidth: .infinity
                )
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    store.demo
                    ? Color.orange.opacity(0.95)
                    : Color(
                        uiColor: .secondarySystemBackground
                    )
                )
            }

            // MARK: - Spodní karta

            .safeAreaInset(
                edge: .bottom,
                spacing: 8
            ) {

                VStack(
                    alignment: .leading,
                    spacing: 12
                ) {

                    // TERINOS + nejbližší úkryt
                    dataStatus

                    // MARK: GPS banner

                    if isLocationBannerExpanded {

                        expandedLocationBanner

                    } else {

                        HStack {
                            Spacer()

                            collapsedLocationPill
                        }
                    }
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
                .padding(.horizontal, 16)
                .padding(.bottom, 68)
            }

            .navigationTitle("Úkryty")
            .navigationBarTitleDisplayMode(.inline)

            // MARK: - Toolbar

            .toolbar {

                ToolbarItemGroup(
                    placement: .topBarTrailing
                ) {

                    NavigationLink {
                        EmergencyContactsView()
                    } label: {
                        Image(
                            systemName: "phone.fill"
                        )
                    }

                    Menu {

                        Button(
                            "Načíst TERINOS znovu",
                            systemImage: "arrow.clockwise"
                        ) {
                            reset(
                                demo: false
                            )
                        }

                        Button(
                            "Zobrazit demonstrační data",
                            systemImage: "testtube.2"
                        ) {
                            reset(
                                demo: true
                            )
                        }

                        Button(
                            "Zobrazit celou ČR",
                            systemImage: "map"
                        ) {
                            mapState.camera = .region(
                                Self.country
                            )
                        }

                    } label: {

                        Label(
                            "Možnosti",
                            systemImage: "ellipsis.circle"
                        )
                    }
                }
            }

            // MARK: - Detail úkrytu

            .sheet(
                item: $mapState.detail,
                onDismiss: {
                    mapState.selectedID = nil
                }
            ) { shelter in

                ShelterDetail(
                    shelter: shelter,
                    demo: store.demo
                )
            }

            // MARK: - Výběr bodu na mapě

            .onChange(
                of: mapState.selectedID
            ) { _, id in

                mapState.detail =
                    store.snapshot?
                    .shelters
                    .first {
                        $0.id == id
                    }
            }

            // MARK: - GPS

            .onChange(
                of: location.location
            ) { _, value in

                if let value {

                    mapState.camera = .region(
                        .init(
                            center: value.coordinate,
                            span: .init(
                                latitudeDelta: 0.04,
                                longitudeDelta: 0.04
                            )
                        )
                    )

                    // Po získání polohy
                    // schováme pouze GPS banner.
                    withAnimation(
                        .easeInOut(
                            duration: 0.25
                        )
                    ) {
                        isLocationBannerExpanded = false
                    }
                }
            }

            .onChange(
                of: scenePhase
            ) { _, phase in

                if phase == .active,
                   location.location != nil {

                    location.request()
                }
            }

            .task {

                if store.snapshot == nil &&
                    !store.loading {

                    store.load()
                }
            }
        }
    }

    // MARK: - Rozbalený GPS banner

    private var expandedLocationBanner: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            HStack {

                Label(
                    location.location == nil
                    ? "Poloha"
                    : "Aktuální poloha",
                    systemImage: "location.fill"
                )
                .font(.headline)

                Spacer()

                Button {
                    withAnimation(
                        .easeInOut(
                            duration: 0.2
                        )
                    ) {
                        isLocationBannerExpanded = false
                    }
                } label: {

                    Image(
                        systemName: "chevron.right"
                    )
                    .font(
                        .subheadline.bold()
                    )
                    .frame(
                        width: 36,
                        height: 36
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(
                    "Skrýt informace o poloze"
                )
            }

            if let position = location.location {

                Text(
                    "Poloha je dostupná s přesností přibližně ±\(Int(position.horizontalAccuracy)) m."
                )
                .font(.callout)
                .foregroundStyle(.secondary)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )

            } else {

                Text(
                    "Povolte polohu pro výpočet nejbližšího evidovaného úkrytu."
                )
                .font(.callout)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
            }

            if let message = location.message {

                Text(message)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                if location.status == .denied {

                    Button(
                        "Otevřít Nastavení"
                    ) {

                        if let url = URL(
                            string:
                                UIApplication
                                .openSettingsURLString
                        ) {
                            UIApplication
                                .shared
                                .open(url)
                        }
                    }
                }
            }

            Button {
                location.request()
            } label: {

                Label(
                    location.requesting
                    ? "Zjišťuji polohu…"
                    : "Aktualizovat moji polohu",
                    systemImage: "location.fill"
                )
                .fontWeight(.medium)
            }
            .disabled(
                location.requesting
            )
        }
        .padding(14)
        .background(
            .thinMaterial,
            in: RoundedRectangle(
                cornerRadius: 16,
                style: .continuous
            )
        )
        .transition(
            .move(
                edge: .trailing
            )
            .combined(
                with: .opacity
            )
        )
    }

    // MARK: - Sbalená GPS pill

    private var collapsedLocationPill: some View {

        Button {

            withAnimation(
                .easeInOut(
                    duration: 0.2
                )
            ) {
                isLocationBannerExpanded = true
            }

        } label: {

            HStack(
                spacing: 7
            ) {

                Image(
                    systemName: "location.fill"
                )

                if let position =
                    location.location {

                    Text(
                        "±\(Int(position.horizontalAccuracy)) m"
                    )

                } else {

                    Text("Poloha")
                }

                Image(
                    systemName: "chevron.left"
                )
                .font(.caption.bold())
            }
            .font(
                .subheadline.weight(
                    .medium
                )
            )
            .padding(
                .horizontal,
                14
            )
            .frame(
                minHeight: 44
            )
            .background(
                .thinMaterial,
                in: Capsule()
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            "Zobrazit informace o poloze"
        )
        .transition(
            .move(
                edge: .trailing
            )
            .combined(
                with: .opacity
            )
        )
    }

    // MARK: - Stav dat a nejbližší úkryt

    @ViewBuilder
    private var dataStatus: some View {

        if store.loading {

            ProgressView(
                "Načítám evidované úkryty z TERINOS…"
            )

        } else if let error =
                    store.error {

            VStack(
                alignment: .leading,
                spacing: 8
            ) {

                Label(
                    error,
                    systemImage:
                        "exclamationmark.triangle"
                )
                .font(.callout)

                Button(
                    "Zkusit znovu"
                ) {
                    store.load()
                }
            }

        } else if let snapshot =
                    store.snapshot {

            VStack(
                alignment: .leading,
                spacing: 8
            ) {

                Text(
                    "\(snapshot.shelters.count) bodů · načteno \(snapshot.loadedAt.formatted(date: .omitted, time: .shortened))"
                )
                .font(.caption)
                .foregroundStyle(
                    .secondary
                )

                if snapshot.omittedCount > 0 {

                    Text(
                        "\(snapshot.omittedCount) záznamů nemá použitelné souřadnice. Nejbližší bod vybíráme pouze ze zobrazených záznamů."
                    )
                    .font(.caption)
                    .foregroundStyle(
                        .secondary
                    )
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )
                }

                if snapshot.shelters.isEmpty {

                    Text(
                        "Služba nevrátila žádné zobrazitelné úkryty."
                    )

                } else if let position =
                            location.location {

                    TimelineView(
                        .periodic(
                            from: .now,
                            by: 15
                        )
                    ) { context in

                        if context.date
                            .timeIntervalSince(
                                position.timestamp
                            ) < 120 {

                            if let nearest =
                                Shelter.nearest(
                                    in:
                                        snapshot
                                        .shelters,
                                    to:
                                        position
                                ) {

                                nearestShelterCard(
                                    nearest:
                                        nearest,
                                    position:
                                        position
                                )
                            }

                        } else {

                            Text(
                                "Poloha je starší než 2 minuty. Aktualizujte ji pro určení nejbližšího evidovaného úkrytu."
                            )
                            .font(.callout)
                            .foregroundStyle(
                                .secondary
                            )
                            .fixedSize(
                                horizontal:
                                    false,
                                vertical:
                                    true
                            )
                        }
                    }

                } else {

                    // Když není GPS,
                    // necháme kartu stručnou.
                    Text(
                        "Klepnutím na bod v mapě zobrazíte detail úkrytu."
                    )
                    .font(.callout)
                    .foregroundStyle(
                        .secondary
                    )
                }
            }
        }
    }

    // MARK: - Nejbližší úkryt

    @ViewBuilder
    private func nearestShelterCard(
        nearest: Shelter,
        position: CLLocation
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(
                store.demo
                ? "Nejbližší fiktivní ukázka"
                : "Nejbližší evidovaný úkryt"
            )
            .font(.headline)

            Text(
                nearest.title
            )
            .font(.title3)
            .fontWeight(
                .semibold
            )
            .fixedSize(
                horizontal: false,
                vertical: true
            )

            HStack(
                alignment:
                    .firstTextBaseline,
                spacing: 8
            ) {

                Text(
                    "\(nearest.distance(from: position).formatted(.number.precision(.fractionLength(0)))) m vzdušnou čarou"
                )
                .font(.subheadline)
                .fontWeight(
                    .medium
                )

                Spacer()

                Button {

                    mapState.detail =
                        nearest

                } label: {

                    Label(
                        "Detail",
                        systemImage:
                            "arrow.right"
                    )
                    .labelStyle(
                        .titleAndIcon
                    )
                }
                .buttonStyle(.plain)
            }

            Text(
                "Přesnost polohy přibližně ±\(Int(position.horizontalAccuracy)) m. Vzdálenost není délka pěší trasy."
            )
            .font(.caption)
            .foregroundStyle(
                .secondary
            )
            .fixedSize(
                horizontal: false,
                vertical: true
            )
        }
    }

    // MARK: - Reset

    private func reset(
        demo: Bool
    ) {

        mapState.selectedID = nil
        mapState.detail = nil

        store.load(
            demo: demo
        )

        if demo {

            mapState.camera =
                .region(
                    .init(
                        center: .init(
                            latitude:
                                50.083,
                            longitude:
                                14.426
                        ),
                        span: .init(
                            latitudeDelta:
                                0.06,
                            longitudeDelta:
                                0.06
                        )
                    )
                )
        }
    }
}
