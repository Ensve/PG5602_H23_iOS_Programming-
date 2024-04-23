//  SplashView.swift
//  Ratatouille
//  Created by 2002 on 03/12/2023.

import SwiftUI

struct SplashView: View 
{
    @Binding var splash: Bool

    @State private var size = 0.8
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var opacity = 0.4
    @State private var remy2Opacity = 0.0
    
    var body: some View 
    {
            ZStack 
            {
                Color(.black)
                
                ZStack
                {
                    Image("Rattatouille")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .zIndex(1)
                    
                    Image("remy2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .opacity(remy2Opacity)
                        .zIndex(0)
                        .offset(y: -52)
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear 
                {
                    withAnimation(.easeIn(duration: 1.0)) 
                    {
                        scale = CGSize(width: 1.5, height: 1.5)
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) 
                    {
                        withAnimation 
                        {
                            self.remy2Opacity = 1.0
                        }
                    }
                }
            }
            .onAppear 
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute:
                {
                    withAnimation(.easeIn(duration: 0.35))
                    {
                        scale = CGSize(width: 50, height: 50)
                        opacity = 0
                    }
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute:
                {
                    withAnimation(.easeIn(duration: 0.2))
                    {
                        self.splash = false
                    }
                })
            }
            .ignoresSafeArea(.all)
    }
}




#Preview
{
    SplashView(splash: .constant(true))
}
