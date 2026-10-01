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
    @Published private(set) var lastReviewedAt: Date?

    private let defaults = UserDefaults.standard

    private enum Key {
        static let checkedIDs = "homeSupplies.checkedIDs"
        static let lastReviewedAt = "homeSupplies.lastReviewedAt"
    }

    init() {
        load()
    }

    // MARK: - Checklist

    func isChecked(_ id: String) -> Bool {
        checkedIDs.contains(id)
    }

    func toggle(_ id: String) {
        if checkedIDs.contains(id) {
            checkedIDs.remove(id)
        } else {
            checkedIDs.insert(id)
        }

        saveCheckedIDs()
    }

    func reset() {
        checkedIDs.removeAll()
        lastReviewedAt = nil

        saveCheckedIDs()
        saveLastReviewedAt()
    }

    // MARK: - Review

    func markReviewedToday() {
        lastReviewedAt = Date()
        saveLastReviewedAt()
    }

    var hasBeenReviewed: Bool {
        lastReviewedAt != nil
    }

    var daysSinceReview: Int? {
        guard let lastReviewedAt else {
            return nil
        }

        let calendar = Calendar.current

        return calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: lastReviewedAt),
            to: calendar.startOfDay(for: Date())
        ).day
    }

    var reviewNeedsAttention: Bool {
        guard let daysSinceReview else {
            return true
        }

        return daysSinceReview >= 180
    }

    // MARK: - Persistence

    private func saveCheckedIDs() {
        defaults.set(Array(checkedIDs), forKey: Key.checkedIDs)
    }

    private func saveLastReviewedAt() {
        defaults.set(lastReviewedAt, forKey: Key.lastReviewedAt)
    }

    private func load() {
        let values = defaults.stringArray(forKey: Key.checkedIDs) ?? []
        checkedIDs = Set(values)

        lastReviewedAt = defaults.object(
            forKey: Key.lastReviewedAt
        ) as? Date
    }
}
