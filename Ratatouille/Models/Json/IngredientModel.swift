//  IngredientModel.swift
//  Ratatouille
//  Created by 2002 on 02/12/2023.

import Foundation

struct IngredientModel: Decodable
{
    let strIngredient: String
}

struct Ingredient: Decodable
{
    let meals: [IngredientModel]
}

func downloadIngredients() async -> [IngredientModel]
{
    guard let connection = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?i=list") else
    {
        return [IngredientModel]()
    }
    
    do
    {
        let (data, _) = try await URLSession.shared.data(from: connection)

        return try JSONDecoder().decode(Ingredient.self, from: data).meals
    }
    catch
    {
        print(error)
      
        return [IngredientModel]()
    }
}
