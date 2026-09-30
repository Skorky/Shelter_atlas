//
//  ChecklistModels.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import Foundation

enum ChecklistUrgency: String, CaseIterable, Identifiable {
    case immediate = "Hned"
    case fifteenMinutes = "15–30 min"
    case preparation = "Mám čas"

    var id: String { rawValue }
}

enum ChecklistCategory: String, CaseIterable {
    case documents = "Doklady a finance"
    case health = "Zdraví a léky"
    case hygiene = "Hygiena"
    case waterFood = "Jídlo a pití"
    case clothing = "Oblečení"
    case sleeping = "Spaní"
    case electronics = "Elektronika"
    case children = "Děti"
    case pets = "Zvířata"
    case other = "Ostatní"
}

struct ChecklistItem: Identifiable, Hashable {
    let id: String
    let title: String
    let detail: String?
    let urgency: ChecklistUrgency
    let category: ChecklistCategory
    let quantity: Int?
    let quantityText: String?
}
