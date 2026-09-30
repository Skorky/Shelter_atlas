import Foundation

enum ChecklistEngine {

    static func makeItems(
        adults: Int,
        children: Int,
        infants: Int,
        dogs: Int,
        cats: Int,
        hasRegularMedication: Bool,
        usesGlasses: Bool,
        hasMedicalAid: Bool,
        hasDietaryNeeds: Bool,
        petMedication: Bool
    ) -> [ChecklistItem] {

        var items: [ChecklistItem] = []

        let totalPeople = adults + children + infants
        let totalPets = dogs + cats

        // MARK: - HNED

        add(
            &items,
            id: "phone",
            title: "Mobilní telefon",
            detail: "Vezměte nabitý telefon.",
            urgency: .immediate,
            category: .electronics
        )

        add(
            &items,
            id: "keys",
            title: "Klíče",
            detail: "Od bytu, domu, auta a dalších důležitých prostor.",
            urgency: .immediate,
            category: .documents
        )

        add(
            &items,
            id: "id-documents",
            title: "Osobní doklady",
            detail: "Občanský průkaz, pas a další důležité doklady.",
            urgency: .immediate,
            category: .documents,
            quantity: totalPeople
        )

        add(
            &items,
            id: "insurance-cards",
            title: "Průkazy zdravotního pojištění",
            detail: "Pro všechny členy domácnosti.",
            urgency: .immediate,
            category: .documents,
            quantity: totalPeople
        )

        add(
            &items,
            id: "cash-cards",
            title: "Hotovost a platební karty",
            detail: "Vhodná je i hotovost v menších bankovkách.",
            urgency: .immediate,
            category: .documents
        )

        // MARK: Zdravotní potřeby
        
        add(
            &items,
            id: "first-aid",
            title: "Základní lékárnička",
            detail: "Obvazy, náplasti, dezinfekce, základní léky a další vybavení pro první pomoc.",
            urgency: .immediate,
            category: .health
        )

        if hasRegularMedication {
            add(
                &items,
                id: "regular-medication",
                title: "Pravidelně užívané léky",
                detail: "Pokud je to možné, vezměte zásobu přibližně na týden.",
                urgency: .immediate,
                category: .health
            )
        }

        if usesGlasses {
            add(
                &items,
                id: "glasses",
                title: "Brýle / kontaktní čočky",
                detail: "Včetně pouzdra, roztoku nebo náhradních brýlí.",
                urgency: .immediate,
                category: .health
            )
        }

        if hasMedicalAid {
            add(
                &items,
                id: "medical-aid",
                title: "Zdravotní pomůcka",
                detail: "Například inhalátor, glukometr, naslouchadlo nebo jiná nezbytná pomůcka.",
                urgency: .immediate,
                category: .health
            )
        }

        // MARK: Kojenci

        if infants > 0 {
            add(
                &items,
                id: "diapers",
                title: "Pleny",
                detail: "Základní zásoba pro kojence.",
                urgency: .immediate,
                category: .children,
                quantity: infants
            )

            add(
                &items,
                id: "baby-essential-food",
                title: "Nezbytná kojenecká výživa",
                detail: "Pokud ji dítě potřebuje.",
                urgency: .immediate,
                category: .children,
                quantity: infants
            )
        }

        // MARK: Psi

        if dogs > 0 {
            add(
                &items,
                id: "dog-leash",
                title: "Vodítko pro psa",
                detail: nil,
                urgency: .immediate,
                category: .pets,
                quantity: dogs
            )

            add(
                &items,
                id: "dog-muzzle",
                title: "Náhubek",
                detail: "Podle velikosti a potřeb psa.",
                urgency: .immediate,
                category: .pets,
                quantity: dogs
            )
        }

        // MARK: Kočky

        if cats > 0 {
            add(
                &items,
                id: "cat-carrier",
                title: "Přepravka pro kočku",
                detail: nil,
                urgency: .immediate,
                category: .pets,
                quantity: cats
            )
        }

        // MARK: Léky pro zvířata

        if petMedication && totalPets > 0 {
            add(
                &items,
                id: "pet-medication",
                title: "Léky pro zvíře",
                detail: "Včetně dávkování a případné veterinární dokumentace.",
                urgency: .immediate,
                category: .pets
            )
        }

        // MARK: - 15–30 MINUT

        add(
            &items,
            id: "water",
            title: "Pitná voda",
            detail: "Základní nouzová zásoba.",
            urgency: .fifteenMinutes,
            category: .waterFood,
            quantityText: "cca \(totalPeople * 2) l / 1 den"
        )

        add(
            &items,
            id: "food",
            title: "Trvanlivé potraviny",
            detail: "Základní zásoba alespoň na první den.",
            urgency: .fifteenMinutes,
            category: .waterFood,
            quantity: totalPeople
        )

        if hasDietaryNeeds {
            add(
                &items,
                id: "diet-food",
                title: "Speciální potraviny",
                detail: "Podle dietních, alergických nebo jiných stravovacích omezení.",
                urgency: .fifteenMinutes,
                category: .waterFood
            )
        }

        add(
            &items,
            id: "cup-bowl",
            title: "Hrnek nebo miska",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .waterFood,
            quantity: totalPeople
        )

        add(
            &items,
            id: "cutlery",
            title: "Příbor",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .waterFood,
            quantity: totalPeople
        )

        // MARK: Zdraví a hygiena

        add(
            &items,
            id: "toothbrush",
            title: "Kartáček a zubní pasta",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .hygiene,
            quantity: totalPeople
        )

        add(
            &items,
            id: "soap",
            title: "Mýdlo / hygienické potřeby",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .hygiene
        )

        add(
            &items,
            id: "toilet-paper",
            title: "Toaletní papír",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .hygiene
        )

        add(
            &items,
            id: "hand-sanitizer",
            title: "Dezinfekce na ruce",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .hygiene
        )

        add(
            &items,
            id: "towel",
            title: "Ručník",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .hygiene,
            quantity: totalPeople
        )

        // MARK: Elektronika

        add(
            &items,
            id: "charger",
            title: "Nabíječka k telefonu",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .electronics
        )

        add(
            &items,
            id: "powerbank",
            title: "Nabitá powerbanka",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .electronics
        )

        // MARK: Dokumenty

        add(
            &items,
            id: "paper-contacts",
            title: "Důležité kontakty na papíře",
            detail: "Telefonní čísla blízkých pro případ nedostupného telefonu.",
            urgency: .fifteenMinutes,
            category: .documents
        )

        // MARK: Oblečení

        add(
            &items,
            id: "change-clothes",
            title: "Náhradní oblečení",
            detail: "Podle ročního období.",
            urgency: .fifteenMinutes,
            category: .clothing,
            quantity: totalPeople
        )

        add(
            &items,
            id: "underwear",
            title: "Náhradní spodní prádlo",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .clothing,
            quantity: totalPeople
        )

        add(
            &items,
            id: "shoes",
            title: "Pevná obuv",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .clothing,
            quantity: totalPeople
        )

        add(
            &items,
            id: "raincoat",
            title: "Pláštěnka / ochrana proti dešti",
            detail: nil,
            urgency: .fifteenMinutes,
            category: .clothing,
            quantity: totalPeople
        )

        // MARK: DĚTI

        if children > 0 {
            add(
                &items,
                id: "children-clothes",
                title: "Náhradní oblečení pro děti",
                detail: nil,
                urgency: .fifteenMinutes,
                category: .children,
                quantity: children
            )

            add(
                &items,
                id: "children-comfort",
                title: "Oblíbená hračka nebo uklidňující předmět",
                detail: "Může dítěti pomoci zvládnout stresovou situaci.",
                urgency: .fifteenMinutes,
                category: .children,
                quantity: children
            )
        }

        if infants > 0 {
            add(
                &items,
                id: "baby-food",
                title: "Kojenecká výživa",
                detail: "Podle běžných potřeb dítěte.",
                urgency: .fifteenMinutes,
                category: .children,
                quantity: infants
            )

            add(
                &items,
                id: "baby-hygiene",
                title: "Hygienické potřeby pro kojence",
                detail: "Vlhčené ubrousky, přebalovací potřeby apod.",
                urgency: .fifteenMinutes,
                category: .children,
                quantity: infants
            )
        }

        // MARK: ZVÍŘATA

        if totalPets > 0 {
            add(
                &items,
                id: "pet-food",
                title: "Krmivo pro zvířata",
                detail: "Vezměte vlastní zásobu krmiva.",
                urgency: .fifteenMinutes,
                category: .pets,
                quantity: totalPets
            )

            add(
                &items,
                id: "pet-water",
                title: "Voda pro zvířata",
                detail: nil,
                urgency: .fifteenMinutes,
                category: .pets,
                quantity: totalPets
            )

            add(
                &items,
                id: "pet-bowls",
                title: "Misky na vodu a krmivo",
                detail: nil,
                urgency: .fifteenMinutes,
                category: .pets,
                quantity: totalPets
            )

            add(
                &items,
                id: "pet-documents",
                title: "Očkovací průkaz / pet pas",
                detail: "Pokud je k dispozici.",
                urgency: .fifteenMinutes,
                category: .pets
            )
        }

        if cats > 0 {
            add(
                &items,
                id: "cat-litter",
                title: "Kočičí podestýlka",
                detail: nil,
                urgency: .fifteenMinutes,
                category: .pets
            )
        }

        // MARK: - MÁM ČAS

        add(
            &items,
            id: "copies-documents",
            title: "Kopie důležitých dokumentů",
            detail: "Například rodné listy, smlouvy a pojistné dokumenty.",
            urgency: .preparation,
            category: .documents
        )

        add(
            &items,
            id: "sleeping-bag",
            title: "Spacák nebo deka",
            detail: nil,
            urgency: .preparation,
            category: .sleeping,
            quantityText: "\(totalPeople) ks"
        )

        add(
            &items,
            id: "sleeping-mat",
            title: "Karimatka",
            detail: nil,
            urgency: .preparation,
            category: .sleeping,
            quantity: totalPeople
        )

        add(
            &items,
            id: "flashlight",
            title: "Svítilna",
            detail: "Ideálně samostatná svítilna, ne pouze telefon.",
            urgency: .preparation,
            category: .electronics
        )

        add(
            &items,
            id: "batteries",
            title: "Náhradní baterie",
            detail: nil,
            urgency: .preparation,
            category: .electronics
        )

        add(
            &items,
            id: "radio",
            title: "Rádio na baterie",
            detail: "Pro příjem informací při výpadku internetu nebo elektřiny.",
            urgency: .preparation,
            category: .electronics
        )

        add(
            &items,
            id: "multitool",
            title: "Multifunkční nůž / otvírák",
            detail: nil,
            urgency: .preparation,
            category: .other
        )

        add(
            &items,
            id: "pen-paper",
            title: "Tužka a papír",
            detail: nil,
            urgency: .preparation,
            category: .other
        )

        add(
            &items,
            id: "entertainment",
            title: "Kniha, hra nebo jiná drobná zábava",
            detail: "Pro případ delšího pobytu v evakuačním centru.",
            urgency: .preparation,
            category: .other
        )

        add(
            &items,
            id: "bag-label",
            title: "Označení zavazadla",
            detail: "Jméno, adresa a telefonní kontakt.",
            urgency: .preparation,
            category: .other
        )

        return items
    }

    private static func add(
        _ items: inout [ChecklistItem],
        id: String,
        title: String,
        detail: String?,
        urgency: ChecklistUrgency,
        category: ChecklistCategory,
        quantity: Int? = nil,
        quantityText: String? = nil
    ) {
        items.append(
            ChecklistItem(
                id: id,
                title: title,
                detail: detail,
                urgency: urgency,
                category: category,
                quantity: quantity,
                quantityText: quantityText
            )
        )
    }
}
