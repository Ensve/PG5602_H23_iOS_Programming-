//  ViewModel.swift
//  Ratatouille
//  Created by 2002 on 15/11/2023.

import Foundation
import SwiftData


/*
 class ViewModel: ObservableObject
 {
 func getMeals(searchQuery: String) async -> [Meal] {
 guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchQuery)") else {
 return [Meal]()
 }
 
 do {
 let (data, _) = try await URLSession.shared.data(from: url)
 
 return try JSONDecoder().decode(MealsResponse.self, from: data).meals
 } catch {
 print("Error fetching meals: \(error)")
 return [Meal]()
 }
 }
 }
 */

/*
class ViewModel: ObservableObject {
    func getMeals(searchQuery: String, area: String?, category: String?, ingredient: String?) async -> [Meal] {
        var urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchQuery)"
        
        if let area = area, !area.isEmpty {
            urlString += "&a=\(area)"
        }
        
        if let category = category, !category.isEmpty {
            urlString += "&c=\(category)"
        }
        
        if let ingredient = ingredient, !ingredient.isEmpty {
            urlString += "&i=\(ingredient)"
        }
        
        guard let url = URL(string: urlString) else {
            return [Meal]()
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            return try JSONDecoder().decode(MealsResponse.self, from: data).meals
        } catch {
            print("Error fetching meals: \(error)")
            return [Meal]()
        }
    }
}
*/

class ViewModel: ObservableObject
{
    static let baseURL: String = "https://www.themealdb.com/api/json/v1/1/"
    
    func getMeals(searchQuery: String) async -> [Meal]
    {
        guard let url = URL(string: "\(ViewModel.baseURL)search.php?s=\(searchQuery)") else
        {
            
            return [Meal]()
        }
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MealsResponse.self, from: data).meals
            
        } catch
        {
            print("Error fetching meals: \(error)")
            return [Meal]()
        }
    }
    
    func getCategories(searchQuery: String) async -> [Meal]
    {
        guard let url = URL(string: "\(ViewModel.baseURL)filter.php?c=\(searchQuery)") else
        {
            
            return [Meal]()
        }
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MealsResponse.self, from: data).meals
        }
        catch
        {
            print("Error fetching categories: \(error)")
            return [Meal]()
        }
    }
    
    func getAreas(searchQuery: String) async -> [Meal]
    {
        guard let url = URL(string: "\(ViewModel.baseURL)filter.php?a=\(searchQuery)") else
        {
            return [Meal]()
        }
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MealsResponse.self, from: data).meals
        }
        catch
        {
            print("Error fetching areas: \(error)")
            return [Meal]()
        }
    }
    
    func getIngredients(searchQuery: String) async -> [Meal]
    {
        guard let url = URL(string: "\(ViewModel.baseURL)filter.php?i=\(searchQuery)") else
        {
            return [Meal]()
        }
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MealsResponse.self, from: data).meals
        }
        catch
        {
            print("Error fetching ingredients: \(error)")
            return [Meal]()
        }
    }
    
    func getCategory() async -> [Meal]
    {
        guard let url = URL(string: "\(ViewModel.baseURL)search.php?s=") else
        {
            return [Meal]()
        }
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MealsResponse.self, from: data).meals
        }
        catch
        {
            print("Error fetching categories: \(error)")
            return [Meal]()
        }
    }
    
    func getMealById(id: String) async -> [Meal] {
        guard let url = URL(string: "\(ViewModel.baseURL)lookup.php?i=\(id)") else {
            return [Meal]()
        }
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MealsResponse.self, from: data).meals
        }
        catch
        {
            print("Error fetching categories: \(error)")
            return [Meal]()
        }
    }
}
