//
//  ExploreScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ExploreScreen: View {
    @EnvironmentObject var modelWisata : TourismViewModel
    let idProvinsi : Int = 1
    
    var body: some View {
        let data = self.modelWisata.tourisms[idProvinsi].listWisata
        let dataOffset = self.modelWisata.tourisms[idProvinsi].kegiatanOffset
        NavigationStack {
            ScrollView (showsIndicators: false){
                VStack(alignment: .leading, spacing: 24){
                    NavigationLink {
                        MapScreen()
                                       } label: {
                                           searchBar
                                       }
                    Text("Explore New Place")
                    ScrollView(.horizontal) {
                        HStack (spacing: 12){
                            ForEach(data.indices){ item in
                                NavigationLink(destination: {
                                    DestinationScreen(destinasi: data[item])
                                }, label: {
                                   ItemContentVertical(tourism: data[item])
                                })
                            }
                        }
                    }
                    Text("Events to join")
                    
                    ForEach(dataOffset.indices){ item in
                        NavigationLink(destination: {
                            ActivityOffsetScreen(activityOffset: dataOffset[item])
                        }, label: {
                            ItemContentHorizontal(activity: dataOffset[item])
                        })
                        
                    }
                    
                }
                .font(.custom("SFProRounded-Semibold", size: 28))
                .foregroundColor(Color("black800"))
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
                .font(.custom("SFProRounded-Regular", size: 17))
                .foregroundColor(Color("black800"))
            HStack{
                Text("Destination •")
                
                Text("Date •")
                
                Text("Accommodation")
            }
            .font(.custom("SFProRounded-Regular", size: 12))
            .foregroundColor(Color("black800"))
         
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







