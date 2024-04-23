//  AreaView.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI
import SwiftData

struct IngredientsView: View
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<IngredientDb>{$0.trash == false},
           sort: \IngredientDb.title, order: .forward, animation: .default) private var ingredientDb: [IngredientDb]
    
    @State private var json: [IngredientModel] = []
    
    @State private var showSheet = false
    @State private var showAlert = false
    
    var body: some View
    {
        NavigationStack
        {
            Group
            {
                if ingredientDb.isEmpty
                {
                    ContentUnavailableView("Ingen ingredienser registrert", systemImage: "square.stack.3d.up.slash")
                }
                else
                {
                    List(ingredientDb)
                    {
                        ingredient in
              
                        NavigationLink
                        {
                            IngredientEdit(ingredient: ingredient)
                        }
                        label:
                        {
                            IngredientRow(ingredient: ingredient)
                        }
                    }
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
          
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button
                    {
                        Task
                        {
                            json = await downloadIngredients()
                            showAlert.toggle()
                        }
                    }
                    label:
                    {
                        Image(systemName: "icloud.and.arrow.down.fill").font(.title)
                    }
                    .alert("Vil du importere \(json.count) ingredienser?", isPresented: $showAlert)
                    {
                        Button("Nei", role: .cancel) {}
                        Button("Ja", role: .destructive)
                        {
                            if !json.isEmpty
                            {
                                for index in 0...json.count - 1
                                {
                                    let ingredient = IngredientDb()
                                    ingredient.title = json[index].strIngredient
                                    context.insert(ingredient)
                                }
                            }
                        }
                    }
                }
          
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button
                    {
                        showSheet.toggle()
                    }
                    label:
                    {
                        Image(systemName: "plus.circle.fill").font(.title)
                    }
                }
            }
            .sheet(isPresented: $showSheet)
            {
                IngredientAdd()
            }
            .navigationTitle("Ingredienser")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    IngredientsView().modelContainer(for: IngredientDb.self)
}
