//
//  MaruthiGymTrainerApp.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 25/10/24.
//

import SwiftUI
import SwiftData

@main
struct MaruthiGymTrainerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GymMember.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
               
        }
        .modelContainer(sharedModelContainer)
    }
}



/*
 Todo
 
 - add standard , advanced equipment check in adding members
 - add optional  photo in member add screen
 - delete members
 - edit members
 
 
 
 */
