//
//  TripsWishListScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 23/07/23.
//

import SwiftUI

struct TripsWishListScreen: View {
    @EnvironmentObject var modelWisata : TourismViewModel
    @StateObject private var favVm  = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                                if favVm.favorites.isEmpty{
                                    EmptyWishLishScreen(location: TourismViewModel().tourisms[0])
                                } else {
                                    List{
                                        ForEach(favVm.favorites, id: \.self ) { item in
                                            NavigationLink {
                                                TripCardScreen(location: item)
                                            } label: {
                                                ItemTripFavorite(location: item)

                                            }
                                        }
                                    }
                                    .listStyle(.plain)
                                }
                
            }
            .onAppear{
                favVm.loadFavorites()
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
                MapScreen()
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
                    ItemTripFavorite(location: location)
                }
                
            }
            
        }
    }
}

struct ItemTripFavorite : View {
    @StateObject private var favVm  = FavoritesViewModel()
    var location : Location
    var body : some View {
        ZStack{
            Color("neutral200")
            HStack{
                AsyncImage(url: URL(string: location.imageKota)) { Image in
                    Image
                        .resizable()
                        .frame(width: 139)
                } placeholder: {
                    ShimmerView()
                        .frame(width: 139)
                }
                .padding(.trailing, 18)
                
                Text(location.namaProvinsi)
                    .font(.custom("SFProRounded-Semibold", size: 16))
                    .foregroundColor(Color("black800"))
                Spacer()
                
                Image(systemName: favVm.isFavorite(location) ? "heart.fill" : "heart")
                    .foregroundColor(favVm.isFavorite(location) ? Color("red600") : Color("grey100"))
                    .onTapGesture {
                        favVm.addToFavorites(location)
                    }
                    .font(.system(size: 24))
                    .padding(.trailing,16)
                    .padding(.bottom,40)
                    
                
                
                
            }
        }
        .cornerRadius(12)
        .frame(height: 105)
    }
}
