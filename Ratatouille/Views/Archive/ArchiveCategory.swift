//  ArchiveCategory.swift
//  Ratatouille
//  Created by 2002 on 14/11/2023.

import SwiftUI
import SwiftData

struct ArchiveCategory: View 
{
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<CategoryDb>{$0.trash == true},
           sort: \CategoryDb.update, order: .reverse, animation: .default) private var category: [CategoryDb]
    
    var body: some View
    {
        if category.isEmpty
        {
            Label("Ingen arkiverte kategorier", systemImage: "rectangle.3.group.bubble")
        }
        else
        {
            ForEach(category)
            {
                category in
                
                VStack(alignment: .leading)
                {
                    Text(category.title).fontWeight(.bold)
                    Text("Arkivert: \(category.update.formatted(date: .abbreviated, time: .standard))")
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false)
                {
                    Button(role: .destructive)
                    {
                        context.delete(category)
                    }
                    label:
                    {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel)
                    {
                        category.update = Date.now
                        category.trash = false
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
    ArchiveCategory().modelContainer(for: [MealDb.self])
}
