//
//  EmergencyBagStored.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import Foundation

@MainActor
final class EmergencyBagStore: ObservableObject {

    @Published private(set) var statuses: [String: BagItemStatus] = [:]

    private let key = "emergencyBag.statuses"

    init() {
        load()
    }

    func status(for itemID: String) -> BagItemStatus {
        statuses[itemID] ?? .missing
    }

    func advanceStatus(for itemID: String) {
        let current = status(for: itemID)

        switch current {
        case .missing:
            statuses[itemID] = .owned

        case .owned:
            statuses[itemID] = .packed

        case .packed:
            statuses[itemID] = .missing
        }

        save()
    }

    func reset() {
        statuses.removeAll()
        save()
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode(
                [String: BagItemStatus].self,
                from: data
            )
        else {
            return
        }

        statuses = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(statuses) else {
            return
        }

        UserDefaults.standard.set(data, forKey: key)
    }
}
