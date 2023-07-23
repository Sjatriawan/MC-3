//
//  WishlistScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 20/07/23.
//

import SwiftUI
<<<<<<< HEAD

struct WishlistScreen: View {
    var body: some View {
        Text("Wishlist Screen")
    }
=======
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
    
  
>>>>>>> origin/trip-card-screen
}

struct WishlistScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishlistScreen()
<<<<<<< HEAD
=======
            .environmentObject(TourismViewModel())
>>>>>>> origin/trip-card-screen
    }
}
