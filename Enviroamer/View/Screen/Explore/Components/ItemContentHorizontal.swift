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


struct ItemContentHorizontal: View {
    var activity : OffsetActivity
    var body : some View {
        AsyncImage(url: URL(string: activity.fotoKegiatan)) { Image in
            Image
                .resizable()
            
               
        } placeholder: {
            ShimmerViewVertical()
            
        }
        .frame(width: 342, height: 237)
        .scaledToFit()
        .cornerRadius(12)
        .overlay{
            VStack{
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(width: 342,height: 75)
                        .foregroundColor(.black)
                        .opacity(0.4)
                        .blur(radius: 8)
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text(activity.namaAktivitas)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .padding(.horizontal)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .foregroundColor(.white)
                            
                            HStack{
                                Image("pin_location")
                                    .frame(width: 10 , height: 15)
                                Text(activity.company)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                            
                        }
                        Spacer()
                    }
                    
                    
                }

            }
        }
    }
}
////struct ItemContentHorizontal_Previews: PreviewProvider {
////    static var previews: some View {
////        ItemContentHorizontal()
////    }
////}
