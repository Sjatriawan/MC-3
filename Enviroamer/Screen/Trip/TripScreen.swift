//
//  TripScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 20/07/23.
//

import SwiftUI

struct TripScreen: View {
    var body: some View {
        ZStack{
            MapScreen()
            
            

        }.ignoresSafeArea()
    }
}

struct TripScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripScreen()
    }
}
