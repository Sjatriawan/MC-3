//
//  CardView.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 18/07/23.
//

import SwiftUI


struct CardView: View {
    var title: String
    var location: String
    var backgroundColor: Color

    var body: some View {
        ZStack{
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 350, height: 250)
                .cornerRadius(20)

            VStack(alignment: .leading){
                ZStack{
                    Color.black.opacity(0.3).frame(width: 350, height: 70)
                    VStack(alignment: .leading){
                        Text(title).foregroundColor(.white)
                        Text(location).foregroundColor(.white)
                    }
                    .frame(width: 330, alignment: .leading)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)

        }.frame(width: 350, height: 250)
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Nusa Penida", location: "Bali, Indonesia", backgroundColor: .brown)
    }
}
