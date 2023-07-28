//
//  ItemImageCard.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ItemImageCard: View {

    
    let trip : Trip 
    
    @EnvironmentObject var favoriteItem : FavoritesViewModel
    var location : Location

    var body : some View {
        AsyncImage(url: URL(string: location.imageKota)) { Image in
            Image
                .resizable()
               
        } placeholder: {
            ShimmerView()
                .frame(width : 342 , height : 400)

           
        }
        .aspectRatio( contentMode: .fill)
        .frame(width : 342 , height : 400)
        .cornerRadius(12)
        .overlay{
            
            VStack {
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.clear)
                        .frame(width: 342, height: 103.07692)
                        .background(Color(red: 0.04, green: 0.17, blue: 0.2).opacity(0.6))
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6){
                            Text(location.namaProvinsi)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Text("\(formattedDate(date: trip.startDate)) - \(formattedDate(date: trip.endDate))")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                                .foregroundColor(.white)
                        }

                        
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
                        
                    }
                    .padding(.horizontal, 16)

                    
                }
            }
        }
        
    }
    
    private func formattedDate(date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
        return ""
    }
}

struct ItemImageCardNoTrip : View {
    @EnvironmentObject var favoriteItem : FavoritesViewModel
    var location : Location

    var body : some View {
        AsyncImage(url: URL(string: location.imageKota)) { Image in
            Image
                .resizable()
               
        } placeholder: {
            ShimmerView()
                .frame(width : 342 , height : 400)

           
        }
        .aspectRatio( contentMode: .fill)
        .frame(width : 342 , height : 400)
        .cornerRadius(12)
        .overlay{
            
            VStack {
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.clear)
                        .frame(width: 342, height: 103.07692)
                        .background(Color(red: 0.04, green: 0.17, blue: 0.2).opacity(0.6))
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                    
                    HStack {
                        Text(location.namaProvinsi)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        
                        Spacer()
                        
                        Image(systemName: favoriteItem.isFavorite(location) ? "heart.fill" : "heart")
                            .foregroundColor(favoriteItem.isFavorite(location) ? Color("red600") : Color("grey100"))
                            .onTapGesture {
                                if favoriteItem.isFavorite(location) {
                                    favoriteItem.removeFromFavorites(location)
                                } else {
                                    favoriteItem.addToFavorites(location)
                                }                            }
                        
                    }
                    .padding(.horizontal, 16)

                    
                }
            }
        }
        
    }
}


