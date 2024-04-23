//  IngredientEdit.swift
//  Ratatouille
//  Created by 2002 on 03/12/2023.

import SwiftUI

struct IngredientEdit: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var ingredient: IngredientDb
    
    @State private var title = ""
    
    var body: some View
    {
        Form
        {
            TextField("Ingredients", text: $title)
            
            Section
            {
                Text("Opprettet: \(ingredient.create.formatted(date: .abbreviated, time: .standard))")
                Text("Sist endret: \(ingredient.update.formatted(date: .abbreviated, time: .standard))")
            }
            .foregroundStyle(.secondary)
        }
        .onAppear
        {
            title = ingredient.title
        }
        .toolbar
        {
            ToolbarItem(placement: .cancellationAction)
            {
                Button("Avbryt", role: .cancel)
                {
                    dismiss()
                }
            }
      
            ToolbarItem(placement: .principal)
            {
                Text("Redigere Ingredienser")
            }
      
            ToolbarItem(placement: .confirmationAction)
            {
                Button("Lagre")
                {
                    ingredient.title = title
                    ingredient.update = Date.now
          
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .navigationBarBackButtonHidden()
    }
}
