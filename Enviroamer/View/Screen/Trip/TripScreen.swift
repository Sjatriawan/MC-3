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
                HStack{
                    Text("Trips")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color("black800"))
                    Spacer()
                    NavigationLink(destination: {
                        TravelPlannerView()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color("green600"))
                        .font(.system(size: 34))
                    })
                    
                }
                .padding(.bottom, 13)
                SlidingTabView(selection: $selectedTab, tabs: ["Upcoming Trips", "Past Trips" , ], font: Font.system(size: 20 , weight: .bold, design: .rounded),
                               activeAccentColor: Color("black800"), selectionBarColor: Color("black800")
                )
                if selectedTab == 0 {
                    UpcomingTripsScreen()
                } else {
                    PastTripScreen()
                }
                Spacer()
                
                
            }
            .navigationBarBackButtonHidden(true)
            .padding(24)
//            .navigationTitle(Text("Trips"))
        }
    }
}

struct TripScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripScreen()
            .environmentObject(TourismViewModel())
            .environmentObject(TravelPlannerViewModel())
    }
}
