//
//  PreparednessPlanStore.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import Foundation
import Combine

@MainActor
final class PreparednessPlanStore: ObservableObject {

    @Published var nearbyMeetingPlace: String {
        didSet { save() }
    }

    @Published var outsideTownMeetingPlace: String {
        didSet { save() }
    }

    @Published var emergencyContactName: String {
        didSet { save() }
    }

    @Published var emergencyContactPhone: String {
        didSet { save() }
    }

    @Published var familyInstructions: String {
        didSet { save() }
    }

    @Published var lastReviewedAt: Date? {
        didSet { save() }
    }

    private let defaults = UserDefaults.standard

    private enum Key {
        static let nearbyMeetingPlace = "preparedness.nearbyMeetingPlace"
        static let outsideTownMeetingPlace = "preparedness.outsideTownMeetingPlace"
        static let emergencyContactName = "preparedness.emergencyContactName"
        static let emergencyContactPhone = "preparedness.emergencyContactPhone"
        static let familyInstructions = "preparedness.familyInstructions"
        static let lastReviewedAt = "preparedness.lastReviewedAt"
    }

    init() {

        nearbyMeetingPlace =
            defaults.string(
                forKey: Key.nearbyMeetingPlace
            ) ?? ""

        outsideTownMeetingPlace =
            defaults.string(
                forKey: Key.outsideTownMeetingPlace
            ) ?? ""

        emergencyContactName =
            defaults.string(
                forKey: Key.emergencyContactName
            ) ?? ""

        emergencyContactPhone =
            defaults.string(
                forKey: Key.emergencyContactPhone
            ) ?? ""

        familyInstructions =
            defaults.string(
                forKey: Key.familyInstructions
            ) ?? ""

        if let date =
            defaults.object(
                forKey: Key.lastReviewedAt
            ) as? Date {

            lastReviewedAt = date

        } else {

            lastReviewedAt = nil
        }
    }

    func markReviewed() {
        lastReviewedAt = Date()
    }

    func reset() {

        nearbyMeetingPlace = ""
        outsideTownMeetingPlace = ""
        emergencyContactName = ""
        emergencyContactPhone = ""
        familyInstructions = ""
        lastReviewedAt = nil
    }

    private func save() {

        defaults.set(
            nearbyMeetingPlace,
            forKey: Key.nearbyMeetingPlace
        )

        defaults.set(
            outsideTownMeetingPlace,
            forKey: Key.outsideTownMeetingPlace
        )

        defaults.set(
            emergencyContactName,
            forKey: Key.emergencyContactName
        )

        defaults.set(
            emergencyContactPhone,
            forKey: Key.emergencyContactPhone
        )

        defaults.set(
            familyInstructions,
            forKey: Key.familyInstructions
        )

        defaults.set(
            lastReviewedAt,
            forKey: Key.lastReviewedAt
        )
    }
}
