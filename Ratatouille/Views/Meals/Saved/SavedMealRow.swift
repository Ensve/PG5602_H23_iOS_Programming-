//  SavedMealRow.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI
import SwiftData

struct SavedMealRow: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    
    @Query(filter: #Predicate<MealDb>{$0.trash == false},
           sort: \MealDb.title, order: .forward, animation: .default) private var meals: [MealDb]
    
    var mealDb: MealDb
    

    var body: some View
    {
        NavigationStack
        {
            List(meals)
            {
                meal in
                
                NavigationLink(destination: SavedMealDetailsView(meal: meal))
                {
                    
                    HStack(alignment: .center)
                    {
                        ImageView(url: meal.image, width: 100)
                     
                        VStack(alignment: .leading)
                        {
                            Text(meal.title)
                                .fontWeight(.semibold)
                            Label(meal.area?.title ?? "Ukjent", systemImage: "globe")
                            
                            Label(meal.category?.title ?? "Ukjent", systemImage: "rectangle.3.group.bubble")
                        }
                        
                        if meal.favorite
                        {
                            Spacer()
                            Image(systemName: "star.fill").foregroundColor(.yellow).font(.title2)
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true)
                    {
                        Button
                        {
                            meal.favorite.toggle()
                            print("Selected Meal: \(meals[0].instructions)")

                        }
                        label:
                        {
                            Image(systemName: "star.fill")
                        }
                        .tint(.yellow)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false)
                    {
                        Button(role: .destructive)
                        {
                            meal.trash = true
                        }
                        label:
                        {
                            Image(systemName: "archivebox")
                        }
                    }
                }
            }
        }
    }
}

#Preview
{
    SavedMealRow(mealDb: MealDb(title: "")).modelContainer(for: [MealDb.self])
}
