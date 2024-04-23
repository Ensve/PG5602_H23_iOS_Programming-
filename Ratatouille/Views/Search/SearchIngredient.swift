//  SearchIngredient.swift
//  Ratatouille
//  Created by 2002 on 03/12/2023.

import SwiftUI
import SwiftData

struct SearchIngredient: View 
{
    @Binding var meals: [Meal]
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkMode") private var darkMode = false
    
    @Query(filter: #Predicate<IngredientDb>{$0.trash == false},
           sort: \IngredientDb.title, order: .forward, animation: .default) private var ingredient: [IngredientDb]
    
    @State private var search = ""
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Group
                {
                    if ingredient.isEmpty
                    {
                        HStack
                        {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .tint(.yellow)
                            Text("Vennligst gå til innstillinger for å opprette ingredienser eller laste ned..")
                        }
                    }
                    else
                    {
                        Picker("Velg ingredients", selection: $search)
                        {
                            ForEach(ingredient)
                            {
                                ingredient in Text(ingredient.title).tag(ingredient.title)
                            }
                        }
                        .onAppear
                        {
                            if !ingredient.isEmpty { search = ingredient[0].title}
                        }
                    }
                }
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
                
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Søk")
                    {
                        Task
                        {
                            meals = await getMeal(url: "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(search)")
                            dismiss()
                        }
                    }
                    .disabled(search.isEmpty)
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .presentationDetents([.height(250), .medium])
        .presentationCornerRadius(20)
    }
}


