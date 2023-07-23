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
        AsyncImage(url: URL(string: tourism.image![0])) { Image in
            Image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 208, height: 242)
        } placeholder: {
            Image("placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 208, height: 242)
        }
        .overlay{
            VStack {
                Spacer()
                ZStack{
                    Image("gradientVertical")
                    
                    VStack(alignment: .leading){
                        Text(tourism.nama!)
                            .font(.custom("SFProRounded-Semibold", size: 20))
                            .padding(.horizontal)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(.white)
                        
                        HStack{
                            Image("pin_location")
                                .frame(width: 10 , height: 15)
                            Text(tourism.lokasi!)
                                .font(.custom("SFProRounded-Regular", size: 13))
                                .lineLimit(1)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        
                    }
                    .padding()
                    
                    
                    
                }
            }
            
        }
        .frame(width: 156, height: 237)
        .cornerRadius(12)
    }
}

//struct ItemContentVertical_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemContentVertical()
//    }
//}
