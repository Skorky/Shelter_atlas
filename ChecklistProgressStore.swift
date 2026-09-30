//
//  Untitled.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import Foundation

@MainActor
final class ChecklistProgressStore: ObservableObject {
    @Published private(set) var checkedItems: Set<String> = []

    private let key = "checklist.checkedItems"

    init() {
        load()
    }

    func isChecked(_ id: String) -> Bool {
        checkedItems.contains(id)
    }

    func toggle(_ id: String) {
        if checkedItems.contains(id) {
            checkedItems.remove(id)
        } else {
            checkedItems.insert(id)
        }

        save()
    }

    func reset() {
        checkedItems.removeAll()
        save()
    }

    private func load() {
        let saved = UserDefaults.standard.stringArray(forKey: key) ?? []
        checkedItems = Set(saved)
    }

    private func save() {
        UserDefaults.standard.set(Array(checkedItems), forKey: key)
    }
}
