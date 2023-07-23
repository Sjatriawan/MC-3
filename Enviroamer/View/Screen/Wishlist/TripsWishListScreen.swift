//
//  TripsWishListScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 23/07/23.
//

import SwiftUI

struct TripsWishListScreen: View {
    @State private var wishlistItems : [Tourism] = []
    @EnvironmentObject var modelWisata : TourismViewModel
    @State private var isWislisht : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                if wishlistItems.isEmpty{
                    EmptyWishLishScreen(location: modelWisata.tourisms[0], isWislisht: $isWislisht)
                   
                } else {
                    List(wishlistItems.indices){ item in
                        ItemTripFavorite(location: modelWisata.tourisms[item], isWislisht: $isWislisht)
                        
                    }
                }
            }
        }
    }
}

struct TripsWishListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripsWishListScreen()
            .environmentObject(TourismViewModel())
    }
}

struct EmptyWishLishScreen : View{
    var location : Location
    @Binding var isWislisht : Bool

    var body : some View {
        VStack(spacing: 12){
            Spacer()
            Text("No wishlist yet")
                .foregroundColor(Color("black800"))
                .font(.custom("SFProRounded-Bold", size: 20))
            Text("Tap on the heart icon for places that \npique your interest")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("black800"))
                .font(.custom("SFProRounded-Regular", size: 14))
            Button {
                
            } label: {
                Text("Explore")
                    .foregroundColor(.white)
                    .frame(width: 156, height: 56)
                    .font(.custom("SFProRounded-Semibold", size: 17))
                    .background(Color("green600"))
                    .cornerRadius(12)
                
            }
            Spacer()
            
            VStack(alignment: .leading){
                HStack {
                    Text("Try this out")
                        .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Bold", size: 17))
                    Spacer()
                }
                ItemTripFavorite(location: location, isWislisht: $isWislisht)
            }
            
        }
    }
}

struct ItemTripFavorite : View {
    var location : Location
    @Binding var isWislisht : Bool
    var body : some View {
        ZStack{
            Color("neutral200")
            HStack{
                AsyncImage(url: URL(string: location.imageKota)) { Image in
                    Image
                        .resizable()
                        .frame(width: 139)
                } placeholder: {
                    Image("placeholder")
                        .resizable()
                        .frame(width: 139)
                }
                .padding(.trailing, 18)
                
                Text(location.namaProvinsi!)
                    .font(.custom("SFProRounded-Semibold", size: 16))
                    .foregroundColor(Color("black800"))
                Spacer()
                
                VStack {
                    Button {
                        isWislisht.toggle()
                    } label: {
                        !isWislisht ? Image(systemName: "heart")
                                          .foregroundColor(Color("red600"))
                                         
                        : Image(systemName: "heart.fill")
                            .foregroundColor(Color("red600"))
                          
                    }
                    .font(.system(size: 24))
                    
                    Spacer()
                }
                .padding(.trailing,16)
                .padding(.top,10)
              
               

                
            }
        }
        .cornerRadius(12)
        .frame(height: 105)
    }
}
