//
//  HomeSuppliesStore.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import Foundation
import Combine

@MainActor
final class HomeSuppliesStore: ObservableObject {

    @Published private(set) var checkedIDs: Set<String> = []

    private let defaults = UserDefaults.standard

    private let storageKey =
        "homeSupplies.checkedIDs"

    init() {
        load()
    }

    func isChecked(
        _ id: String
    ) -> Bool {

        checkedIDs.contains(id)
    }

    func toggle(
        _ id: String
    ) {

        if checkedIDs.contains(id) {

            checkedIDs.remove(id)

        } else {

            checkedIDs.insert(id)
        }

        save()
    }

    func reset() {

        checkedIDs.removeAll()
        save()
    }

    private func save() {

        defaults.set(
            Array(checkedIDs),
            forKey: storageKey
        )
    }

    private func load() {

        let values =
            defaults.stringArray(
                forKey: storageKey
            ) ?? []

        checkedIDs =
            Set(values)
    }
}
