//  ArchiveView.swift
//  Ratatouille
//  Created by 2002 on 14/11/2023.

import SwiftUI

struct ArchiveView: View
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSheet = false
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                Section("Landområder")
                {
                    ArchiveArea()
                }
                
                Section("Kategorier")
                {
                    ArchiveCategory()
                }
                
                Section("Ingredienser")
                {
                    ArchiveIngredient()
                }
                
                Section("Matoppskrifter")
                {
                    ArchiveMeal()
                }
            }
            
            .toolbar
            {
                ToolbarItem(placement: .topBarLeading)
                {
                    Button()
                    {
                        dismiss()
                    }
                label:
                    {
                        Image(systemName: "chevron.backward")
                        Text("Tilbake")
                    }
                }
            }
            .navigationTitle("Arkiv")
            //.fullScreenCover(isPresented: $showSheet, content: AirportAdd.init)
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        
    }
    
}

#Preview {
    ArchiveView()
}
