//  CategoryModel.swift
//  Ratatouille
//  Created by 2002 on 03/12/2023.
/*
import Foundation

struct CategoryModel: Decodable
{
    let categories: [Category]
}

struct Category: Decodable
{
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}


func downloadCategories() async -> [Category]
{
    guard let connection = URL(string: "https//:www.themealdb.com/api/json/v1/1/list.php?c=list") else
    {
        return [Category]()
    }
  
    do
    {
        let (data, _) = try await URLSession.shared.data(from: connection)
    
        return try JSONDecoder().decode([Category].self, from: data)
    }
    catch
    {
        return [Category]()
    }
}
*/

import Foundation

struct CategoryModel: Decodable
{
    let strCategory: String
}

struct Category: Decodable
{
    let meals: [CategoryModel]
}

func downloadCategories() async -> [CategoryModel]
{
    guard let connection = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?c=list") else
    {
        return [CategoryModel]()
    }
    
    do
    {
        let (data, _) = try await URLSession.shared.data(from: connection)

        return try JSONDecoder().decode(Category.self, from: data).meals
    }
    catch
    {
        print(error)
      
        return [CategoryModel]()
    }
}
