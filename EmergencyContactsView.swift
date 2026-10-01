//
//  EmergencyContactsView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//

import SwiftUI

struct EmergencyContactsView: View {

    @ObservedObject private var locationStore: LocationStore

    init(
        locationStore: LocationStore? = nil
    ) {

        self._locationStore =
            ObservedObject(
                wrappedValue:
                    locationStore
                    ?? LocationStore()
            )
    }

    var body: some View {

        List {

            Section {

                emergencyRow(
                    title: "Jednotné tísňové číslo",
                    subtitle: "Když si nejste jistí, koho volat, nebo je potřeba více složek",
                    number: "112",
                    symbol: "sos"
                )

                emergencyRow(
                    title: "Hasiči",
                    subtitle: "Požár, technická pomoc, nebezpečné látky",
                    number: "150",
                    symbol: "flame.fill"
                )

                emergencyRow(
                    title: "Zdravotnická záchranná služba",
                    subtitle: "Ohrožení života nebo zdraví",
                    number: "155",
                    symbol: "cross.case.fill"
                )

                emergencyRow(
                    title: "Policie ČR",
                    subtitle: "Ohrožení bezpečnosti, trestná činnost",
                    number: "158",
                    symbol: "shield.fill"
                )

                emergencyRow(
                    title: "Městská policie",
                    subtitle: "Místní veřejný pořádek",
                    number: "156",
                    symbol: "building.columns.fill"
                )
            }

            Section(
                "Moje poloha"
            ) {

                if let coordinateText =
                    locationStore.coordinateText {

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Label(
                            "Aktuální GPS poloha",
                            systemImage: "location.fill"
                        )
                        .font(.headline)

                        Text(
                            locationStore.formattedLatitude
                        )
                        .font(
                            .system(
                                .body,
                                design: .monospaced
                            )
                        )

                        Text(
                            locationStore.formattedLongitude
                        )
                        .font(
                            .system(
                                .body,
                                design: .monospaced
                            )
                        )

                        HStack {

                            Text("Přesnost")
                                .foregroundStyle(.secondary)

                            Spacer()

                            Text(
                                locationStore
                                    .accuracyDescription
                            )
                            .fontWeight(.semibold)
                        }

                        NavigationLink {

                            MyLocationView(
                                locationStore:
                                    locationStore
                            )

                        } label: {

                            Label(
                                "Zobrazit podrobnosti polohy",
                                systemImage:
                                    "location.circle"
                            )
                        }

                        ShareLink(
                            item:
                                shareText(
                                    coordinateText
                                )
                        ) {

                            Label(
                                "Sdílet polohu",
                                systemImage:
                                    "square.and.arrow.up"
                            )
                        }
                    }
                    .padding(.vertical, 4)

                } else {

                    VStack(
                        alignment: .leading,
                        spacing: 10
                    ) {

                        Label(
                            "Poloha zatím není k dispozici",
                            systemImage:
                                "location.slash"
                        )
                        .font(.headline)

                        Text(
                            "Aktualizujte polohu, abyste mohli operátorovi tísňové linky sdělit souřadnice a jejich přibližnou přesnost."
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )

                        Button {

                            locationStore.request()

                        } label: {

                            Label(
                                locationStore.requesting
                                    ? "Zjišťuji polohu…"
                                    : "Zjistit moji polohu",
                                systemImage:
                                    "location.fill"
                            )
                        }
                        .disabled(
                            locationStore.requesting
                        )
                    }
                    .padding(.vertical, 4)
                }

                if let message =
                    locationStore.message {

                    Text(message)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Section("Při volání") {

                Label(
                    "Řekněte, co se stalo.",
                    systemImage: "1.circle.fill"
                )

                Label(
                    "Uveďte přesně, kde jste.",
                    systemImage: "2.circle.fill"
                )

                Label(
                    "Řekněte, kdo volá.",
                    systemImage: "3.circle.fill"
                )

                Label(
                    "Odpovídejte na otázky operátora a nezavěšujte jako první.",
                    systemImage: "4.circle.fill"
                )
            }

            Section {

                Text(
                    "Tísňové linky používejte pouze při skutečném ohrožení života, zdraví, majetku nebo veřejného pořádku."
                )
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(
            "Tísňové kontakty"
        )
        .task {

            if locationStore.location == nil {
                locationStore.request()
            }
        }
    }

    @ViewBuilder
    private func emergencyRow(
        title: String,
        subtitle: String,
        number: String,
        symbol: String
    ) -> some View {

        Button {

            call(number)

        } label: {

            HStack(
                spacing: 14
            ) {

                Image(
                    systemName: symbol
                )
                .font(.title2)
                .frame(width: 34)

                VStack(
                    alignment: .leading,
                    spacing: 3
                ) {

                    HStack {

                        Text(title)
                            .font(.headline)

                        Spacer()

                        Text(number)
                            .font(.title2.bold())
                    }

                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 5)
        }
        .buttonStyle(.plain)
    }

    private func call(
        _ number: String
    ) {

        guard let url =
            URL(
                string:
                    "tel://\(number)"
            )
        else {
            return
        }

        UIApplication.shared.open(
            url
        )
    }

    private func shareText(
        _ coordinateText: String
    ) -> String {

        var text =
            "Moje poloha: \(coordinateText)"

        if let accuracy =
            locationStore.horizontalAccuracy {

            text +=
                "\nPřesnost přibližně ±\(Int(accuracy.rounded())) m"
        }

        return text
    }
}
