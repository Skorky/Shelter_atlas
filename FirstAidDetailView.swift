//
//  FirstAidDetailView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import SwiftUI

struct FirstAidDetailView: View {

    let topic: FirstAidTopic

    var body: some View {

        List {

            Section {

                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {

                    Label(
                        topic.title,
                        systemImage:
                            topic.symbolName
                    )
                    .font(.title2.bold())

                    Text(
                        topic.subtitle
                    )
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }

            if let number =
                topic.emergencyNumber {

                Section {

                    Button {

                        call(number)

                    } label: {

                        Label(
                            "Volat \(number)",
                            systemImage:
                                "phone.fill"
                        )
                        .font(.headline)
                    }
                }
            }

            Section(
                "Rychlý postup"
            ) {

                ForEach(
                    Array(
                        topic.steps.enumerated()
                    ),
                    id: \.offset
                ) { index, step in

                    HStack(
                        alignment: .top,
                        spacing: 12
                    ) {

                        Text(
                            "\(index + 1)"
                        )
                        .font(.caption.bold())
                        .frame(
                            width: 28,
                            height: 28
                        )
                        .background(
                            .thinMaterial,
                            in: Circle()
                        )

                        Text(step)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                    }
                    .padding(
                        .vertical,
                        2
                    )
                }
            }

            if !topic.warnings.isEmpty {

                Section(
                    "Důležité"
                ) {

                    ForEach(
                        topic.warnings,
                        id: \.self
                    ) { warning in

                        Label(
                            warning,
                            systemImage:
                                "exclamationmark.triangle"
                        )
                        .font(.callout)
                    }
                }
            }

            Section {

                NavigationLink {

                    FirstAidArticleView(
                        topic: topic
                    )

                } label: {

                    Label(
                        "Chci vědět víc",
                        systemImage:
                            "book.pages.fill"
                    )
                    .font(.headline)
                }
            }

            Section {

                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {

                    Text("Zdroj")
                        .font(.caption.bold())

                    Text(
                        topic.sourceName
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)

                    Text(
                        "Obsah je dostupný offline."
                    )
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                }
            }
        }
        .navigationTitle(
            topic.title
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
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
}
