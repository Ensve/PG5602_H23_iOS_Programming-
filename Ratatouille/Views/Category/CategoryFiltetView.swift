//  CategoryFilteViewr.swift
//  Ratatouille
//  Created by 2002 on 13/11/2023.

import SwiftUI

struct CategoryFilterView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @State private var categories: [Category] = []
    
    @State private var selectedCategory: String = ""
    
    @State private var meals: [Meal] = []
    
    @State private var showSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.strCategory) { category in
                    NavigationLink {
                        CategoryDetailsView(category: category)
                    } label: {
                        Text(category.strCategory)
                    }
                    .onTapGesture {
                        selectedCategory = category.strCategory
                        Task {
                            do {
                                let response = try await MealDataManager.shared(category: selectedCategory)
                                meals = response.meals
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button() {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                        Text("Tilbake")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.title)
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                CategoryAdd()
            }
            .navigationTitle("Kategorier")
            .onAppear {
                Task {
                    do {
                        let response = try await MealDataManager().getCategories()
                        categories = response.categories
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

struct Category: Codable, Identifiable {
    let strCategory: String
    let id: String = UUID().uuidString
}

struct CategoryDetailsView: View {
    let category: Category

    var body: some View {
        Text("Details for category: \(category.strCategory)")
    }
}

#Preview {
    CategoryFilterView()
}

