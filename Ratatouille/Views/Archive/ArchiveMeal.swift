//  ArchiveMeal.swift
//  Ratatouille
//  Created by 2002 on 23/11/2023.

import SwiftUI
import SwiftData

struct ArchiveMeal: View
{
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<MealDb>{$0.trash == true},
           sort: \MealDb.update, order: .forward, animation: .default) private var meals: [MealDb]

    
    var body: some View
    {
        if meals.isEmpty
        {
            Label("Ingen arkiverte oppskrifter", systemImage: "fork.knife.circle")
        }
        else
        {
            ForEach(meals)
            {
                meal in
                
                VStack(alignment: .leading)
                {
                    Text(meal.title).fontWeight(.bold)
                    Text("Arkivert: \(meal.update.formatted(date: .abbreviated, time: .standard))")
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false)
                {
                    Button(role: .destructive)
                    {
                        context.delete(meal)
                    }
                    label:
                    {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel)
                    {
                        meal.update = Date.now
                        meal.trash = false
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

#Preview {
    ArchiveMeal().modelContainer(for: [MealDb.self])
}
