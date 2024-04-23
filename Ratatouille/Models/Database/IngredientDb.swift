//  IngredientDb.swift
//  Ratatouille
//  Created by 2002 on 21/11/2023.

import Foundation
import SwiftData

@Model final class IngredientDb
{
    @Attribute(.unique) let id: UUID
    var oldId: String
    var title: String
    var descriptions: String
    var type: String
    var favorite: Bool
    var trash: Bool
    let create: Date
    var update: Date 
  
    @Relationship(deleteRule: .nullify, inverse: \MealDb.ingredients)
    var meals: [MealDb]?
    
    init()
    {
        id = UUID()
        oldId = ""
        title = ""
        descriptions = ""
        type = ""
        favorite = false
        trash = false
        create = Date.now
        update = Date.now
    }
}

