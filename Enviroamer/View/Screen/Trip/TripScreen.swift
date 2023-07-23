//
//  TripScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 20/07/23.
//

import SwiftUI

struct TripScreen: View {
    @Environment(\.managedObjectContext) private var viewContext

        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Trip.startDate, ascending: true)],
            animation: .default)
        private var trips: FetchedResults<Trip>
    var body: some View {
        VStack {
                   List {
                       ForEach(trips, id: \.self) { trip in
                           Text("Start Date: \(trip.startDate ?? Date())")
                           Text("End Date: \(trip.endDate ?? Date())")
                           // Display other properties as needed
                       }
                   }
               }
    }
}




struct TripScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripScreen()
    }
}
