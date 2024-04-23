//  CategoryDb.swift
//  Ratatouille
//  Created by 2002 on 21/11/2023.

import Foundation
import SwiftData

@Model final class CategoryDb
{
    @Attribute(.unique) let id: UUID
    var oldID: String
    var title: String
    var descriptions: String
    var image: String
    var favorite: Bool
    var trash: Bool
    let create: Date
    var update: Date
    
    @Relationship(deleteRule: .nullify, inverse: \MealDb.category)
    var meals: [MealDb]?
    
    init()
    {
        id = UUID()
        oldID = ""
        title = ""
        descriptions = ""
        image = ""
        favorite = false
        trash = false
        create = Date.now
        update = Date.now
    }
}
