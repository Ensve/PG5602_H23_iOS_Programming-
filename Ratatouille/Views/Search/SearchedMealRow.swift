//  SearchMealRow.swift
//  Ratatouille
//  Created by 2002 on 15/11/2023.


import SwiftUI
import SwiftData

struct SearchViewRow: View {
    @ObservedObject private var viewModel = ViewModel()
    
    @Binding var searchQuery: String
    @Binding var searchedMeals: [Meal]
    
    @State private var meals: [Meal] = []
    @State private var ingredients = "Ingen ingredienser"
    
    @Environment(\.modelContext) private var context
    
    var mealDb: MealDb
    
    var body: some View
    {
        NavigationStack
        {
            List(searchedMeals)
            {
                meal in
                
                NavigationLink(destination: MealDetailsView(id: meal.idMeal ?? "", meal: meal))
                {
                    HStack(alignment: .center)
                    {
                        ImageView(url: meal.strMealThumb ?? "", width: 100)
                        
                        VStack(alignment: .leading)
                        {
                            Text(meal.strCategory ?? "")
                                .font(.headline)
                            Text(meal.strMeal ?? "")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false)
                    {
                        Button(role: .none)
                        {
                            saveMealToSwiftData(meal: meal)
                            
                            /*
                            let mealDb = MealDb(title: "")
                            let areaDb = AreaDb()
                            let category = mealDb.category
                            mealDb.oldID = meal.idMeal ?? "Ukjent"
                            mealDb.title = meal.strMeal ?? "Ukjent"
                            mealDb.instructions = meal.strInstructions ?? "Ukjent"
                            mealDb.image = meal.strMealThumb ?? "Ukjent"
                            mealDb.ingredients = ingredients
                            areaDb.title = meal.strArea ?? "Ukjent"
                            category?.title = meal.strCategory ?? "Ukjent"
                            context.insert(mealDb)
                             */
                        }
                        label:
                        {
                            Image(systemName: "heart")
                        }
                        .tint(.green)
                    }
                }
            }
        }
    }
    private func saveMealToSwiftData(meal: Meal) 
    {
        let mealDb = MealDb(title: "")
        let areaDb = AreaDb()
        let categoryDb = CategoryDb()

        mealDb.oldID = meal.idMeal ?? "Ukjent"
        mealDb.title = meal.strMeal ?? "Ukjent"
        mealDb.instructions = meal.strInstructions ?? "Ukjent"
        mealDb.image = meal.strMealThumb ?? "Ukjent"

        areaDb.title = meal.strArea ?? "Ukjent"
        categoryDb.title = meal.strCategory ?? "Ukjent"
        
        mealDb.area = areaDb
        mealDb.category = categoryDb

        context.insert(mealDb)
        print("Instructions: \(meal.strInstructions ?? "N/A")")
        print("API Response for Meal: \(meal)")
    }
}
