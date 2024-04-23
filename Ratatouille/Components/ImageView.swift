//  ImageView.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI

struct ImageView: View 
{
    var url: String
    var width: CGFloat
    
    var body: some View
    {
        AsyncImage(url: URL(string: url))
        {
            phase in
          
            if let image = phase.image
            {
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
            else
            {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .foregroundStyle(.gray)
            }
        }
        .frame(width: width)
    }
}
