import Foundation

struct GuideTopic: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let symbolName: String

    // Krátký krizový obsah
    let sections: [GuideSection]

    // Delší podrobný obsah
    let articleSections: [GuideArticleSection]

    // Zdroj
    let sourceName: String
    let sourceURL: String?
}

struct GuideSection: Identifiable, Hashable {
    let id: String
    let title: String
    let items: [String]
}

struct GuideArticleSection: Identifiable, Hashable {
    let id: String
    let title: String
    let paragraphs: [String]
}
