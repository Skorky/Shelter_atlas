//
//  AppTabView.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 29.09.2026.
//
import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }

            ChecklistView()
                .tabItem {
                    Label("Co vzít", systemImage: "checklist")
                }

            EmergencyBagView()
                .tabItem {
                    Label("Zavazadlo", systemImage: "backpack.fill")
                }

            GuideView()
                .tabItem {
                    Label("Příručka", systemImage: "book.fill")
                }

            HouseholdView()
                .tabItem {
                    Label("Profil", systemImage: "person.2.fill")
                }
        }
    }
}
