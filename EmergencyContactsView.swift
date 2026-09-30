//
//  EmergencyContactsView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import SwiftUI

struct EmergencyContactsView: View {

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
        .navigationTitle("Tísňové kontakty")
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
            HStack(spacing: 14) {
                Image(systemName: symbol)
                    .font(.title2)
                    .frame(width: 34)

                VStack(alignment: .leading, spacing: 3) {
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

    private func call(_ number: String) {
        guard let url = URL(string: "tel://\(number)") else {
            return
        }

        UIApplication.shared.open(url)
    }
}
