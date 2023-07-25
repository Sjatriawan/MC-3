//
//  ItemImageDestination.swift
//  Enviroamer
//
//  Created by tiyas aria on 21/07/23.
//

import SwiftUI

struct ItemImageDestination: View {
    var destination : Tourism
    @State private var isFavorite : Bool = false
    @State private var selectedIndex = 0
    
    var body: some View {
        ZStack {
            TabView (selection: $selectedIndex){
                ForEach(destination.image, id: \.self) { imageName in
                    AsyncImage(url: URL(string: imageName)) { Image in
                        Image
                            .resizable()
                    } placeholder: {
                        ShimmerView()
                        
                    }
                }
            }
            .frame(width : 342,height : 400)
            .aspectRatio(contentMode: .fit)
            .clipShape(CustomCorner(radius: 12, corners: [
                .topLeft,
                .topRight,
                .bottomLeft,
                .bottomRight
            ]))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
           
            VStack {
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.clear)
                        .frame(width: 342, height: 103.07692)
                        .background(Color(red: 0.04, green: 0.17, blue: 0.2).opacity(0.6))
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                    
                    VStack {
                        HStack(spacing: 5){
                            ForEach(destination.image.indices, id: \.self) { content in
                                Capsule()
                                    .foregroundColor( content == selectedIndex ? Color("green600") : .white)
                                    .frame(width: 19 , height: 3)
                                
                            }
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 6){
                                Text(destination.nama)
                                    .font(.custom("SFProRounded-Bold", size: 20))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                Text(destination.deskripsiSingkat)
                                    .font(.custom("SFProRounded-Regular", size: 14))
                                    .lineLimit(2)
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
}


//struct ItemImageDestination_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemImageDestination(de)
//    }
//}
