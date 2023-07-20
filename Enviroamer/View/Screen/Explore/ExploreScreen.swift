//
//  ExploreScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ExploreScreen: View {
    @EnvironmentObject var modelWisata : TourismViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24){
                    NavigationLink {
                        MapScreen()
                    } label: {
                        searchBar
                    }
                    Text("Explore New Place")
                    ScrollView(.horizontal) {
                        HStack (spacing: 12){
                            ForEach(modelWisata.tourisms[0].listWisata){ item in
                                NavigationLink(destination: {
                                    TripCardScreen()
                                }, label: {
                                    ItemContentVertical(tourism: item)
                                })
                            }
                        }
                    }
                    Text("Activities Around You")
                    
                    ForEach(modelWisata.tourisms[1].kegiatanOffset){ item in
                        NavigationLink(destination: {
                            TripCardScreen()
                        }, label: {
                            ItemContentHorizontal(activity: item)
                        })
                        
                    }
                    
                }
                .font(.system(size: 28))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                 .padding(24)
            }
        }
    }
}

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
            .environmentObject(TourismViewModel())
    }
}

// costum search bar
var searchBar : some View {
    HStack(alignment: .center, spacing: 12){
        Image("globe")
            .foregroundColor(Color("green"))
            .font(.system(size: 32))
        
        VStack(alignment: .leading){
            Text("Plan Your Trip")
                .font(.system(size: 17))
                .foregroundColor(.black)
                .fontWeight(.regular)
            HStack{
                Text("Destination •")
                
                Text("Date •")
                
                Text("Accommodation")
            }
            .font(.system(size: 12))
            .foregroundColor(.black)
            .fontWeight(.regular)
            
        }
    }
    .padding()
    .cornerRadius(12)
    .frame(width: 341, height: 62, alignment: .leading)
    .shadow(color: Color(red: 0.2, green: 0.2, blue: 0.2).opacity(0.25), radius: 4, x: 1, y: 1)
    .overlay(
        RoundedRectangle(cornerRadius: 12)
            .inset(by: 1)
            .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 2)
    )
    
}
