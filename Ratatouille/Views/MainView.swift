//  ContentView.swift
//  Recipe
//  Created by 2002 on 13/11/2023.

import SwiftUI

struct MainView: View
{
    @AppStorage("isDarkMode") private var darkMode = false

    var body: some View
    {
        TabView
        {
            HomeView()
                .tabItem
                {
                    Label("Mine Oppskrifter", systemImage: "fork.knife.circle.fill")
                }
            
            SearchView()
                .tabItem
                {
                    Label("Søk", systemImage: "magnifyingglass.circle.fill")
                }
            
            SettingsView()
                .tabItem
                {
                    Label("Instillinger", systemImage: "gearshape")
                }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    MainView().modelContainer(for: [MealDb.self, IngredientDb.self])
}

