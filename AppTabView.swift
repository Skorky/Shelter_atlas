//
//  AppTabView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//

import SwiftUI

struct AppTabView: View {

    var body: some View {

        TabView {

            ContentView()
                .tabItem {
                    Label(
                        "Mapa",
                        systemImage:
                            "map.fill"
                    )
                }

            FirstAidView()
                .tabItem {
                    Label(
                        "První pomoc",
                        systemImage:
                            "cross.case.fill"
                    )
                }

            PreparednessHubView()
                .tabItem {
                    Label(
                        "Příprava",
                        systemImage:
                            "backpack.fill"
                    )
                }

            GuideView()
                .tabItem {
                    Label(
                        "Příručka",
                        systemImage:
                            "book.fill"
                    )
                }

            HouseholdView()
                .tabItem {
                    Label(
                        "Profil",
                        systemImage:
                            "person.2.fill"
                    )
                }
        }
    }
}


// MARK: - Příprava

private struct PreparednessHubView: View {

    var body: some View {

        NavigationStack {

            List {

                Section {

                    NavigationLink {

                        ChecklistView()

                    } label: {

                        preparationRow(
                            title:
                                "Co vzít",
                            subtitle:
                                "Kontrolní seznam věcí pro krizovou situaci",
                            systemImage:
                                "checklist"
                        )
                    }

                    NavigationLink {

                        EmergencyBagView()

                    } label: {

                        preparationRow(
                            title:
                                "Evakuační zavazadlo",
                            subtitle:
                                "Připravte a zkontrolujte obsah zavazadla",
                            systemImage:
                                "backpack.fill"
                        )
                    }
                }

                Section {

                    Text(
                        "Seznamy se přizpůsobují údajům v profilu domácnosti."
                    )
                    .font(
                        .caption
                    )
                    .foregroundStyle(
                        .secondary
                    )
                }
            }
            .navigationTitle(
                "Příprava"
            )
        }
    }

    private func preparationRow(
        title: String,
        subtitle: String,
        systemImage: String
    ) -> some View {

        HStack(
            alignment: .top,
            spacing: 14
        ) {

            Image(
                systemName:
                    systemImage
            )
            .font(
                .title2
            )
            .frame(
                width: 32
            )

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(
                    title
                )
                .font(
                    .headline
                )

                Text(
                    subtitle
                )
                .font(
                    .caption
                )
                .foregroundStyle(
                    .secondary
                )
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
            }
        }
        .padding(
            .vertical,
            4
        )
    }
}
