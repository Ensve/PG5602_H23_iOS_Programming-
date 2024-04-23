//  AreaModel.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import Foundation

struct AreaModel: Decodable
{
    let strArea: String
}

struct Areas: Decodable
{
    let meals: [AreaModel]
}

func downloadAreas() async -> [AreaModel]
{
    guard let connection = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?a=list") else
    {
        return [AreaModel]()
    }
    do
    {
        let (data, _) = try await URLSession.shared.data(from: connection)
        return try JSONDecoder().decode(Areas.self, from: data).meals
    }
    catch
    {
        print("Error fetching areas: \(error)")
        return [AreaModel]()
    }
}
