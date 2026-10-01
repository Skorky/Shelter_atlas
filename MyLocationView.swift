//
//  MyLocationView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import SwiftUI
import CoreLocation
import UIKit

struct MyLocationView: View {

    @ObservedObject var locationStore: LocationStore

    @State private var copied = false

    var body: some View {

        List {

            Section {

                VStack(
                    alignment: .leading,
                    spacing: 16
                ) {

                    HStack {

                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {

                            Text("Moje poloha")
                                .font(.title2.bold())

                            Text(
                                locationStore.isLocationFresh
                                ? "Aktuální GPS poloha"
                                : "Poloha není aktuální"
                            )
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Image(
                            systemName:
                                locationStore.location == nil
                                ? "location.slash"
                                : "location.fill"
                        )
                        .font(.title2)
                    }

                    if let location =
                        locationStore.location {

                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {

                            Text(
                                locationStore.formattedLatitude
                            )
                            .font(
                                .system(
                                    .title3,
                                    design: .monospaced
                                )
                            )

                            Text(
                                locationStore.formattedLongitude
                            )
                            .font(
                                .system(
                                    .title3,
                                    design: .monospaced
                                )
                            )
                        }

                        Divider()

                        LabeledContent(
                            "Přesnost"
                        ) {

                            VStack(
                                alignment: .trailing,
                                spacing: 2
                            ) {

                                Text(
                                    locationStore
                                        .accuracyDescription
                                )
                                .font(.headline)

                                Text(
                                    locationStore
                                        .accuracyLabel
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }

                        LabeledContent(
                            "Nadmořská výška"
                        ) {

                            VStack(
                                alignment: .trailing,
                                spacing: 2
                            ) {

                                Text(
                                    locationStore
                                        .formattedAltitude
                                )

                                if let vertical =
                                    locationStore
                                        .formattedVerticalAccuracy {

                                    Text(
                                        "přesnost \(vertical)"
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        }

                        LabeledContent(
                            "Aktualizováno"
                        ) {

                            Text(
                                location.timestamp.formatted(
                                    date: .omitted,
                                    time: .standard
                                )
                            )
                        }

                    } else {

                        Text(
                            "Souřadnice zatím nejsou k dispozici."
                        )
                        .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 6)
            }

            Section {

                Button {

                    locationStore.request()

                } label: {

                    Label(
                        locationStore.requesting
                            ? "Zjišťuji polohu…"
                            : "Aktualizovat polohu",
                        systemImage: "location.fill"
                    )
                }
                .disabled(
                    locationStore.requesting
                )

                if let coordinateText =
                    locationStore.coordinateText {

                    Button {

                        UIPasteboard.general.string =
                            coordinateText

                        copied = true

                    } label: {

                        Label(
                            copied
                                ? "Souřadnice zkopírovány"
                                : "Kopírovat souřadnice",
                            systemImage:
                                copied
                                ? "checkmark"
                                : "doc.on.doc"
                        )
                    }

                    ShareLink(
                        item: shareText(
                            coordinateText
                        )
                    ) {

                        Label(
                            "Sdílet polohu",
                            systemImage: "square.and.arrow.up"
                        )
                    }
                }
            }

            if let message =
                locationStore.message {

                Section {

                    Label(
                        message,
                        systemImage:
                            "exclamationmark.triangle"
                    )
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
            }

            Section {

                VStack(
                    alignment: .leading,
                    spacing: 6
                ) {

                    Text("Důležité")
                        .font(.headline)

                    Text(
                        "Přesnost GPS závisí na zařízení a okolních podmínkách. V budovách, mezi vysokými domy nebo při slabém signálu může být poloha výrazně méně přesná."
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)

                    Text(
                        "Při volání na tísňovou linku se vždy řiďte pokyny operátora."
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle(
            "Moje poloha"
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
        .task {

            if locationStore.location == nil {
                locationStore.request()
            }
        }
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

        if let altitude =
            locationStore.altitude {

            text +=
                "\nNadmořská výška přibližně \(Int(altitude.rounded())) m"
        }

        return text
    }
}
