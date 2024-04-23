//  HomeView.swift
//  Recipe
//  Created by 2002 on 13/11/2023.

import SwiftUI
import SwiftData

struct HomeView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    
    @Query(filter: #Predicate<MealDb>{$0.trash == false},
           sort: \MealDb.title, order: .forward, animation: .default) private var meals: [MealDb]
    
    var body: some View 
    {
        NavigationStack
        {
            Image("Rattatouille").resizable().scaledToFit().frame(width: 200)
          
            if (meals.isEmpty)
            {
                ContentUnavailableView("Ingen oppskrifter lagret", systemImage: "square.stack.3d.up.slash")
            }
            else
            {
                // SavedMealRow(mealDb: MealDb(title: ""))
                List(favoriteMeals + nonFavoriteMeals)
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
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
    
    private var favoriteMeals: [MealDb] {
           meals.filter { $0.favorite }
       }

       private var nonFavoriteMeals: [MealDb] {
           meals.filter { !$0.favorite }
       }
}

#Preview {
    HomeView()
}

