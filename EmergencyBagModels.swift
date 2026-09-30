//
//  EmergencyBagModels.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import Foundation

enum BagItemStatus: String, Codable, CaseIterable {
    case missing
    case owned
    case packed

    var title: String {
        switch self {
        case .missing:
            return "Nemám"
        case .owned:
            return "Mám"
        case .packed:
            return "Sbaleno"
        }
    }

    var symbolName: String {
        switch self {
        case .missing:
            return "circle"
        case .owned:
            return "checkmark.circle"
        case .packed:
            return "checkmark.circle.fill"
        }
    }
}

enum BagCategory: String, CaseIterable {
    case documents = "Doklady a finance"
    case foodWater = "Jídlo a voda"
    case health = "Zdraví"
    case hygiene = "Hygiena"
    case clothing = "Oblečení"
    case sleeping = "Spaní"
    case electronics = "Elektronika"
    case children = "Děti"
    case pets = "Zvířata"
    case other = "Ostatní"
}

struct EmergencyBagItem: Identifiable, Hashable {
    let id: String
    let title: String
    let detail: String?
    let category: BagCategory
}
