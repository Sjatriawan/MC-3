//
//  TripCardScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct TripCardScreen: View {
    @EnvironmentObject var modelWisata : TourismViewModel
    @State private var selectedIndex = 0
    
    var listTitleContent : [String] = [
     "Prediction",
     "Eco-destination",
     "Offset",
     "Get around"
    ]
    
    var listContent  : [ContentTripCardScreen<AnyView>] = [
        ContentTripCardScreen(
            title: "Get ready for the odyssey!",
            desc: "Before start your trip, understand your carbon footprint first",
            content: AnyView(CarbonContentTrip())
        ),
        
        ContentTripCardScreen(
            title: "Unforgettable adventure",
            desc: "Welcome to the wonderland for eco-conscious tourist. Discover many more interesting places that really suit you!",
            content: AnyView(DestinationContentTrip())
        ),
        ContentTripCardScreen(
            title: "Neutralize carbon footprint",
            desc: "There will always be many ways to minimize or eliminate environmental impact from travelling by offsetting your carbon footprint",
            content: AnyView(ActivityOffsetContentTrip())
        ),
        ContentTripCardScreen(
            title: "Get around the city",
            desc: "People say \"All roads lead to Rome.\" There are also many different ways to reach the same destination. Rethink how you will go there",
            content: AnyView(TransportationContentTrip())
        )
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            ItemImageCard(location: modelWisata.tourisms[2])
            
           
            
            TabView(selection: $selectedIndex) {
                ForEach(listContent.indices, id: \.self) {
                    index in
                    listContent[index]
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
        .padding(.horizontal, 24)
    }
}

struct TripCardScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripCardScreen()
            .environmentObject(TourismViewModel())

    }
}
