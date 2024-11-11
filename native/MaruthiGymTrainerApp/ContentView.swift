//
//  ContentView.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 25/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            GymMembersListView()
                .accessibilityIdentifier("GymMembersListView")
                .tabItem {
                    Text("Gym Members")
                    Image(systemName: "dumbbell.fill")
                }
            
            Text("Plans")
                .tabItem {
                    Text("Plans")
                    Image(systemName: "creditcard.fill")
                }
            Text("Tips")
                .tabItem {
                    Text("Tips")
                    Image(systemName: "bell.fill")
                }
            Text("Utilities")
                .tabItem {
                    Text("Utilities")
                    Image(systemName: "wrench.and.screwdriver.fill")
                }
            Text("More")
                .tabItem {
                    Text("More")
                    Image(systemName: "square.grid.3x3")
                }
            
        }
        .tint(GymAppTheme.universalThemeColor)
        
    }
}
