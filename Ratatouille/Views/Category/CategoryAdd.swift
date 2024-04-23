//  CategoryAdd.swift
//  Ratatouille
//  Created by 2002 on 03/12/2023.

import SwiftUI

struct CategoryAdd: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var showSheet = false
    @State private var title: String = ""
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Kategori", text: $title)
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
                        Image(systemName: "chevron.backward")
                        Text("Tilbake")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Lagre")
                    {
                        let category = CategoryDb()
                        
                        category.title = title
                                 
                        context.insert(category)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .navigationTitle("Legg til Kategorier")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    CategoryAdd()
}
