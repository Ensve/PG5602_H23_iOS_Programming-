//  AreaRow.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI

struct AreaRow: View
{
    var area: AreaDb
  
    var body: some View
    {
        HStack(alignment: .center)
        {
            FlagView(area: area.countrycode, style: .shiny, size: .w64)
      
            VStack(alignment: .leading)
            {
                Text(area.title).fontWeight(.semibold)
                Text(area.countrycode)
            }
      
            if area.favorite
            {
                Spacer()
                Image(systemName: "star.fill").foregroundColor(.yellow).font(.title2)
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true)
        {
            Button
            {
                area.favorite.toggle()
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
                area.trash = true
            }
            label:
            {
                Image(systemName: "archivebox")
            }
        }
    }
}

