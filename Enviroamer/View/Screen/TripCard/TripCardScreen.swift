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
        ScrollView {
            VStack(alignment: .leading, spacing: 32){
                ItemImageCard(location: modelWisata.tourisms[2])
                
               TabBarView(selectedIndex: $selectedIndex)
                
                if selectedIndex == 0 {
                    CarbonContentTrip()
                } else if selectedIndex == 1 {
                    DestinationContentTrip()
                } else if selectedIndex == 2 {
                    ActivityOffsetContentTrip()
                } else if selectedIndex == 3 {
                    TransportationContentTrip()
                }
                   
            }
            .padding(.horizontal, 24)
        }
    }
    
    
    struct TabBarView : View {
        @Binding var selectedIndex : Int
        var tabBarOptions : [String] = ["Prediction" , "Eco-destination", "Offset", "Get around"]
         var body : some View {
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack (spacing: 32){
                     ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)), id: \.0) {
                         index , name in
                         TabBarItem(selectedIndex: $selectedIndex, tabBarItemName: name, tab: index,
                                    colorText: (index == selectedIndex) ? Color("green600") : Color("grey300")
                         )
                     }
                 }
             }
             .background(.white)
             .frame(height: 46)
        }
    }
    struct TabBarItem : View {
        @Binding var selectedIndex : Int
        var tabBarItemName : String
        var tab : Int
        var colorText : Color
        
        var body : some View {
            Button {
                self.selectedIndex = tab
            } label: {
                VStack{
                    Spacer()
                    Text(tabBarItemName)
                        .font(.system(size: 17))
                        .bold()
                        .foregroundColor(colorText)
                    
                    if selectedIndex == tab {
                        Color("green600")
                            .frame(height: 2)
                    } else {
                        Color.clear.frame(height: 2)
                            
                    }
                }
            }
            .buttonStyle(.plain)

        }
    }
    
    
    
}

struct TripCardScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripCardScreen()
            .environmentObject(TourismViewModel())

    }
}
