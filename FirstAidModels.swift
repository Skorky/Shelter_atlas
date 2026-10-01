//
//  FirstAidModels.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//

import Foundation

struct FirstAidArticleSection: Identifiable, Hashable {

    let id: String
    let title: String
    let paragraphs: [String]
}

struct FirstAidTopic: Identifiable, Hashable {

    let id: String
    let title: String
    let subtitle: String
    let symbolName: String
    let emergencyNumber: String?
    let urgent: Bool
    let steps: [String]
    let warnings: [String]
    let articleSections: [FirstAidArticleSection]
    let sourceName: String
    let sourceURL: String?
}
