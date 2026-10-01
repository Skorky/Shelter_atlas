//
//  PlaceholderViews.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//

import SwiftUI

// MARK: - Checklist

struct ChecklistView: View {

    @StateObject private var household = HouseholdStore()
    @State private var selectedUrgency: ChecklistUrgency = .immediate
    @StateObject private var progress = ChecklistProgressStore()

    private var items: [ChecklistItem] {

        ChecklistEngine.makeItems(
            adults: household.adults,
            children: household.children,
            infants: household.infants,
            dogs: household.dogs,
            cats: household.cats,
            hasRegularMedication: household.hasRegularMedication,
            usesGlasses: household.usesGlasses,
            hasMedicalAid: household.hasMedicalAid,
            hasDietaryNeeds: household.hasDietaryNeeds,
            petMedication: household.petMedication
        )
        .filter {
            $0.urgency == selectedUrgency
        }
    }

    var body: some View {

        NavigationStack {

            VStack(spacing: 0) {

                Picker(
                    "Naléhavost",
                    selection: $selectedUrgency
                ) {

                    ForEach(ChecklistUrgency.allCases) { urgency in

                        Text(urgency.rawValue)
                            .tag(urgency)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                List(items) { item in

                    Button {

                        toggle(item)

                    } label: {

                        HStack(
                            alignment: .top,
                            spacing: 12
                        ) {

                            Image(
                                systemName:
                                    progress.isChecked(item.id)
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .font(.title3)

                            VStack(
                                alignment: .leading,
                                spacing: 4
                            ) {

                                HStack {

                                    Text(item.title)
                                        .font(.body)

                                    if let quantityText = item.quantityText {

                                        Text(quantityText)
                                            .font(.caption.bold())
                                            .padding(.horizontal, 7)
                                            .padding(.vertical, 3)
                                            .background(.thinMaterial)
                                            .clipShape(Capsule())

                                    } else if let quantity = item.quantity,
                                              quantity > 1 {

                                        Text("×\(quantity)")
                                            .font(.caption.bold())
                                            .padding(.horizontal, 7)
                                            .padding(.vertical, 3)
                                            .background(.thinMaterial)
                                            .clipShape(Capsule())
                                    }
                                }

                                if let detail = item.detail {

                                    Text(detail)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Text(item.category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }

                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Co vzít")
            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Menu {

                        Button(
                            "Resetovat checklist",
                            role: .destructive
                        ) {

                            progress.reset()
                        }

                    } label: {

                        Image(
                            systemName: "ellipsis.circle"
                        )
                    }
                }
            }
        }
    }

    private func toggle(
        _ item: ChecklistItem
    ) {

        progress.toggle(item.id)
    }
}

// MARK: - Nouzové zavazadlo

struct EmergencyBagView: View {

    @StateObject private var household = HouseholdStore()
    @StateObject private var bagStore = EmergencyBagStore()

    private var items: [EmergencyBagItem] {

        EmergencyBagEngine.makeItems(
            adults: household.adults,
            children: household.children,
            infants: household.infants,
            dogs: household.dogs,
            cats: household.cats,
            hasRegularMedication: household.hasRegularMedication,
            usesGlasses: household.usesGlasses,
            hasMedicalAid: household.hasMedicalAid,
            hasDietaryNeeds: household.hasDietaryNeeds,
            petMedication: household.petMedication
        )
    }

    private var packedCount: Int {

        items.filter {
            bagStore.status(for: $0.id) == .packed
        }
        .count
    }

    private var ownedCount: Int {

        items.filter {

            let status =
                bagStore.status(
                    for: $0.id
                )

            return
                status == .owned ||
                status == .packed
        }
        .count
    }

    var body: some View {

        NavigationStack {

            List {

                Section {

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text("Připravenost zavazadla")
                            .font(.headline)

                        ProgressView(
                            value: Double(packedCount),
                            total: Double(
                                max(items.count, 1)
                            )
                        )

                        Text(
                            "\(packedCount) z \(items.count) položek sbaleno"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)

                        Text(
                            "\(ownedCount) položek už máte"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }

                ForEach(
                    BagCategory.allCases,
                    id: \.self
                ) { category in

                    let categoryItems =
                        items.filter {
                            $0.category == category
                        }

                    if !categoryItems.isEmpty {

                        Section(
                            category.rawValue
                        ) {

                            ForEach(
                                categoryItems
                            ) { item in

                                Button {

                                    bagStore
                                        .advanceStatus(
                                            for: item.id
                                        )

                                } label: {

                                    HStack(
                                        spacing: 12
                                    ) {

                                        Image(
                                            systemName:
                                                bagStore
                                                .status(
                                                    for: item.id
                                                )
                                                .symbolName
                                        )
                                        .font(.title3)

                                        VStack(
                                            alignment: .leading,
                                            spacing: 3
                                        ) {

                                            Text(item.title)
                                                .foregroundStyle(.primary)

                                            if let detail = item.detail {

                                                Text(detail)
                                                    .font(.caption)
                                                    .foregroundStyle(.secondary)
                                            }

                                            Text(
                                                bagStore
                                                    .status(
                                                        for: item.id
                                                    )
                                                    .title
                                            )
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                        }

                                        Spacer()
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .navigationTitle(
                "Nouzové zavazadlo"
            )
            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Menu {

                        Button(
                            "Resetovat stav",
                            role: .destructive
                        ) {

                            bagStore.reset()
                        }

                    } label: {

                        Image(
                            systemName: "ellipsis.circle"
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Příručka

struct GuideView: View {

    @State private var searchText = ""

    private var filteredTopics: [GuideTopic] {

        if searchText
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty {

            return GuideContent.topics
        }

        let query =
            searchText.lowercased()

        return GuideContent.topics.filter {
            topic in

            topic.title
                .lowercased()
                .contains(query) ||

            topic.subtitle
                .lowercased()
                .contains(query) ||

            topic.sections.contains {
                section in

                section.title
                    .lowercased()
                    .contains(query) ||

                section.items.contains {
                    $0
                        .lowercased()
                        .contains(query)
                }
            } ||

            topic.articleSections.contains {
                section in

                section.title
                    .lowercased()
                    .contains(query) ||

                section.paragraphs.contains {
                    $0
                        .lowercased()
                        .contains(query)
                }
            }
        }
    }

    var body: some View {

        NavigationStack {

            List(
                filteredTopics
            ) { topic in

                NavigationLink {

                    GuideDetailView(
                        topic: topic
                    )

                } label: {

                    HStack(
                        spacing: 14
                    ) {

                        Image(
                            systemName:
                                topic.symbolName
                        )
                        .font(.title2)
                        .frame(width: 36)

                        VStack(
                            alignment: .leading,
                            spacing: 3
                        ) {

                            Text(topic.title)
                                .font(.headline)

                            Text(topic.subtitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Příručka")
            .searchable(
                text: $searchText,
                prompt: "Hledat v příručce"
            )
            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    NavigationLink {

                        EmergencyContactsView()

                    } label: {

                        Image(
                            systemName: "phone.fill"
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Detail příručky

struct GuideDetailView: View {

    let topic: GuideTopic

    var body: some View {

        List {

            Section {

                Label(
                    "Rychlý postup",
                    systemImage: "bolt.fill"
                )
                .font(.headline)
            }

            ForEach(
                topic.sections
            ) { section in

                Section(
                    section.title
                ) {

                    ForEach(
                        section.items,
                        id: \.self
                    ) { item in

                        HStack(
                            alignment: .top,
                            spacing: 10
                        ) {

                            Image(
                                systemName:
                                    "checkmark.circle"
                            )
                            .foregroundStyle(.secondary)

                            Text(item)
                                .fixedSize(
                                    horizontal: false,
                                    vertical: true
                                )
                        }
                    }
                }
            }

            if !topic.articleSections.isEmpty {

                Section {

                    NavigationLink {

                        GuideArticleView(
                            topic: topic
                        )

                    } label: {

                        HStack(
                            spacing: 14
                        ) {

                            Image(
                                systemName:
                                    "book.pages.fill"
                            )
                            .font(.title2)

                            VStack(
                                alignment: .leading,
                                spacing: 3
                            ) {

                                Text(
                                    "Chci vědět víc"
                                )
                                .font(.headline)

                                Text(
                                    "Podrobnější vysvětlení, příprava a souvislosti"
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }

            Section {

                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text("Zdroj")
                        .font(.caption.bold())

                    Text(topic.sourceName)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(
                        "Obsah je dostupný i offline."
                    )
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                }
            }
        }
        .navigationTitle(
            topic.title
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }
}

// MARK: - Článek příručky

struct GuideArticleView: View {

    let topic: GuideTopic

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 24
            ) {

                HStack(
                    spacing: 14
                ) {

                    Image(
                        systemName:
                            topic.symbolName
                    )
                    .font(
                        .system(size: 36)
                    )

                    VStack(
                        alignment: .leading,
                        spacing: 3
                    ) {

                        Text(topic.title)
                            .font(.title.bold())

                        Text(
                            "Podrobná příručka"
                        )
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }

                Divider()

                ForEach(
                    topic.articleSections
                ) { section in

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        Text(
                            section.title
                        )
                        .font(.title2.bold())

                        ForEach(
                            section.paragraphs,
                            id: \.self
                        ) { paragraph in

                            Text(paragraph)
                                .font(.body)
                                .lineSpacing(4)
                                .fixedSize(
                                    horizontal: false,
                                    vertical: true
                                )
                        }
                    }
                }

                Divider()

                VStack(
                    alignment: .leading,
                    spacing: 8
                ) {

                    Text("Zdroj")
                        .font(.caption.bold())

                    Text(topic.sourceName)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(
                        "Obsah je dostupný i offline."
                    )
                    .font(.caption2)
                    .foregroundStyle(.tertiary)

                    if let sourceURL =
                        topic.sourceURL,
                       let url =
                        URL(
                            string: sourceURL
                        ) {

                        Link(
                            destination: url
                        ) {

                            Label(
                                "Otevřít oficiální zdroj",
                                systemImage: "safari"
                            )
                            .font(
                                .subheadline.bold()
                            )
                        }
                        .padding(.top, 4)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(
            topic.title
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }
}

// MARK: - Profil domácnosti

struct HouseholdView: View {

    @StateObject private var household = HouseholdStore()
    @StateObject private var preparednessPlan = PreparednessPlanStore()

    var body: some View {

        NavigationStack {

            Form {

                Section(
                    "Lidé"
                ) {

                    Stepper(
                        "Dospělí: \(household.adults)",
                        value: $household.adults,
                        in: 1...10
                    )

                    Stepper(
                        "Děti: \(household.children)",
                        value: $household.children,
                        in: 0...10
                    )

                    Stepper(
                        "Kojenci: \(household.infants)",
                        value: $household.infants,
                        in: 0...5
                    )
                }

                Section(
                    "Zvířata"
                ) {

                    Stepper(
                        "Psi: \(household.dogs)",
                        value: $household.dogs,
                        in: 0...10
                    )

                    Stepper(
                        "Kočky: \(household.cats)",
                        value: $household.cats,
                        in: 0...10
                    )

                    if household.totalPets > 0 {

                        Toggle(
                            "Zvíře užívá léky",
                            isOn: $household.petMedication
                        )
                    }
                }

                Section(
                    "Zdravotní potřeby"
                ) {

                    Toggle(
                        "Pravidelně užívané léky",
                        isOn: $household.hasRegularMedication
                    )

                    Toggle(
                        "Brýle / kontaktní čočky",
                        isOn: $household.usesGlasses
                    )

                    Toggle(
                        "Zdravotní pomůcka",
                        isOn: $household.hasMedicalAid
                    )

                    Toggle(
                        "Dietní omezení",
                        isOn: $household.hasDietaryNeeds
                    )
                }

                Section(
                    "Rodinný krizový plán"
                ) {

                    NavigationLink {

                        PreparednessPlanView(
                            store:
                                preparednessPlan
                        )

                    } label: {

                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {

                            Label(
                                "Krizový plán domácnosti",
                                systemImage:
                                    "person.3.sequence.fill"
                            )

                            Text(
                                preparednessPlanSummary
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }

                Section(
                    "Připravenost domácnosti"
                ) {

                    NavigationLink {

                        HomeSuppliesView()

                    } label: {

                        Label(
                            "Domácí zásoby na 72 hodin",
                            systemImage:
                                "shippingbox.fill"
                        )
                    }
                }

                Section(
                    "Souhrn"
                ) {

                    LabeledContent(
                        "Osoby celkem",
                        value:
                            "\(household.totalPeople)"
                    )

                    LabeledContent(
                        "Zvířata celkem",
                        value:
                            "\(household.totalPets)"
                    )
                }

                Section {

                    Text(
                        "Tyto údaje zůstávají uložené pouze v zařízení a podle nich se přizpůsobuje checklist, nouzové zavazadlo a domácí zásoby."
                    )
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(
                "Moje domácnost"
            )
        }
    }

    // MARK: - Stav krizového plánu

    private var preparednessPlanSummary: String {

        if preparednessPlan
            .nearbyMeetingPlace
            .isEmpty &&
            preparednessPlan
            .outsideTownMeetingPlace
            .isEmpty &&
            preparednessPlan
            .emergencyContactName
            .isEmpty {

            return "Zatím není vyplněn"
        }

        if let reviewed =
            preparednessPlan.lastReviewedAt {

            return "Naposledy zkontrolováno \(reviewed.formatted(date: .abbreviated, time: .omitted))"
        }

        return "Plán je částečně vyplněn"
    }
}

// MARK: - Rodinný krizový plán

struct PreparednessPlanView: View {

    @ObservedObject var store: PreparednessPlanStore

    var body: some View {

        Form {

            Section {

                Label(
                    "Předem si domluvte, kde se domácnost setká, pokud nebude možné se spojit telefonem.",
                    systemImage:
                        "person.3.fill"
                )
                .font(.callout)

            } header: {

                Text(
                    "Rodinný krizový plán"
                )
            }

            Section(
                "Místa setkání"
            ) {

                VStack(
                    alignment: .leading,
                    spacing: 6
                ) {

                    Label(
                        "Místo poblíž domova",
                        systemImage:
                            "house.fill"
                    )
                    .font(
                        .subheadline.bold()
                    )

                    TextField(
                        "Např. park, škola, náměstí",
                        text:
                            $store.nearbyMeetingPlace
                    )
                    .textInputAutocapitalization(
                        .sentences
                    )
                }

                VStack(
                    alignment: .leading,
                    spacing: 6
                ) {

                    Label(
                        "Místo mimo obec",
                        systemImage:
                            "map.fill"
                    )
                    .font(
                        .subheadline.bold()
                    )

                    TextField(
                        "Např. příbuzní, chata, jiné město",
                        text:
                            $store.outsideTownMeetingPlace
                    )
                    .textInputAutocapitalization(
                        .sentences
                    )
                }
            }

            Section(
                "Nouzový kontakt"
            ) {

                TextField(
                    "Jméno",
                    text:
                        $store.emergencyContactName
                )
                .textContentType(.name)

                TextField(
                    "Telefon",
                    text:
                        $store.emergencyContactPhone
                )
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)

                Text(
                    "Ideálně osoba mimo vaši domácnost, která může pomoci předat informace mezi členy rodiny."
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Section(
                "Rodinné instrukce"
            ) {

                TextEditor(
                    text:
                        $store.familyInstructions
                )
                .frame(minHeight: 120)

                Text(
                    "Můžete si sem napsat například kdo vyzvedává děti, kdo pomáhá seniorům, kdo bere léky nebo kde jsou důležité dokumenty."
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Section(
                "Kontrola plánu"
            ) {

                if let reviewed =
                    store.lastReviewedAt {

                    LabeledContent(
                        "Poslední kontrola"
                    ) {

                        Text(
                            reviewed.formatted(
                                date: .abbreviated,
                                time: .shortened
                            )
                        )
                    }

                } else {

                    Text(
                        "Plán zatím nebyl označen jako zkontrolovaný."
                    )
                    .foregroundStyle(.secondary)
                }

                Button {

                    store.markReviewed()

                } label: {

                    Label(
                        "Označit jako zkontrolované",
                        systemImage:
                            "checkmark.circle.fill"
                    )
                }
            }

            Section {

                Text(
                    "Údaje jsou uložené pouze v tomto zařízení."
                )
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(
            "Krizový plán"
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }
}

// MARK: - Domácí zásoby na 72 hodin

struct HomeSuppliesView: View {

    @StateObject private var household = HouseholdStore()
    @StateObject private var store = HomeSuppliesStore()

    private var items: [HomeSupplyItem] {

        HomeSuppliesEngine.makeItems(
            adults: household.adults,
            children: household.children,
            infants: household.infants,
            dogs: household.dogs,
            cats: household.cats,
            hasRegularMedication:
                household.hasRegularMedication,
            hasMedicalAid:
                household.hasMedicalAid,
            hasDietaryNeeds:
                household.hasDietaryNeeds,
            petMedication:
                household.petMedication
        )
    }

    private var completedCount: Int {

        items.filter {
            store.isChecked(
                $0.id
            )
        }
        .count
    }

    private var progress: Double {

        guard !items.isEmpty else {
            return 0
        }

        return
            Double(completedCount) /
            Double(items.count)
    }

    var body: some View {

        List {

            Section {

                VStack(
                    alignment: .leading,
                    spacing: 12
                ) {

                    HStack {

                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {

                            Text(
                                "Připravenost domácnosti"
                            )
                            .font(.headline)

                            Text(
                                "\(completedCount) z \(items.count) položek připraveno"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text(
                            "\(Int(progress * 100)) %"
                        )
                        .font(
                            .title3.bold()
                        )
                    }

                    ProgressView(
                        value:
                            Double(completedCount),
                        total:
                            Double(
                                max(items.count, 1)
                            )
                    )

                    Text(
                        "Tento seznam je určen pro zásoby, které máte připravené doma. Není to evakuační zavazadlo."
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )
                }
                .padding(
                    .vertical,
                    4
                )
            }

            ForEach(
                HomeSupplyCategory.allCases,
                id: \.self
            ) { category in

                let categoryItems =
                    items.filter {
                        $0.category == category
                    }

                if !categoryItems.isEmpty {

                    Section(
                        category.rawValue
                    ) {

                        ForEach(
                            categoryItems
                        ) { item in

                            Button {

                                withAnimation(
                                    .easeInOut(
                                        duration: 0.15
                                    )
                                ) {

                                    store.toggle(
                                        item.id
                                    )
                                }

                            } label: {

                                HStack(
                                    alignment: .top,
                                    spacing: 12
                                ) {

                                    Image(
                                        systemName:
                                            store.isChecked(
                                                item.id
                                            )
                                            ? "checkmark.circle.fill"
                                            : "circle"
                                    )
                                    .font(.title3)

                                    VStack(
                                        alignment: .leading,
                                        spacing: 5
                                    ) {

                                        Text(
                                            item.title
                                        )
                                        .font(.body)
                                        .foregroundStyle(.primary)
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )

                                        if let quantity =
                                            item.quantityText {

                                            Text(
                                                quantity
                                            )
                                            .font(
                                                .caption.bold()
                                            )
                                            .padding(
                                                .horizontal,
                                                7
                                            )
                                            .padding(
                                                .vertical,
                                                3
                                            )
                                            .background(
                                                .thinMaterial
                                            )
                                            .clipShape(
                                                Capsule()
                                            )
                                        }

                                        if let detail =
                                            item.detail {

                                            Text(
                                                detail
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                            .fixedSize(
                                                horizontal: false,
                                                vertical: true
                                            )
                                        }
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }

            Section {

                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {

                    Text(
                        "Zdroj doporučení"
                    )
                    .font(.caption.bold())

                    Text(
                        "72 hodin · Ministerstvo vnitra ČR"
                    )
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                    Text(
                        "Seznam je přizpůsoben údajům z profilu domácnosti."
                    )
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                }
            }
        }
        .navigationTitle(
            "Domácí zásoby"
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
        .toolbar {

            ToolbarItem(
                placement:
                    .topBarTrailing
            ) {

                Menu {

                    Button(
                        "Resetovat checklist",
                        role: .destructive
                    ) {

                        store.reset()
                    }

                } label: {

                    Image(
                        systemName:
                            "ellipsis.circle"
                    )
                }
            }
        }
    }
}
