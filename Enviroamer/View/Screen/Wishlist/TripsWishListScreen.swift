//
//  TripsWishListScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 23/07/23.
//

import SwiftUI

struct TripsWishListScreen: View {
    
    @EnvironmentObject var favoriteItem : FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                
                if favoriteItem.favorites.isEmpty{
                    EmptyWishLishScreen(location: TourismViewModel().tourisms[0])
                } else {
                    List{
                        ForEach(favoriteItem.favorites, id: \.self ) { item in
                            NavigationLink {
                                TripCardScreen(location: item)
                            } label: {
                                ItemTripFavorite(location: item)
                                
                            }
                        }
                    }
                    .listStyle(.inset)

                }
                
            }
           
        }
    }
}

struct TripsWishListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripsWishListScreen()
            .environmentObject(FavoritesViewModel())
    }
}

struct EmptyWishLishScreen : View{
    var location : Location
    
    var body : some View {
        VStack(spacing: 12){
            Spacer()
            Text("No wishlist yet")
                .foregroundColor(Color("black800"))
                .font(.system(size: 20, weight: .bold, design: .rounded))
            Text("Tap on the heart icon for places that \npique your interest")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("black800"))
        
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                NavigationLink {
                    MapScreen()
                } label: {
                    Text("Explore")
                        .foregroundColor(.white)
                        .frame(width: 156, height: 56)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .background(Color("green600"))
                        .cornerRadius(12)
                }
                
                Spacer()
                
                VStack(alignment: .leading){
                    HStack {
                        Text("Try this out")
                            .foregroundColor(Color("black800"))
                        
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                        Spacer()
                    }
                    ItemTripFavorite(location: location)
                    
                }
                
            }
        }
    }
    
    struct ItemTripFavorite : View {

        @EnvironmentObject var favoriteItem : FavoritesViewModel
        
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
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("black800"))
                    Spacer()
                    
               
                            Image(systemName: favoriteItem.isFavorite(location) ? "heart.fill" : "heart")
                                .foregroundColor(favoriteItem.isFavorite(location) ? Color("red600") : Color("grey100"))
                                .onTapGesture {
                                    if favoriteItem.isFavorite(location) {
                                        favoriteItem.removeFromFavorites(location)
                                    } else {
                                        favoriteItem.addToFavorites(location)
                                    }
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
