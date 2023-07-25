//
//  ItemDestinationActivity.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ItemDestinationActivity: View {
    var urlString : String
    var title : String
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { Image in
            Image
                .resizable()
         
                
        } placeholder: {
            Image("placeholder")
                .resizable()
 
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 342, height: 205)
        .cornerRadius(12)
        .overlay{
            VStack {
                Spacer()
                ZStack{
                    Rectangle()
                        .frame(width: 342, height: 67)
                        .foregroundColor(Color("neutral200"))
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                    
                    HStack {
                        Text(title)
                            .foregroundColor(Color("black800"))
                            .font(.custom("SFProRounded-Semibold", size: 17))
                            .padding(.leading,20)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        Spacer()
                    }
        
                    
                }
            }
        }
    }
}

struct ItemDestinationActivity_Previews: PreviewProvider {
    static var previews: some View {
        ItemDestinationActivity(urlString: "", title: "")
    }
}
