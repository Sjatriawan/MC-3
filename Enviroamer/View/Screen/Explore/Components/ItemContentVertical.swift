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
                ShimmerViewVertical()
                    .frame(width: 156, height: 237)

            case .success(let image) :
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 156, height: 237)
                    
            case .failure:
                Color.gray
            @unknown default :
                Color.gray
            }
        }
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
                            .font(.custom("SFProRounded-Semibold", size: 20))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                        
                        HStack{
                            Image("pin_location")
                                .frame(width: 10 , height: 15)
                            Text(tourism.lokasi)
                                .font(.custom("SFProRounded-Regular", size: 13))
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
