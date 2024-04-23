//  MealDb.swift
//  Ratatouille
//  Created by 2002 on 21/11/2023.

import Foundation
import SwiftData

@Model final class MealDb: Identifiable
{
    @Attribute(.unique) let id: UUID
    var oldID: String
    var title: String
    var instructions: String
    var ingredients: IngredientDb?
    var area: AreaDb?
    var category: CategoryDb?
    var image: String
    var youtube: String
    var source: String
    let create: Date
    var update: Date
    var saved: Bool
    var trash: Bool
    var favorite: Bool
    
    
    init(title: String)
    {
        id = UUID()
        oldID = ""
        self.title = title
        instructions = ""
        image = ""
        youtube = ""
        source = ""
        trash = false
        create = Date.now
        update = Date.now
        saved = false
        favorite = false
    }
}
