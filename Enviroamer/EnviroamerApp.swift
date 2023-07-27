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
        @StateObject private var favoriteViewModel = FavoritesViewModel()
        @StateObject private var travelPlannerViewModel = TravelPlannerViewModel()
        @StateObject private var favoriteDestinationViewModel  = FavoriteDestinationViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelWisata )
                .environmentObject(favoriteViewModel)
                .environmentObject(travelPlannerViewModel)
                .environmentObject(favoriteDestinationViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)


        }
    }
}
