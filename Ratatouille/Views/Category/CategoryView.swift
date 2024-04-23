//  CategoryView.swift
//  Ratatouille
//  Created by 2002 on 21/11/2023.

import SwiftUI
import SwiftData

struct CategoryView: View
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<CategoryDb>{$0.trash == false},
           sort: \CategoryDb.title, order: .forward, animation: .default) private var categoryDb: [CategoryDb]
    
    @State private var json: [CategoryModel] = []

    
    @State private var showSheet = false
    @State private var showAlert = false
    
    var body: some View
    {
        NavigationStack
        {
            Group
            {
                if categoryDb.isEmpty
                {
                    ContentUnavailableView("Ingen kategorier registrert", systemImage: "square.stack.3d.up.slash")
                }
                else
                {
                    List(categoryDb)
                    {
                        category in
              
                        NavigationLink
                        {
                            CategoryEdit(category: category)
                        }
                        label:
                        {
                            CategoryRow(category: category)
                        }
                    }
                }
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
                
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button
                    {
                        Task
                        {
                            json = await downloadCategories()
                            showAlert.toggle()
                        }
                    }
                    label:
                    {
                        Image(systemName: "icloud.and.arrow.down.fill").font(.title)
                    }
                    .alert("Vil du importere \(json.count) kategorier?", isPresented: $showAlert)
                    {
                        Button("Nei", role: .cancel) {}
                        Button("Ja", role: .destructive)
                        {
                            if !json.isEmpty
                            {
                                for index in 0...json.count - 1
                                {
                                    let category = CategoryDb()
                                    category.title = json[index].strCategory
                                    context.insert(category)
                                }
                            }
                        }
                    }
                }
          
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button
                    {
                        showSheet.toggle()
                    }
                    label:
                    {
                        Image(systemName: "plus.circle.fill").font(.title)
                    }
                }
            }
            .sheet(isPresented: $showSheet)
            {
                CategoryAdd()
            }
            .navigationTitle("Kategorier")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    CategoryView().modelContainer(for: CategoryDb.self)
}


