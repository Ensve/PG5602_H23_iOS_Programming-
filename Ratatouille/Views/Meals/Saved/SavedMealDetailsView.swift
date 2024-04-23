//  SavedMealDetailsView.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI
import SwiftData

struct SavedMealDetailsView: View
{    
    var meal: MealDb

    var body: some View 
    {
        Form
        {
            ImageView(url: meal.image, width: .infinity)
            Text(meal.title).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            HStack
            {
                Image(systemName: "globe")
                Text(meal.area?.title ?? "Ukjent Område")
                
                Divider()
                
                Image(systemName: "rectangle.3.group.bubble")
                Text(meal.category?.title ?? "Ukjent Kategori")
            }
            .foregroundStyle(.secondary)
            
            Section("Instruksjoner")
            {
                if meal.instructions.isEmpty
                {
                    Text("Ingen instruksjoner")
                }
                else
                {
                    Text(meal.instructions)

                }
            }
        }
        .navigationTitle("Detaljer")
    }
}

#Preview 
{
    SavedMealDetailsView(meal: MealDb(title: ""))
}
