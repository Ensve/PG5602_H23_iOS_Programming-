//  AreaAdd.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI

struct AreaAdd: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
        
    @State private var title: String = ""
    @State private var countrycode: String = ""
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Landområde", text: $title)
                TextField("Landskode", text: $countrycode)
                FlagView(area: countrycode, style: .shiny, size: .w64)
            }
            .toolbar
            {
                ToolbarItem(placement: .topBarLeading)
                {
                    Button()
                    {
                        dismiss()
                    }
                    label:
                    {
                        Text("Avbryt")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Lagre")
                    {
                        let area = AreaDb()
                        
                        area.title = title
                        area.countrycode = countrycode
                                 
                        context.insert(area)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .navigationTitle("Legg til landområde")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview
{
    AreaAdd()
}
