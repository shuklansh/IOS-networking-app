//
//  ContentView.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 10/04/24.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show:"Breaking Bad")
                .tabItem {
                    Label(
                        "Breaking Bad",
                        systemImage: "tortoise"
                    )
                }
            QuoteView(show:"Better Call Saul")            
                .tabItem {
                    Label(
                        "Better Call Saul",
                        systemImage: "briefcase"
                    )
                }
        }.onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
