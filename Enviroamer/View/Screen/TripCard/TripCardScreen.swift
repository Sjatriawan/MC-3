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
    
    let idProvinsi  : Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32){
                    ItemImageCard(location: modelWisata.tourisms[idProvinsi])
                    
                   TabBarView(selectedIndex: $selectedIndex)
                    
                    if selectedIndex == 0 {
                        CarbonContentTrip()
                    } else if selectedIndex == 1 {
                        DestinationContentTrip(idProvinsi: idProvinsi)
                    } else if selectedIndex == 2 {
                        ActivityOffsetContentTrip(idProvinsi: idProvinsi)
                    } else if selectedIndex == 3 {
                        TransportationContentTrip(idProvinsi: idProvinsi)
                    } else {
                        Text("")
                    }
                       
                }
                .padding(.horizontal, 24)
            }
        }
        .toolbar(.hidden, for: .tabBar)

    }
    
    
    struct TabBarView : View {
        @Binding var selectedIndex : Int
        var tabBarOptions : [String] = ["Prediction" , "Eco-destination", "Offset", "Get around"]
         var body : some View {
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack (spacing: 24){
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
                        .font(.custom("SFProRounded-Bold", size: 17))
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
        TripCardScreen(idProvinsi: 2)
            .environmentObject(TourismViewModel())

    }
}
