//
//  HomeSuppliesModels.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import Foundation

enum HomeSupplyCategory: String, CaseIterable, Hashable {
    case water = "Voda"
    case food = "Jídlo"
    case health = "Zdraví"
    case lightCommunication = "Světlo a komunikace"
    case hygiene = "Hygiena"
    case cooking = "Vaření"
    case safety = "Bezpečnost"
    case documentsMoney = "Doklady a peníze"
    case pets = "Zvířata"
    case transport = "Doprava"
    case other = "Ostatní"
}

struct HomeSupplyItem: Identifiable, Hashable {

    let id: String
    let title: String
    let detail: String?
    let category: HomeSupplyCategory
    let quantityText: String?
}
