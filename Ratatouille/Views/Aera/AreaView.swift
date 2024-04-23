//  AreaView.swift
//  Ratatouille
//  Created by 2002 on 22/11/2023.

import SwiftUI
import SwiftData

struct AreaView: View 
{
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<AreaDb>{$0.trash == false},
           sort: \AreaDb.title, order: .forward, animation: .default) private var areaDb: [AreaDb]
    
    @State private var json: [AreaModel] = []
    
    @State private var showSheet = false
    @State private var showAlert = false
    
    var body: some View
    {
        NavigationStack
        {
            Group
            {
                if areaDb.isEmpty
                {
                    ContentUnavailableView("Ingen landområder registrert", systemImage: "square.stack.3d.up.slash")
                }
                else
                {
                    List(areaDb)
                    {
                        area in
              
                        NavigationLink
                        {
                            AreaEdit(area: area)
                        }
                        label:
                        {
                            AreaRow(area: area)
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
                            json = await downloadAreas()
                            showAlert.toggle()
                        }
                    }
                    label:
                    {
                        Image(systemName: "icloud.and.arrow.down.fill").font(.title)
                    }
                    .alert("Vil du importere \(json.count) landområder?", isPresented: $showAlert)
                    {
                        Button("Nei", role: .cancel) {}
                        Button("Ja", role: .destructive)
                        {
                            if !json.isEmpty
                            {
                                for index in 0...json.count - 1
                                {
                                    let area = AreaDb()
                                    area.title = json[index].strArea
                                    context.insert(area)
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
                AreaAdd()
            }
            .navigationTitle("Landområder")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    AreaView().modelContainer(for: AreaDb.self)
}
