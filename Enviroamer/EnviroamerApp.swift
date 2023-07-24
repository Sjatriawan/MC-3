//
//  EnviroamerApp.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 18/07/23.
//

import SwiftUI

@main
struct EnviroamerApp: App {
    let persistenceController = PersistenceController.shared

        @StateObject private var modelWisata = TourismViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelWisata )
                .environment(\.managedObjectContext, persistenceController.container.viewContext)


        }
    }
}
