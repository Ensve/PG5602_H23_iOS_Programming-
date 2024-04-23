//  FileView.swift
//  Ratatouille
//  Created by 2002 on 21/11/2023.

import SwiftUI

struct DbLocationView: View
{
    @State private var path = ""
    
    var body: some View
    {
        Button
        {
            guard let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
            else
            {
                return
            }
            
            let url = urlApp.appendingPathComponent("default.store")
            
            if FileManager.default.fileExists(atPath: url.path)
            {
                path = url.absoluteString
            }
            
            print(path)
            
        }
        label:
        {
            Label("Vis database lokasjon", systemImage: "internaldrive.fill")
        }
        
        if path != ""
        {
            TextField("", text: $path, axis: .vertical).lineLimit(2...10)
        }
    }
}

#Preview {
    DbLocationView().modelContainer(for: MealDb.self)
}
