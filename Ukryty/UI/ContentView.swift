//
//  Untitled.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import SwiftUI
import MapKit

@MainActor
private final class MapViewState: ObservableObject {

    @Published var camera: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: .init(
                latitude: 49.8,
                longitude: 15.5
            ),
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

    // Celý spodní informační panel.
    @State private var isLocationBannerExpanded = true

    // Viditelná oblast mapy pro filtrování markerů.
    @State private var visibleRegion: MKCoordinateRegion?

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

                ForEach(visibleShelters) { shelter in

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

            // MARK: - Ovládání mapy

            .mapControls {
                MapCompass()
                MapScaleView()
            }

            // Přepočítáme markery až po dokončení pohybu mapy.
            .onMapCameraChange(
                frequency: .onEnd
            ) { context in

                visibleRegion = context.region
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

            // MARK: - Rozbalený spodní panel

            .safeAreaInset(
                edge: .bottom,
                spacing: 8
            ) {

                if isLocationBannerExpanded {

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        dataStatus

                        expandedLocationBanner
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
                    .transition(
                        .move(edge: .bottom)
                        .combined(with: .opacity)
                    )
                }
            }

            // MARK: - Minimalizované plovoucí kolečko

            .overlay(
                alignment: .bottomTrailing
            ) {

                if !isLocationBannerExpanded {

                    collapsedLocationButton
                        .padding(.trailing, 20)

                        // Umístění nad spodní TabView lištu.
                        .padding(.bottom, 82)

                        .transition(
                            .scale(scale: 0.7)
                            .combined(with: .opacity)
                        )
                }
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

                    // Jakmile máme polohu,
                    // celý spodní panel minimalizujeme.
                    withAnimation(
                        .spring(
                            response: 0.35,
                            dampingFraction: 0.85
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

            // MARK: - Načtení TERINOS

            .task {

                // Pokud existuje disková cache,
                // zůstane zobrazena a současně
                // obnovíme TERINOS ze sítě.
                if !store.loading {

                    store.load()
                }
            }
        }
    }

    // MARK: - Úkryty viditelné v aktuální oblasti

    private var visibleShelters: [Shelter] {

        guard let shelters =
            store.snapshot?.shelters
        else {
            return []
        }

        guard let region =
            visibleRegion
        else {
            return shelters
        }

        let latitudePadding =
            region.span.latitudeDelta * 0.25

        let longitudePadding =
            region.span.longitudeDelta * 0.25

        let minLatitude =
            region.center.latitude
            - region.span.latitudeDelta / 2
            - latitudePadding

        let maxLatitude =
            region.center.latitude
            + region.span.latitudeDelta / 2
            + latitudePadding

        let minLongitude =
            region.center.longitude
            - region.span.longitudeDelta / 2
            - longitudePadding

        let maxLongitude =
            region.center.longitude
            + region.span.longitudeDelta / 2
            + longitudePadding

        return shelters.filter { shelter in

            let coordinate =
                shelter.coordinate

            return
                coordinate.latitude >= minLatitude &&
                coordinate.latitude <= maxLatitude &&
                coordinate.longitude >= minLongitude &&
                coordinate.longitude <= maxLongitude
        }
    }

    // MARK: - Rozbalený GPS panel

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

                // Tohle schová CELÝ spodní panel.
                Button {

                    withAnimation(
                        .spring(
                            response: 0.35,
                            dampingFraction: 0.85
                        )
                    ) {

                        isLocationBannerExpanded = false
                    }

                } label: {

                    Image(
                        systemName: "chevron.down"
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
                    "Minimalizovat spodní panel"
                )
            }

            if let position =
                location.location {

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

            if let message =
                location.message {

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
    }

    // MARK: - Minimalizované kolečko

    private var collapsedLocationButton: some View {

        Button {

            withAnimation(
                .spring(
                    response: 0.35,
                    dampingFraction: 0.85
                )
            ) {

                isLocationBannerExpanded = true
            }

        } label: {

            Image(
                systemName: "location.fill"
            )
            .font(
                .system(
                    size: 19,
                    weight: .semibold
                )
            )
            .frame(
                width: 54,
                height: 54
            )
            .background(
                .regularMaterial,
                in: Circle()
            )
            .contentShape(
                Circle()
            )
            .shadow(
                radius: 7,
                y: 3
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            "Zobrazit spodní informační panel"
        )
    }

    // MARK: - Stav dat a nejbližší úkryt

    @ViewBuilder
    private var dataStatus: some View {

        if store.loading,
           store.snapshot == nil {

            ProgressView(
                "Načítám evidované úkryty z TERINOS…"
            )

        } else if let error =
                    store.error,
                  store.snapshot == nil {

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

                HStack(
                    spacing: 8
                ) {

                    Text(
                        "\(snapshot.shelters.count) bodů · načteno \(snapshot.loadedAt.formatted(date: .omitted, time: .shortened))"
                    )
                    .font(.caption)
                    .foregroundStyle(
                        .secondary
                    )

                    if store.loading {

                        ProgressView()
                            .controlSize(.mini)
                    }
                }

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

                if let error =
                    store.error {

                    Label(
                        "Aktualizace se nepodařila. Zobrazují se poslední dostupná data.",
                        systemImage:
                            "exclamationmark.triangle"
                    )
                    .font(.caption)
                    .foregroundStyle(
                        .secondary
                    )

                    Text(error)
                        .font(.caption2)
                        .foregroundStyle(
                            .tertiary
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
                                horizontal: false,
                                vertical: true
                            )
                        }
                    }

                } else {

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
                            latitude: 50.083,
                            longitude: 14.426
                        ),
                        span: .init(
                            latitudeDelta: 0.06,
                            longitudeDelta: 0.06
                        )
                    )
                )
        }
    }
}
