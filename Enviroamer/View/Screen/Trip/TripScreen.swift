//
//  TripScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 20/07/23.
//

import SwiftUI
import SlidingTabView

struct TripScreen: View {
    @State private var selectedTab : Int = 0
    @EnvironmentObject var modelWisata : TourismViewModel

    
    var body: some View {
        NavigationStack{
            VStack{
                SlidingTabView(selection: $selectedTab, tabs: ["Upcoming Trips", "Past Trips" , ], font: Font.custom("SFProRounded-Bold", size: 20),
                               activeAccentColor: Color("black800"), selectionBarColor: Color("black800")
                )
                if selectedTab == 0 {
                    UpcomingTripsScreen()
                } else {
                   PastTripScreen()
                }
                Spacer()
              
                
            }
            .padding(24)
            .navigationTitle(Text("Trips"))
            
            
            
            
        }
    }
}

struct TripScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripScreen()
            .environmentObject(TourismViewModel())
    }
}
