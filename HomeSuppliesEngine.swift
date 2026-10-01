//
//  HomeSuppliesEngine.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import Foundation

enum HomeSuppliesEngine {

    static func makeItems(
        adults: Int,
        children: Int,
        infants: Int,
        dogs: Int,
        cats: Int,
        hasRegularMedication: Bool,
        hasMedicalAid: Bool,
        hasDietaryNeeds: Bool,
        petMedication: Bool
    ) -> [HomeSupplyItem] {

        let people =
            max(
                adults +
                children +
                infants,
                1
            )

        var items: [HomeSupplyItem] = [

            HomeSupplyItem(
                id: "water-drinking",
                title: "Balená pitná voda",
                detail:
                    "Nouzová zásoba pro celou domácnost.",
                category: .water,
                quantityText:
                    "min. 2 l / osoba / den"
            ),

            HomeSupplyItem(
                id: "water-containers",
                title: "Nádoby na vodu",
                detail:
                    "Kanystry nebo jiné uzavíratelné nádoby pro odběr vody.",
                category: .water,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "food",
                title: "Trvanlivé jídlo",
                detail:
                    "Potraviny, které lze skladovat dlouhodobě a ideálně jíst i bez složité přípravy.",
                category: .food,
                quantityText:
                    "pro \(people) os. / 72 h"
            ),

            HomeSupplyItem(
                id: "first-aid",
                title: "Lékárnička",
                detail: nil,
                category: .health,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "radio",
                title: "Rádio na baterie",
                detail:
                    "Pro příjem informací při výpadku elektřiny a internetu.",
                category:
                    .lightCommunication,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "flashlight",
                title: "Svítilna",
                detail:
                    "Ideálně na baterie.",
                category:
                    .lightCommunication,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "batteries",
                title: "Náhradní baterie",
                detail:
                    "Pro rádio, svítilny a další zařízení.",
                category:
                    .lightCommunication,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "powerbank",
                title: "Nabitá powerbanka",
                detail:
                    "Pravidelně kontrolujte její stav nabití.",
                category:
                    .lightCommunication,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "cash",
                title: "Hotovost",
                detail:
                    "Mince a bankovky různých hodnot pro případ nefunkčních platebních terminálů a bankomatů.",
                category:
                    .documentsMoney,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "documents",
                title: "Kopie důležitých dokumentů",
                detail:
                    "Uložte je na bezpečné a dostupné místo.",
                category:
                    .documentsMoney,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "cooker",
                title: "Plynový vařič a zápalky",
                detail:
                    "Používejte pouze způsobem a v prostoru, který odpovídá bezpečnostním pokynům výrobce.",
                category: .cooking,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "hand-sanitizer",
                title: "Dezinfekce na ruce",
                detail: nil,
                category: .hygiene,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "toilet-paper",
                title: "Toaletní papír a hygienické potřeby",
                detail: nil,
                category: .hygiene,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "trash-bags",
                title: "Pytle na odpadky",
                detail:
                    "Mohou pomoci i při nouzovém řešení nefunkční toalety.",
                category: .hygiene,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "knife",
                title: "Multifunkční nůž",
                detail: nil,
                category: .other,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "tape",
                title: "Pevná lepicí páska",
                detail: nil,
                category: .other,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "fire-extinguisher",
                title: "Hasicí přístroj nebo hasicí deka",
                detail: nil,
                category: .safety,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "detectors",
                title: "Autonomní detektory kouře a plynů",
                detail:
                    "Například detektor kouře nebo oxidu uhelnatého podle vybavení domácnosti.",
                category: .safety,
                quantityText: nil
            ),

            HomeSupplyItem(
                id: "vehicle",
                title: "Připravené auto",
                detail:
                    "Plná nádrž, případně dostatečně nabitá baterie elektromobilu.",
                category: .transport,
                quantityText: nil
            )
        ]

        if hasRegularMedication {

            items.append(
                HomeSupplyItem(
                    id: "regular-medication",
                    title: "Pravidelně užívané léky",
                    detail:
                        "Mějte doma potřebné léky s dostatečnou rezervou.",
                    category: .health,
                    quantityText: "alespoň na týden"
                )
            )
        }

        if hasMedicalAid {

            items.append(
                HomeSupplyItem(
                    id: "medical-aid",
                    title: "Zdravotní pomůcka a příslušenství",
                    detail:
                        "Nezapomeňte na náhradní baterie, nabíjení nebo spotřební materiál podle pomůcky.",
                    category: .health,
                    quantityText: nil
                )
            )
        }

        if hasDietaryNeeds {

            items.append(
                HomeSupplyItem(
                    id: "diet-food",
                    title: "Jídlo odpovídající dietním potřebám",
                    detail:
                        "Mějte zásobu potravin vhodných pro členy domácnosti s dietním omezením.",
                    category: .food,
                    quantityText: "na 72 h"
                )
            )
        }

        if dogs + cats > 0 {

            items.append(
                HomeSupplyItem(
                    id: "pet-food",
                    title: "Krmivo pro zvířata",
                    detail:
                        "Zásoba pro všechny domácí mazlíčky.",
                    category: .pets,
                    quantityText: "na 72 h"
                )
            )
        }

        if petMedication {

            items.append(
                HomeSupplyItem(
                    id: "pet-medication",
                    title: "Léky pro zvířata",
                    detail:
                        "Pravidelně užívané léky a potřebné pomůcky.",
                    category: .pets,
                    quantityText: nil
                )
            )
        }

        return items
    }
}
