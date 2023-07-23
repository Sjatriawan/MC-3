//
//  EnviroamerApp.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 18/07/23.
//

import SwiftUI

@main
struct EnviroamerApp: App {
<<<<<<< HEAD
    let persistenceController = PersistenceController.shared

=======
>>>>>>> origin/trip-card-screen
    //     add state ibjetc
        @StateObject private var modelWisata = TourismViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
<<<<<<< HEAD
                .environmentObject(modelWisata )
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
=======
                .environmentObject(modelWisata)
>>>>>>> origin/trip-card-screen

        }
    }
}
