//
//  EmergencyBagEngine.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import Foundation

enum EmergencyBagEngine {

    static func makeItems(
        adults: Int,
        children: Int,
        infants: Int,
        dogs: Int,
        cats: Int,
        hasRegularMedication: Bool,
        usesGlasses: Bool,
        hasMedicalAid: Bool,
        hasDietaryNeeds: Bool,
        petMedication: Bool
    ) -> [EmergencyBagItem] {

        var items: [EmergencyBagItem] = []

        let totalPeople = adults + children + infants
        let totalPets = dogs + cats

        // MARK: Doklady a finance

        items.append(
            EmergencyBagItem(
                id: "documents",
                title: "Osobní doklady",
                detail: "Doklady členů domácnosti.",
                category: .documents
            )
        )

        items.append(
            EmergencyBagItem(
                id: "insurance",
                title: "Průkazy zdravotního pojištění",
                detail: nil,
                category: .documents
            )
        )

        items.append(
            EmergencyBagItem(
                id: "cash",
                title: "Hotovost",
                detail: "Ideálně i v menších bankovkách.",
                category: .documents
            )
        )

        items.append(
            EmergencyBagItem(
                id: "document-copies",
                title: "Kopie důležitých dokumentů",
                detail: nil,
                category: .documents
            )
        )

        // MARK: Jídlo a voda

        items.append(
            EmergencyBagItem(
                id: "water",
                title: "Pitná voda",
                detail: "Pro \(totalPeople) osob.",
                category: .foodWater
            )
        )

        items.append(
            EmergencyBagItem(
                id: "food",
                title: "Trvanlivé potraviny",
                detail: "Pro \(totalPeople) osob.",
                category: .foodWater
            )
        )

        if hasDietaryNeeds {
            items.append(
                EmergencyBagItem(
                    id: "diet-food",
                    title: "Speciální potraviny",
                    detail: "Podle dietních nebo alergických omezení.",
                    category: .foodWater
                )
            )
        }

        items.append(
            EmergencyBagItem(
                id: "cutlery",
                title: "Příbor a nádobí",
                detail: nil,
                category: .foodWater
            )
        )

        items.append(
            EmergencyBagItem(
                id: "multitool",
                title: "Multifunkční nůž / otvírák",
                detail: nil,
                category: .foodWater
            )
        )

        // MARK: Zdraví

        items.append(
            EmergencyBagItem(
                id: "first-aid-kit",
                title: "Základní lékárnička",
                detail: "Náplasti, obvazy, dezinfekce a základní vybavení.",
                category: .health
            )
        )

        if hasRegularMedication {
            items.append(
                EmergencyBagItem(
                    id: "medication",
                    title: "Pravidelně užívané léky",
                    detail: nil,
                    category: .health
                )
            )
        }

        if usesGlasses {
            items.append(
                EmergencyBagItem(
                    id: "glasses",
                    title: "Brýle / kontaktní čočky",
                    detail: nil,
                    category: .health
                )
            )
        }

        if hasMedicalAid {
            items.append(
                EmergencyBagItem(
                    id: "medical-aid",
                    title: "Zdravotní pomůcka",
                    detail: nil,
                    category: .health
                )
            )
        }

        // MARK: Hygiena

        items.append(
            EmergencyBagItem(
                id: "hygiene",
                title: "Základní hygienické potřeby",
                detail: "Kartáček, pasta, mýdlo, ručník apod.",
                category: .hygiene
            )
        )

        items.append(
            EmergencyBagItem(
                id: "toilet-paper",
                title: "Toaletní papír",
                detail: nil,
                category: .hygiene
            )
        )

        // MARK: Oblečení

        items.append(
            EmergencyBagItem(
                id: "clothing",
                title: "Náhradní oblečení",
                detail: "Pro \(totalPeople) osob.",
                category: .clothing
            )
        )

        items.append(
            EmergencyBagItem(
                id: "raincoat",
                title: "Pláštěnka / ochrana proti dešti",
                detail: nil,
                category: .clothing
            )
        )

        // MARK: Spaní

        items.append(
            EmergencyBagItem(
                id: "sleeping",
                title: "Spacák nebo deka",
                detail: "\(totalPeople) ks",
                category: .sleeping
            )
        )

        items.append(
            EmergencyBagItem(
                id: "mat",
                title: "Karimatka",
                detail: "\(totalPeople) ks",
                category: .sleeping
            )
        )

        // MARK: Elektronika

        items.append(
            EmergencyBagItem(
                id: "flashlight",
                title: "Svítilna",
                detail: nil,
                category: .electronics
            )
        )

        items.append(
            EmergencyBagItem(
                id: "powerbank",
                title: "Powerbanka",
                detail: nil,
                category: .electronics
            )
        )

        items.append(
            EmergencyBagItem(
                id: "charger",
                title: "Nabíječky",
                detail: nil,
                category: .electronics
            )
        )

        items.append(
            EmergencyBagItem(
                id: "radio",
                title: "Rádio na baterie",
                detail: nil,
                category: .electronics
            )
        )

        items.append(
            EmergencyBagItem(
                id: "batteries",
                title: "Náhradní baterie",
                detail: nil,
                category: .electronics
            )
        )

        // MARK: Děti

        if children > 0 {
            items.append(
                EmergencyBagItem(
                    id: "children-comfort",
                    title: "Oblíbená hračka / uklidňující předmět",
                    detail: nil,
                    category: .children
                )
            )
        }

        if infants > 0 {
            items.append(
                EmergencyBagItem(
                    id: "diapers",
                    title: "Pleny",
                    detail: "Pro \(infants) kojence.",
                    category: .children
                )
            )

            items.append(
                EmergencyBagItem(
                    id: "baby-food",
                    title: "Kojenecká výživa",
                    detail: nil,
                    category: .children
                )
            )
        }

        // MARK: Zvířata

        if totalPets > 0 {
            items.append(
                EmergencyBagItem(
                    id: "pet-food",
                    title: "Krmivo pro zvířata",
                    detail: "Pro \(totalPets) zvířat.",
                    category: .pets
                )
            )

            items.append(
                EmergencyBagItem(
                    id: "pet-water",
                    title: "Voda pro zvířata",
                    detail: nil,
                    category: .pets
                )
            )

            items.append(
                EmergencyBagItem(
                    id: "pet-bowls",
                    title: "Misky",
                    detail: nil,
                    category: .pets
                )
            )

            items.append(
                EmergencyBagItem(
                    id: "pet-documents",
                    title: "Dokumenty zvířete",
                    detail: "Očkovací průkaz / pet pas.",
                    category: .pets
                )
            )
        }

        if dogs > 0 {
            items.append(
                EmergencyBagItem(
                    id: "dog-leash",
                    title: "Vodítko a náhubek",
                    detail: nil,
                    category: .pets
                )
            )
        }

        if cats > 0 {
            items.append(
                EmergencyBagItem(
                    id: "cat-carrier",
                    title: "Přepravka pro kočku",
                    detail: nil,
                    category: .pets
                )
            )
        }

        if petMedication && totalPets > 0 {
            items.append(
                EmergencyBagItem(
                    id: "pet-medication",
                    title: "Léky pro zvíře",
                    detail: nil,
                    category: .pets
                )
            )
        }

        // MARK: Ostatní

        items.append(
            EmergencyBagItem(
                id: "contacts",
                title: "Důležité kontakty na papíře",
                detail: nil,
                category: .other
            )
        )

        items.append(
            EmergencyBagItem(
                id: "pen-paper",
                title: "Tužka a papír",
                detail: nil,
                category: .other
            )
        )

        items.append(
            EmergencyBagItem(
                id: "bag-label",
                title: "Označení zavazadla",
                detail: "Jméno, adresa a telefon.",
                category: .other
            )
        )

        return items
    }
}
