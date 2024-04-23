//  SearchMealView.swift
//  Ratatouille
//  Created by 2002 on 14/11/2023.

import SwiftUI

struct SearchMealView: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var viewModel = ViewModel()
    
    @State private var showSheet = false
    
    @Binding var searchQuery: String
    
    @Binding var meals: [Meal]
    
    var body: some View 
    {
        NavigationStack 
        {
            VStack
            {
                TextField("Søk", text: $searchQuery)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.primary)
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
                
                ToolbarItem(placement: .principal) 
                {
                    Text("Søk etter oppskrifter")
                }
                
                ToolbarItem(placement: .confirmationAction) 
                {
                    Button("Søk") 
                    {
                        Task
                        {
                            meals = await viewModel.getMeals(searchQuery: searchQuery)
                            dismiss()
                        }
                    }
                    .disabled(searchQuery.isEmpty)
                }
            }
            .padding()
            
            Spacer()
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .presentationDetents([.height(200), .medium])
        .presentationCornerRadius(20)
    }
}

#Preview {
    SearchMealView(searchQuery: .constant(""), meals: .constant([]))
}
