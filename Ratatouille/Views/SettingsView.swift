//  SettingsView.swift
//  Recipe
//  Created by 2002 on 13/11/2023.

import SwiftUI

struct SettingsView: View
{
    @AppStorage("isDarkMode") private var darkMode = false
    
    @State private var showAera = false
    @State private var showCategories = false
    @State private var showArchive = false
    @State private var showIngredients = false
    @State private var database = ""
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                Button
                {
                    showAera.toggle()
                }
                label:
                {
                    Label("Redigere landområder", systemImage: "globe")
                }
                .fullScreenCover(isPresented: $showAera, content: AreaView.init)
                
                Button
                {
                    showCategories.toggle()
                }
                label:
                {
                    Label("Redigere kategori", systemImage: "rectangle.3.group.bubble")
                }
                .fullScreenCover(isPresented: $showCategories, content: CategoryView.init)
                
                Button
                {
                    showIngredients.toggle()
                }
                label:
                {
                    Label("Redigere ingredienser", systemImage: "carrot.fill")
                }
                .fullScreenCover(isPresented: $showIngredients, content: IngredientsView.init)
                
                Section
                {
                    Toggle(isOn: $darkMode)
                    {
                        Label("Aktiver mørk modus", systemImage: darkMode ? "moon.zzz": "moon.circle")
                    }
                }
                
                Section
                {
                    Button
                    {
                        showArchive.toggle()
                    }
                    label:
                    {
                        Label("Administrere arkiv", systemImage: "archivebox.fill")
                    }
                    .fullScreenCover(isPresented: $showArchive, content: ArchiveView.init)
                }
                
                /*
                Section
                {
                    DbLocationView()
                }
                .navigationTitle("Instillinger")
                 */
            }
            .environment(\.colorScheme, darkMode ? .dark : .light)
        }
    }
}

#Preview {
    SettingsView()
}
