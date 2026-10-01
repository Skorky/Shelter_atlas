//
//  FirstAidArticleView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import SwiftUI

struct FirstAidArticleView: View {

    let topic: FirstAidTopic

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 24
            ) {

                header

                emergencyCallCard

                quickSummary

                if !topic.articleSections.isEmpty {

                    ForEach(
                        topic.articleSections
                    ) { section in

                        articleSection(
                            section
                        )
                    }
                }

                if !topic.warnings.isEmpty {

                    warningsSection
                }

                sourceSection

                disclaimer
            }
            .padding()
        }
        .navigationTitle(
            topic.title
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }

    // MARK: - Header

    private var header: some View {

        HStack(
            alignment: .top,
            spacing: 14
        ) {

            Image(
                systemName:
                    topic.symbolName
            )
            .font(
                .system(
                    size: 34
                )
            )
            .frame(
                width: 44
            )

            VStack(
                alignment: .leading,
                spacing: 5
            ) {

                Text(
                    topic.title
                )
                .font(
                    .title.bold()
                )

                Text(
                    topic.subtitle
                )
                .font(
                    .subheadline
                )
                .foregroundStyle(
                    .secondary
                )

                if topic.urgent {

                    Label(
                        "Akutní stav",
                        systemImage:
                            "exclamationmark.triangle.fill"
                    )
                    .font(
                        .caption.bold()
                    )
                    .foregroundStyle(
                        .orange
                    )
                    .padding(
                        .top,
                        2
                    )
                }
            }

            Spacer()
        }
    }

    // MARK: - Tísňová linka

    @ViewBuilder
    private var emergencyCallCard: some View {

        if let number =
            topic.emergencyNumber {

            Button {

                call(
                    number
                )

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
                            "Volat \(number)"
                        )
                        .font(
                            .headline
                        )

                        Text(
                            number == "155"
                                ? "Zdravotnická záchranná služba"
                                : "Tísňová linka"
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
    }

    // MARK: - Rychlé shrnutí

    private var quickSummary: some View {

        VStack(
            alignment: .leading,
            spacing: 14
        ) {

            Label(
                "Rychlý postup",
                systemImage:
                    "bolt.fill"
            )
            .font(
                .title2.bold()
            )

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
                    .font(
                        .caption.bold()
                    )
                    .frame(
                        width: 30,
                        height: 30
                    )
                    .background(
                        .thinMaterial,
                        in: Circle()
                    )

                    Text(
                        step
                    )
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                    Spacer(
                        minLength: 0
                    )
                }
            }
        }
        .padding()
        .background(
            .thinMaterial,
            in: RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
        )
    }

    // MARK: - Podrobná kapitola

    private func articleSection(
        _ section: FirstAidArticleSection
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text(
                section.title
            )
            .font(
                .title2.bold()
            )

            ForEach(
                Array(
                    section.paragraphs.enumerated()
                ),
                id: \.offset
            ) { _, paragraph in

                Text(
                    paragraph
                )
                .font(
                    .body
                )
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
            }
        }
    }

    // MARK: - Varování

    private var warningsSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Label(
                "Na co si dát pozor",
                systemImage:
                    "exclamationmark.triangle.fill"
            )
            .font(
                .title2.bold()
            )
            .foregroundStyle(
                .orange
            )

            ForEach(
                topic.warnings,
                id: \.self
            ) { warning in

                HStack(
                    alignment: .top,
                    spacing: 10
                ) {

                    Image(
                        systemName:
                            "exclamationmark.circle"
                    )
                    .foregroundStyle(
                        .orange
                    )
                    .padding(
                        .top,
                        2
                    )

                    Text(
                        warning
                    )
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                    Spacer(
                        minLength: 0
                    )
                }
            }
        }
        .padding()
        .background(
            Color.orange
                .opacity(0.08),
            in: RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
        )
    }

    // MARK: - Zdroj

    private var sourceSection: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Label(
                "Zdroj",
                systemImage:
                    "checkmark.seal"
            )
            .font(
                .headline
            )

            Text(
                topic.sourceName
            )
            .font(
                .callout
            )
            .foregroundStyle(
                .secondary
            )

            if let sourceURL =
                topic.sourceURL,
               let url =
                URL(
                    string:
                        sourceURL
                ) {

                Link(
                    destination:
                        url
                ) {

                    Label(
                        "Otevřít oficiální zdroj",
                        systemImage:
                            "safari"
                    )
                }
                .font(
                    .callout.bold()
                )
            }

            Label(
                "Postup je v aplikaci dostupný i bez připojení k internetu.",
                systemImage:
                    "internaldrive"
            )
            .font(
                .caption
            )
            .foregroundStyle(
                .secondary
            )
            .padding(
                .top,
                4
            )
        }
    }

    // MARK: - Upozornění

    private var disclaimer: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(
                "Důležité"
            )
            .font(
                .caption.bold()
            )

            Text(
                "Tato část aplikace slouží jako rychlá pomůcka pro první pomoc. Nenahrazuje odborný kurz, zdravotnické vyšetření ani pokyny operátora tísňové linky. V akutní situaci se řiďte především pokyny operátora 155."
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
            8
        )
    }

    // MARK: - Volání

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
