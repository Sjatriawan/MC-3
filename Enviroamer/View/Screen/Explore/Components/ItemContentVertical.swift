//
//  ItemContentVertical.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

// file ini adalah component costum untuk content di explore screen yang vertical scroll 

struct ItemContentVertical: View {
    var tourism : Tourism
    var body : some View {
        AsyncImage(url: URL(string: tourism.image[0])) { Image in
            switch Image{
            case .empty:
                ShimmerView()

            case .success(let image) :
                image
                    .resizable()
                    .scaledToFill()
                    
            case .failure:
                Color.gray
            @unknown default :
                Color.gray
            }
        }
        .frame(width: 156, height: 237)
        .cornerRadius(12)
        .overlay{
            VStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .frame(width: 156,height: 75)
                        .foregroundColor(.black)
                        .opacity(0.4)
                        .blur(radius: 8)
                    
                    VStack(alignment: .leading){
                        Text(tourism.nama)
                            .lineLimit(2)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                        
                        HStack{
                            Image("pin_location")
                                .frame(width: 10 , height: 15)
                            Text(tourism.lokasi)
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .lineLimit(1)
                                .foregroundColor(.white)
                        }

                    }
                    .padding()
                }
                
            }
        }
    }
}

//struct ItemContentVertical_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemContentVertical()
//    }
//}
