//
//  ContentView.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 18/07/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
       SplashScreen()
            .preferredColorScheme(.light)
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TourismViewModel())
    }
}
