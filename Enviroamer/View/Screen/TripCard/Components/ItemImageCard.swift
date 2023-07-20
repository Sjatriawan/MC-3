//
//  ItemImageCard.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ItemImageCard: View {
    var location : Location
    var body : some View {
        ZStack {
            
            
            AsyncImage(url: URL(string: location.imageKota)) { Image in
                Image
                    .resizable()
                    .frame(height : 400)
                    .aspectRatio( contentMode: .fit)
            } placeholder: {
                
            }
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
                                Text(location.namaProvinsi!)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("13 Nov - 15 Nov")
                                    .font(.system(size: 16))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            
                            Spacer()
                        }
                        
                    }
                }
            }
            
            HStack {
                Spacer()
                Image(systemName: "heart")
                    .foregroundColor(.red)
                    .font(.system(size: 24))
                    .padding(.trailing, 20)
            }
            .padding(.bottom, 320)
        }
        
    }
}

//struct ItemImageCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemImageCard()
//    }
//}
