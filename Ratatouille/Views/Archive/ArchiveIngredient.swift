//  ArchiveIngredient.swift
//  Ratatouille
//  Created by 2002 on 14/11/2023.

import SwiftUI
import SwiftData

struct ArchiveIngredient: View
{
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<IngredientDb>{$0.trash == true},
           sort: \IngredientDb.update, order: .reverse, animation: .default) private var ingredient: [IngredientDb]
    
    var body: some View
    {
        if ingredient.isEmpty
        {
            Label("Ingen arkiverte ingredienser", systemImage: "carrot.fill")
        }
        else
        {
            ForEach(ingredient)
            {
                ingredient in
                
                VStack(alignment: .leading)
                {
                    Text(ingredient.title).fontWeight(.bold)
                    Text("Arkivert: \(ingredient.update.formatted(date: .abbreviated, time: .standard))")
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false)
                {
                    Button(role: .destructive)
                    {
                        context.delete(ingredient)
                    }
                    label:
                    {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel)
                    {
                        ingredient.update = Date.now
                        ingredient.trash = false
                    }
                    label:
                    {
                        Image(systemName: "tray.and.arrow.up.fill")
                    }
                }
            }
        }
    }
}



#Preview 
{
    ArchiveIngredient().modelContainer(for: [MealDb.self])
}
