<<<<<<< HEAD
//
//  ItemContentHorizontal.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

// file ini adalah component costum untuk content di explore screen yang horizontal scroll
=======
import SwiftUI
////
////  ItemContentHorizontal.swift
////  Enviroamer
////
////  Created by tiyas aria on 20/07/23.
////
//
//import SwiftUI
//
//// file ini adalah component costum untuk content di explore screen yang horizontal scroll
//
>>>>>>> origin/trip-card-screen

struct ItemContentHorizontal: View {
    var activity : OffsetActivity
    var body : some View {
        AsyncImage(url: URL(string: activity.fotoKegiatan!)) { Image in
            Image
                .resizable()
<<<<<<< HEAD
                .frame(width: 342, height: 237)
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            
        }
=======
               
        } placeholder: {
            Image("placeholder")
                .resizable()
               
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 342, height: 237)
>>>>>>> origin/trip-card-screen
        .cornerRadius(12)
        .overlay{
            VStack{
                Spacer()
                ZStack {
<<<<<<< HEAD
                  
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 335, height: 62)
                      .background(
                        EllipticalGradient(
                          stops: [
                            Gradient.Stop(color: Color(red: 0.02, green: 0.03, blue: 0.03).opacity(0.4), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.75, green: 0.78, blue: 0.78).opacity(0), location: 1.00),
                          ],
                          center: UnitPoint(x: 0.03, y: 0.83)
                        )
                      )
                      .cornerRadius(10)
                      .blur(radius: 4)
=======
                   Image("gradient")
                        .offset(x: -3, y:7)
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                       
>>>>>>> origin/trip-card-screen
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text(activity.namaAktivitas!)
<<<<<<< HEAD
                                .font(.system(size: 20))
                                .padding(.horizontal)
                                .fontWeight(.semibold)
=======
                                .font(.custom("SFProRounded-Semibold", size: 20))
                                .padding(.horizontal)
>>>>>>> origin/trip-card-screen
                                .foregroundColor(.white)
                            
                            HStack{
                                Image("pin_location")
                                    .frame(width: 10 , height: 15)
                                Text(activity.company!)
<<<<<<< HEAD
                                    .font(.system(size: 15))
=======
                                    .font(.custom("SFProRounded-Regular", size: 15))
>>>>>>> origin/trip-card-screen
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            
                        }
                        Spacer()
                    }
<<<<<<< HEAD
                    .padding(.vertical)
=======
>>>>>>> origin/trip-card-screen
                    
                    
                }

            }
        }
    }
}
<<<<<<< HEAD

//struct ItemContentHorizontal_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemContentHorizontal()
//    }
//}
=======
////struct ItemContentHorizontal_Previews: PreviewProvider {
////    static var previews: some View {
////        ItemContentHorizontal()
////    }
////}
>>>>>>> origin/trip-card-screen
