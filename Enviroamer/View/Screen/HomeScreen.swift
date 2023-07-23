//
//  HomeScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 18/07/23.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectionTab = 0
   
    
    var body: some View {
        TabView(selection: $selectionTab) {
            ExploreScreen()
                .tabItem {
                    if selectionTab == 0 {
                        Image("magnifying.glass.filled")
                    } else {
                        Image(systemName: "magnifyingglass")
                    }
                    Text("Explore")
                        .font(.custom("SFProRounded-Semibold", size: 13))

                }
                .tag(0)
                
            
            TripScreen()
                .tabItem {
                    if selectionTab == 1 {
                        Image("trip_active")
                    } else {
                        Image("trip_notActive")
                    }
                    Text("Trips")
                        .font(.custom("SFProRounded-Semibold", size: 13))
                }
                .tag(1)
            
            WishlistScreen()
                .tabItem {
                    if selectionTab == 2{
                        Image("heartActive")
                    } else {
                        Image("heartNotActive")
                    }
                    Text("Wishlist")
                        .font(.custom("SFProRounded-Semibold", size: 13))
                }
                .tag(2)
        }
        .accentColor(Color("green600"))
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(TourismViewModel())

    }
}


