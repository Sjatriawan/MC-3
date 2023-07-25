//
//  ItemImageCard.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ItemImageCard: View {
    var location : Location
    @State private var isFavorite = false
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
                            Text("13 Nov - 15 Nov")
                                .font(.custom("SFProRounded-Regular", size: 16))
                                .foregroundColor(.white)
                        }

                        
                        Spacer()
                        
                        Button {
                            isFavorite.toggle()
                        } label: {
                            !isFavorite ? Image(systemName: "heart")
                                              .foregroundColor(Color("grey100"))
                                             
                            : Image(systemName: "heart.fill")
                                .foregroundColor(Color("red600"))
                              
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


