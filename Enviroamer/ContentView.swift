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
<<<<<<< HEAD
        HomeScreen()
    } 
=======
       HomeScreen()
    }
//     check nama font 
    init(){
        for familyName in UIFont.familyNames {
            print(familyName)
            for fontName in UIFont.fontNames(forFamilyName: familyName){
                print("---\(fontName)---")
            }
        }
    }
>>>>>>> origin/trip-card-screen
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TourismViewModel())
    }
}
