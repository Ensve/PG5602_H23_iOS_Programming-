//  IngredientRow.swift
//  Ratatouille
//  Created by 2002 on 03/12/2023.

import SwiftUI

struct IngredientRow: View 
{
    var ingredient: IngredientDb
    
    var body: some View
    {
        HStack(alignment: .center)
        {
            VStack(alignment: .leading)
            {
                Text(ingredient.title)
                    .fontWeight(.semibold)
                
                if ingredient.favorite
                {
                    Spacer()
                    Image(systemName: "star.fill").foregroundColor(.yellow).font(.title2)
                }
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true)
        {
            Button
            {
                ingredient.favorite.toggle()
            }
            label:
            {
                Image(systemName: "star.fill")
            }
            .tint(.yellow)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false)
        {
            Button(role: .destructive)
            {
                ingredient.trash = true
            }
            label:
            {
                Image(systemName: "archivebox")
            }
        }
    }
}
