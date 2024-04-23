//  ArchiveArea.swift
//  Ratatouille
//  Created by 2002 on 14/11/2023.

import SwiftUI
import SwiftData

struct ArchiveArea: View 
{
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<AreaDb>{$0.trash == true},
           sort: \AreaDb.update, order: .reverse, animation: .default) private var areas: [AreaDb]
    
    var body: some View
    {
        if areas.isEmpty
        {
            Label("Ingen arkiverte landområder", systemImage: "globe")
        }
        else
        {
            ForEach(areas)
            {
                area in
                
                VStack(alignment: .leading)
                {
                    Text(area.title).fontWeight(.bold)
                    Text("Arkivert: \(area.update.formatted(date: .abbreviated, time: .standard))")
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false)
                {
                    Button(role: .destructive)
                    {
                        context.delete(area)
                    }
                    label:
                    {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button(role: .cancel)
                    {
                        area.update = Date.now
                        area.trash = false
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
    ArchiveArea().modelContainer(for: [MealDb.self])
}
