//  IngredientAdd.swift
//  Ratatouille
//  Created by 2002 on 14/11/2023.

import SwiftUI

struct IngredientAdd: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var showSheet = false
    @State private var title: String = ""
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Ingrediens", text: $title)
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
                
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Lagre")
                    {
                        let ingredient = IngredientDb()
                        
                        ingredient.title = title
                                 
                        context.insert(ingredient)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .navigationTitle("Legg til ingredienser")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    IngredientAdd()
}
