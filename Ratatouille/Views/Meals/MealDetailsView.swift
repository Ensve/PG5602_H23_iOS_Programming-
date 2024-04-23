//  MealDetailsView.swift
//  Ratatouille
//  Created by 2002 on 15/11/2023.

import SwiftUI

struct MealDetailsView: View 
{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var meals: [Meal] = []
    @State private var ingredients = "Ingen ingredienser"
    
    var id: String
    
    let meal: Meal
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                ImageView(url: meals.first?.strMealThumb ?? "", width: .infinity)
                Text(meals.first?.strMeal ?? "Ukjent tittel").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                HStack
                {
                    Image(systemName: "globe")
                    Text(meals.first?.strArea ?? "Ukjent Område")
                    
                    Divider()
                    
                    Image(systemName: "rectangle.3.group.bubble")
                    Text(meals.first?.strCategory ?? "Ukjent Kategori")
                }
                .foregroundStyle(.secondary)
                
                Section("Instruksjoner")
                {
                    Text(meals.first?.strInstructions ?? "Ingen instruksjoner")
                }
                
                Section("Ingredienser")
                {
                    Text(ingredients)
                }
            }
            .task
            {
                meals = await getMeal(url: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")
                
                if !meals.isEmpty
                {
                    var ingredient: String
                    
                    ingredient = (meals.first?.strIngredient1 ?? "") + ": " + (meals.first?.strMeasure1 ?? "")
                    ingredients = (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient2 ?? "") + ": " + (meals.first?.strMeasure2 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient3 ?? "") + ": " + (meals.first?.strMeasure3 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient4 ?? "") + ": " + (meals.first?.strMeasure4 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient5 ?? "") + ": " + (meals.first?.strMeasure5 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient6 ?? "") + ": " + (meals.first?.strMeasure6 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient7 ?? "") + ": " + (meals.first?.strMeasure7 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient8 ?? "") + ": " + (meals.first?.strMeasure8 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient9 ?? "") + ": " + (meals.first?.strMeasure9 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                    
                    ingredient = (meals.first?.strIngredient10 ?? "") + ": " + (meals.first?.strMeasure10 ?? "")
                    ingredients += (ingredient == ": ") ? "" : ingredient + "\n"
                }
            }
        }
        .navigationTitle("Detaljer")
    }
}

