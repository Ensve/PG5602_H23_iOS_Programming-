//  CategorySearch.swift
//  Ratatouille
//  Created by 2002 on 17/11/2023.


import SwiftUI
import SwiftData

struct SearchCategory: View
{
    @Binding var meals: [Meal]
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkMode") private var darkMode = false
    
    @Query(filter: #Predicate<CategoryDb>{$0.trash == false},
           sort: \CategoryDb.title, order: .forward, animation: .default) private var category: [CategoryDb]
    
    @State private var search = ""
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Group
                {
                    if category.isEmpty
                    {
                        HStack
                        {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .tint(.yellow)
                            Text("Vennligst gå til innstillinger for å opprette kategorier eller laste ned...")
                        }
                    }
                    else
                    {
                        Picker("Velg kategori", selection: $search)
                        {
                            ForEach(category)
                            {
                                category in Text(category.title).tag(category.title)
                            }
                        }
                        .onAppear
                        {
                            if !category.isEmpty { search = category[0].title}
                        }
                    }
                }
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
                
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Søk")
                    {
                        Task
                        {
                            meals = await getMeal(url: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(search)")
                            dismiss()
                        }
                    }
                    .disabled(search.isEmpty)
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .presentationDetents([.height(250), .medium])
        .presentationCornerRadius(20)
    }
}

/*
struct SearchCategory: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss

    @ObservedObject private var viewModel = ViewModel()
    @State private var meals: [Meal] = []
    @Binding var categories: [Meal]
    @Binding var searchQuery: String
    
    @State private var selectedCategory: Int?

    var body: some View 
    {
        NavigationStack 
        {
            List(meals)
            {
                category in
                Button 
                {
                    Task 
                    {
                        searchQuery = category.strCategory ?? ""
                        categories = await viewModel.getCategories(searchQuery: searchQuery)
                        dismiss()
                    }
                } 
                label:
                {
                    Text(category.strCategory ?? "")
                }
            }
            .onAppear 
            {
                Task 
                {
                    meals = await viewModel.getCategory()
                }
            }
            .toolbar 
            {
                ToolbarItem(placement: .topBarLeading) 
                {
                    Button
                    {
                        dismiss()
                    } 
                    label:
                    {
                        Text("Avbryt")
                    }
                }

                ToolbarItem(placement: .principal) 
                {
                    Text("Søk etter kategori")
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .presentationDetents([.height(200), .medium])
        .presentationCornerRadius(20)
    }
}

#Preview
{
    SearchCategory(categories: .constant([]), searchQuery: .constant(""))
}
*/
