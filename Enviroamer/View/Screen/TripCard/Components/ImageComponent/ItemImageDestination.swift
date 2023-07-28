//
//  ItemImageDestination.swift
//  Enviroamer
//
//  Created by tiyas aria on 21/07/23.
//

import SwiftUI

struct ItemImageDestination: View {
    var destination : Tourism
    @State private var selectedIndex = 0
    @EnvironmentObject var favoriteItem : FavoriteDestinationViewModel
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: destination.image[0])) { Image in
                Image
                    .resizable()
            } placeholder: {
                ShimmerView()
                
            }
            .scaledToFill()
            .frame(width : 342,height : 400)
            .clipShape(CustomCorner(radius: 12, corners: [
                .topLeft,
                .topRight,
                .bottomLeft,
                .bottomRight
            ]))
            
            
           
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
                            Text(destination.nama)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            
                            Text(destination.deskripsiSingkat)
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .lineLimit(2)
                                .foregroundColor(.white)
                        }
                        
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
                        .padding(.bottom, 24)
                    }
                    .padding(.horizontal, 16)
                    
                }
            }
        }
    }
}


//struct ItemImageDestination_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemImageDestination(de)
//    }
//}
