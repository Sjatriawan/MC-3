//
//  ModalSheetDescription.swift
//  Enviroamer
//
//  Created by tiyas aria on 21/07/23.
//

import SwiftUI

struct ModalSheetDescription: View {
    var destinasi : Tourism

    var body: some View {
        let description = destinasi.deskripsi
        VStack(alignment: .leading,spacing: 32){
            Text("About \(destinasi.nama)")
                .font(.system(size: 20, weight: .bold, design: .rounded))                 .foregroundColor(Color("black800"))
            
            Text(description[0])
                .foregroundColor(Color("black800"))
                .font(.system(size: 16, weight: .regular, design: .rounded))
            
            Text(description[1])
                .foregroundColor(Color("black800"))
                .font(.system(size: 16, weight: .regular, design: .rounded))
        }
        .padding(.top, 70)
        .padding(.bottom, 20)
        .padding(.horizontal, 24)
    }
}

struct ModalSheetDescription_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheetDescription(destinasi:TourismViewModel().tourisms[0].listWisata[0] )
           
    }
}
