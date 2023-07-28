//
//  DestinationWishListScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 23/07/23.
//

import SwiftUI

struct DestinationWishListScreen: View {
    @EnvironmentObject var favoriteItem : FavoriteDestinationViewModel

    var body: some View {
        NavigationStack {
            VStack{
                if favoriteItem.favorites.isEmpty{
                    EmptyDestinationWishLishScreen(destination: TourismViewModel().tourisms[0].listWisata[0])
                } else {
                    LazyVStack{
                        ForEach(favoriteItem.favorites, id: \.self ) { item in
                            ItemDestinationTripFavorite(destination: item)
                        }
                    }
                    .listStyle(.plain)
                }
                
            }
        }
    }
}

struct DestinationWishListScreen_Previews: PreviewProvider {
    static var previews: some View {
        DestinationWishListScreen()
            .environmentObject(FavoriteDestinationViewModel())
    }
}

struct EmptyDestinationWishLishScreen : View{
    var destination : Tourism
    
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
                ExploreScreen()
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
                
                ItemDestinationTripFavorite(destination: destination)
               
                
            }
            
        }
    }
}

struct ItemDestinationTripFavorite : View {
    @EnvironmentObject var favoriteItem : FavoriteDestinationViewModel

    var destination : Tourism
    var body : some View {
        NavigationLink(destination: {
            DestinationScreen(destinasi: destination)
        }, label: {
            ZStack{
                Color("neutral200")
                HStack{
                    AsyncImage(url: URL(string: destination.image[0])) { Image in
                        Image
                            .resizable()
                            .frame(width: 139)
                    } placeholder: {
                        ShimmerView()
                            .frame(width: 139)
                    }
                    .padding(.trailing, 18)
                    
                    Text(destination.nama)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("black800"))
                        .lineLimit(2)
                    Spacer()
                    
                    Image(systemName: favoriteItem.isFavorite(destination) ? "heart.fill" : "heart")
                        .foregroundColor(favoriteItem.isFavorite(destination) ? Color("red600") : Color("grey100"))
                        .onTapGesture {
                            if favoriteItem.isFavorite(destination) {
                                favoriteItem.removeFromFavorites(destination)
                            } else {
                                favoriteItem.addToFavorites(destination)
                            }
                        }
                        .font(.system(size: 24))
                        .padding(.trailing,16)
                        .padding(.bottom,40)
                        
                    
                    
                    
                }
            }
            .cornerRadius(12)
        .frame(height: 105)
        })
    }
}
