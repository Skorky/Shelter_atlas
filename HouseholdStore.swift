//
//  HouseholdStore.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import Foundation

@MainActor
final class HouseholdStore: ObservableObject {
    @Published var adults: Int {
        didSet { save() }
    }

    @Published var children: Int {
        didSet { save() }
    }

    @Published var infants: Int {
        didSet { save() }
    }

    @Published var dogs: Int {
        didSet { save() }
    }

    @Published var cats: Int {
        didSet { save() }
    }

    @Published var hasRegularMedication: Bool {
        didSet { save() }
    }
    
    @Published var usesGlasses: Bool {
        didSet { save() }
    }

    @Published var hasMedicalAid: Bool {
        didSet { save() }
    }

    @Published var hasDietaryNeeds: Bool {
        didSet { save() }
    }

    @Published var petMedication: Bool {
        didSet { save() }
    }
    

    init() {
        let defaults = UserDefaults.standard

        adults = max(defaults.integer(forKey: "household.adults"), 1)
        children = defaults.integer(forKey: "household.children")
        infants = defaults.integer(forKey: "household.infants")
        dogs = defaults.integer(forKey: "household.dogs")
        cats = defaults.integer(forKey: "household.cats")
        hasRegularMedication = defaults.bool(forKey: "household.medication")
        usesGlasses = defaults.bool(forKey: "household.glasses")
        hasMedicalAid = defaults.bool(forKey: "household.medicalAid")
        hasDietaryNeeds = defaults.bool(forKey: "household.dietaryNeeds")
        petMedication = defaults.bool(forKey: "household.petMedication")
    }

    var totalPeople: Int {
        adults + children + infants
    }

    var totalPets: Int {
        dogs + cats
    }

    private func save() {
        let defaults = UserDefaults.standard

        defaults.set(adults, forKey: "household.adults")
        defaults.set(children, forKey: "household.children")
        defaults.set(infants, forKey: "household.infants")
        defaults.set(dogs, forKey: "household.dogs")
        defaults.set(cats, forKey: "household.cats")
        defaults.set(hasRegularMedication, forKey: "household.medication")
        defaults.set(usesGlasses, forKey: "household.glasses")
        defaults.set(hasMedicalAid, forKey: "household.medicalAid")
        defaults.set(hasDietaryNeeds, forKey: "household.dietaryNeeds")
        defaults.set(petMedication, forKey: "household.petMedication")
    }
}
