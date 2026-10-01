//
//  FirstAidView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import SwiftUI

struct FirstAidView: View {

    private let primaryTopics =
        FirstAidContent.topics

    private let extendedTopics =
        FirstAidExtendedContent.topics

    private var lifeThreateningTopics: [FirstAidTopic] {

        primaryTopics.filter {
            [
                "cpr",
                "aed",
                "bleeding",
                "choking",
                "stroke",
                "chest-pain",
                "seizure"
            ]
            .contains($0.id)
        }
    }

    private var childTopics: [FirstAidTopic] {

        extendedTopics.filter {
            [
                "child-cpr",
                "infant-cpr",
                "child-choking",
                "infant-choking"
            ]
            .contains($0.id)
        }
    }

    private var injuryTopics: [FirstAidTopic] {

        let primary =
            primaryTopics.filter {
                [
                    "burn"
                ]
                .contains($0.id)
            }

        let extended =
            extendedTopics.filter {
                [
                    "poisoning",
                    "head-injury",
                    "limb-injury"
                ]
                .contains($0.id)
            }

        return primary + extended
    }

    var body: some View {

        NavigationStack {

            ScrollView {

                LazyVStack(
                    alignment: .leading,
                    spacing: 20
                ) {

                    header

                    emergencyCallCard

                    topicSection(
                        title:
                            "Život ohrožující stavy",
                        subtitle:
                            "Situace, kdy může být nutné jednat okamžitě.",
                        symbolName:
                            "exclamationmark.triangle.fill",
                        topics:
                            lifeThreateningTopics
                    )

                    topicSection(
                        title:
                            "Děti a kojenci",
                        subtitle:
                            "Postupy, které se mohou lišit od první pomoci u dospělých.",
                        symbolName:
                            "figure.and.child.holdinghands",
                        topics:
                            childTopics
                    )

                    topicSection(
                        title:
                            "Úrazy a ostatní stavy",
                        subtitle:
                            "Popáleniny, otravy a závažná poranění.",
                        symbolName:
                            "cross.case.fill",
                        topics:
                            injuryTopics
                    )

                    disclaimer
                }
                .padding()
            }
            .navigationTitle(
                "První pomoc"
            )
        }
    }

    // MARK: - Header

    private var header: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(
                "Co se právě děje?"
            )
            .font(
                .title2.bold()
            )

            Text(
                "Vyberte situaci podle hlavního problému. V bezprostředním ohrožení volejte 155."
            )
            .font(
                .callout
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

    // MARK: - Volat 155

    private var emergencyCallCard: some View {

        Button {

            call155()

        } label: {

            HStack(
                spacing: 14
            ) {

                Image(
                    systemName:
                        "phone.fill"
                )
                .font(
                    .title2
                )

                VStack(
                    alignment: .leading,
                    spacing: 3
                ) {

                    Text(
                        "Volat 155"
                    )
                    .font(
                        .headline
                    )

                    Text(
                        "Zdravotnická záchranná služba"
                    )
                    .font(
                        .caption
                    )
                    .foregroundStyle(
                        .secondary
                    )
                }

                Spacer()

                Image(
                    systemName:
                        "chevron.right"
                )
                .font(
                    .caption.bold()
                )
            }
            .padding()
            .background(
                .regularMaterial,
                in: RoundedRectangle(
                    cornerRadius: 18,
                    style: .continuous
                )
            )
        }
        .buttonStyle(
            .plain
        )
    }

    // MARK: - Sekce

    private func topicSection(
        title: String,
        subtitle: String,
        symbolName: String,
        topics: [FirstAidTopic]
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            HStack(
                alignment: .top,
                spacing: 10
            ) {

                Image(
                    systemName:
                        symbolName
                )
                .font(
                    .headline
                )

                VStack(
                    alignment: .leading,
                    spacing: 3
                ) {

                    Text(
                        title
                    )
                    .font(
                        .title2.bold()
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
                }
            }

            ForEach(
                topics
            ) { topic in

                NavigationLink {

                    FirstAidDetailView(
                        topic: topic
                    )

                } label: {

                    topicCard(
                        topic
                    )
                }
                .buttonStyle(
                    .plain
                )
            }
        }
    }

    // MARK: - Karta tématu

    @ViewBuilder
    private func topicCard(
        _ topic: FirstAidTopic
    ) -> some View {

        HStack(
            alignment: .top,
            spacing: 14
        ) {

            Image(
                systemName:
                    topic.symbolName
            )
            .font(
                .title2
            )
            .frame(
                width: 34
            )

            VStack(
                alignment: .leading,
                spacing: 5
            ) {

                Text(
                    topic.title
                )
                .font(
                    .headline
                )
                .foregroundStyle(
                    .primary
                )

                Text(
                    topic.subtitle
                )
                .font(
                    .caption
                )
                .foregroundStyle(
                    .secondary
                )

                if topic.urgent {

                    Label(
                        "Akutní",
                        systemImage:
                            "exclamationmark.triangle.fill"
                    )
                    .font(
                        .caption2.bold()
                    )
                    .foregroundStyle(
                        .orange
                    )
                }
            }

            Spacer()

            Image(
                systemName:
                    "chevron.right"
            )
            .font(
                .caption.bold()
            )
            .foregroundStyle(
                .tertiary
            )
            .padding(
                .top,
                6
            )
        }
        .padding()
        .background(
            .thinMaterial,
            in: RoundedRectangle(
                cornerRadius: 18,
                style: .continuous
            )
        )
    }

    // MARK: - Upozornění

    private var disclaimer: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Label(
                "Důležité",
                systemImage:
                    "info.circle"
            )
            .font(
                .caption.bold()
            )

            Text(
                "Postupy v aplikaci jsou rychlá pomůcka. Nenahrazují praktický kurz první pomoci ani pokyny operátora zdravotnické záchranné služby."
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
        .padding(
            .top,
            4
        )
    }

    // MARK: - Volání

    private func call155() {

        guard let url =
            URL(
                string:
                    "tel://155"
            )
        else {
            return
        }

        UIApplication.shared.open(
            url
        )
    }
}
