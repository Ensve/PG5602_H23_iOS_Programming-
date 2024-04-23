//  RatatouilleApp.swift
//  Ratatouille
//  Created by 2002 on 13/11/2023.

import SwiftUI
import SwiftData

@main struct RatatouilleApp: App
{
    @State private var isSplash = true
    
    let container: ModelContainer
    
    init()
    {
        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "raratouille.store"))
      
        do
        {
            container = try ModelContainer(for: MealDb.self, configurations: config)
        }
        catch
        {
            fatalError("Beklager, kunne ikke åpne databasen.")
        }
    }
    
    var body: some Scene
    {
        
        
        WindowGroup
        {
            if isSplash
            {
                SplashView(splash: $isSplash)
            }
            else
            {
                MainView()
            }
        }
        .modelContainer(container)
    }
}
