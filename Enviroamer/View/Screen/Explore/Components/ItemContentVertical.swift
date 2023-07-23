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
<<<<<<< HEAD
            
=======
            Image("placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 208, height: 242)
>>>>>>> origin/trip-card-screen
        }
        .overlay{
            VStack {
                Spacer()
                ZStack{
<<<<<<< HEAD
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 155.41791, height: 55.19178)
                        .background(
                            EllipticalGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.02, green: 0.03, blue: 0.03).opacity(0.2), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.75, green: 0.78, blue: 0.78).opacity(0), location: 1.00),
                                ],
                                center: UnitPoint(x: 0.32, y: 0.74)
                            )
                        )
                        .cornerRadius(10)
                        .blur(radius: 4)
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text(tourism.nama!)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .lineLimit(2)
                                .foregroundColor(.white)
                            
                            HStack{
                                Image("pin_location")
                                    .frame(width: 10 , height: 15)
                                Text(tourism.lokasi!)
                                    .font(.system(size: 13))
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            
                        }
                        .padding()
                        
                        Spacer()
                    }
=======
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
>>>>>>> origin/trip-card-screen
                    
                    
                    
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
