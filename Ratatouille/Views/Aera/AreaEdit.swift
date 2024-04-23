//  AreaEdit.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI

struct AreaEdit: View
{
    @Bindable var area: AreaDb
  
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
  
    @State private var title = ""
    @State private var countrycode = ""
  
    var body: some View
    {
        Form
        {
            TextField("Landområde", text: $title)
            TextField("Landskode", text: $countrycode)
            FlagView(area: countrycode, style: .shiny, size: .w64)
      
            Section
            {
                Text("Opprettet: \(area.create.formatted(date: .abbreviated, time: .standard))")
                Text("Sist endret: \(area.update.formatted(date: .abbreviated, time: .standard))")
            }
            .foregroundStyle(.secondary)
        }
        .onAppear
        {
            title = area.title
            countrycode = area.countrycode
        }
        .toolbar
        {
            ToolbarItem(placement: .cancellationAction)
            {
                Button("Avbryt", role: .cancel)
                {
                    dismiss()
                }
            }
      
            ToolbarItem(placement: .principal)
            {
                Text("Redigere landområde")
            }
      
            ToolbarItem(placement: .confirmationAction)
            {
                Button("Lagre")
                {
                    area.title = title
                    area.countrycode = countrycode.uppercased()
                    area.update = Date.now
          
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .navigationBarBackButtonHidden()
    }
}

