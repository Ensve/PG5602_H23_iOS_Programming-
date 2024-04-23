//  SearchArea.swift
//  Ratatouille
//  Created by 2002 on 20/11/2023.

import SwiftUI
import SwiftData

struct SearchArea: View
{
    @Binding var meals: [Meal]
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkMode") private var darkMode = false
    
    @Query(filter: #Predicate<AreaDb>{$0.trash == false},
           sort: \AreaDb.title, order: .forward, animation: .default) private var areas: [AreaDb]
    
    @State private var search = ""
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Group
                {
                    if areas.isEmpty
                    {
                        HStack
                        {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .tint(.yellow)
                            Text("Vennligst gå til innstillinger for å opprette landområder eller laste ned..")
                        }
                    }
                    else
                    {
                        Picker("Velg landområde", selection: $search)
                        {
                            ForEach(areas)
                            {
                                area in Text(area.title).tag(area.title)
                            }
                        }
                        .onAppear
                        {
                            if !areas.isEmpty {search = areas[0].title}
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
                            meals = await getMeal(url: "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(search)")
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
