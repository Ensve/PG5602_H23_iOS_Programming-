//  CategoryEdit.swift
//  Ratatouille
//  Created by 2002 on 03/12/2023.

import SwiftUI

struct CategoryEdit: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var category: CategoryDb
    
    @State private var title = ""
    
    var body: some View
    {
        Form
        {
            TextField("Kategorier", text: $title)
            
            Section
            {
                Text("Opprettet: \(category.create.formatted(date: .abbreviated, time: .standard))")
                Text("Sist endret: \(category.update.formatted(date: .abbreviated, time: .standard))")
            }
            .foregroundStyle(.secondary)
        }
        .onAppear
        {
            title = category.title
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
                Text("Redigere Kategorier")
            }
      
            ToolbarItem(placement: .confirmationAction)
            {
                Button("Lagre")
                {
                    category.title = title
                    category.update = Date.now
          
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .navigationBarBackButtonHidden()
    }
}


        
