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
    var body: some View {
        NavigationStack{
            VStack{
              
                
            }
            .padding(24)
            .navigationTitle(Text("WishLists"))
           
        }
        
    }
}

struct WishlistScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishlistScreen()
    }
}
