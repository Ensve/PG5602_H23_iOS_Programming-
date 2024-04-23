//  FlagView.swift
//  Ratatouille
//  Created by 2002 on 21/11/2023.

import SwiftUI

enum FlagStyle: String
{
    case flat
    case shiny
}

enum FlagSize: Int
{
    case w16 = 16
    case w24 = 24
    case w32 = 32
    case w48 = 48
    case w64 = 64
}

struct FlagView: View
{
    var area: String
    var style: FlagStyle
    var size: FlagSize
    
    var body: some View
    {
        AsyncImage(url: URL(string: "https://flagsapi.com/\(area)/\(style)/\(size.rawValue).png"))
        {
            phase in
            
            if let image = phase.image
            {
                image.resizable().scaledToFit()
            }
            else
            {
                Image(systemName: "flag.slash.fill")
                    .font(.title2).foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(Gradient(colors: [.red, .black]))
                    .clipShape(Circle())
            }
        }
        .frame(width: CGFloat(size.rawValue))
    }
}

#Preview 
{
    FlagView(area: "NO", style: .flat, size: .w64)
}
