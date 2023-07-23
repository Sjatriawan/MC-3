//
//  WishlistScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 20/07/23.
//

import SwiftUI
import SlidingTabView

struct WishlistScreen: View {
    @State private var selectedTab : Int = 0
    @EnvironmentObject private var modelWisata : TourismViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                SlidingTabView(selection: $selectedTab, tabs: ["Trips", "Destinations" , ], font: Font.custom("SFProRounded-Bold", size: 20),
                               activeAccentColor: Color("black800"), selectionBarColor: Color("black800")
                )
                if selectedTab == 0 {
                    TripsWishListScreen()
                } else {
                    DestinationWishListScreen()
                }
                Spacer()
               
            }
            .padding(24)
            .navigationTitle(Text("WishLists"))
           
        }
        
    }
    
  
}

struct WishlistScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishlistScreen()
            .environmentObject(TourismViewModel())
    }
}
