//
//  UpcomIngTripsScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 19/07/23.
//

import SwiftUI

struct UpcomingTrips: View{
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 20) {
                       CardView(title: "Nusa Penida", location: "Bali, Indonesia", backgroundColor: .brown)
                       CardView(title: "Santorini", location: "Greece", backgroundColor: .blue)
                       CardView(title: "Maui", location: "Hawaii, USA", backgroundColor: .green)
                   }
                   .padding(.horizontal, 10) // Add padding to adjust spacing at the edges
               }
    }
}


struct UpcomIngTripsScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingTrips()
    }
}
