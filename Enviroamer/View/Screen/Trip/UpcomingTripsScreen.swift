//
//  UpcomingTripsScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 23/07/23.
//

import SwiftUI

struct UpcomingTripsScreen: View {
    @State private var upcomingTripsItems : [Location] = []
    @EnvironmentObject var modelWisata : TourismViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                if upcomingTripsItems.isEmpty{
                    EmptyUpcomingTrips()
                } else {
                    ItemUpcomingTrips(location: modelWisata.tourisms[0])
                }
            }
        }
    }
}



struct UpcomingTripsScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingTripsScreen()
            .environmentObject(TourismViewModel())
        
    }
}

struct EmptyUpcomingTrips : View {
    var body : some View {
        VStack(spacing: 12){
            Spacer()
            Image("travel-ilutration")
            Text("No trip plan yet")
                .foregroundColor(Color("black800"))
                .font(.custom("SFProRounded-Bold", size: 20))
            Text("Create your trip!\nBe mindful to our environment while strolling around.")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("black800"))
                .font(.custom("SFProRounded-Regular", size: 14))
            Button {
                
            } label: {
                Text("Create a Trip")
                    .foregroundColor(.white)
                    .frame(width: 156, height: 56)
                    .font(.custom("SFProRounded-Semibold", size: 17))
                    .background(Color("green600"))
                    .cornerRadius(12)
                
            }
            Spacer()
            Spacer()
            
            
            
        }
    }
}

struct ItemUpcomingTrips : View{
    var location : Location

    var body : some View {
        AsyncImage(url: URL(string: location.imageKota)) { Image in
            Image
                .resizable()
         
                
        } placeholder: {
            Image("placeholder")
                .resizable()
 
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 342, height: 205)
        .cornerRadius(12)
        .overlay{
            VStack {
                Spacer()
                ZStack{
                    Rectangle()
                        .frame(width: 342, height: 67)
                        .foregroundColor(Color("neutral200"))
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                    
                    HStack {
                        VStack {
                            Text(location.namaProvinsi!)
                                .foregroundColor(Color("black800"))
                                .font(.custom("SFProRounded-Semibold", size: 17))
                            
                            Text("6 Jul - 14 Jul")
                                .foregroundColor(Color("black800"))
                                .font(.custom("SFProRounded-Regular", size: 15))
                           
                        }
                        Spacer()
                        
                        Image("delete")
                    }
                    .padding(.horizontal,24)
        
                    
                }
            }
        }
    }
}
