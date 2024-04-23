//  AreaDb.swift
//  Ratatouille
//  Created by 2002 on 21/11/2023.

import Foundation
import SwiftData

@Model final class AreaDb
{
    @Attribute(.unique) let id: UUID
    var title: String
    var countrycode: String
    var favorite: Bool
    var trash: Bool
    let create: Date
    var update: Date
    
    
    @Relationship(deleteRule: .deny, inverse: \MealDb.area)
    
    init() {
        id = UUID()
        title = ""
        countrycode = ""
        favorite = false
        trash = false
        create = Date.now
        update = Date.now
    }
}
