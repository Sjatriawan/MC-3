//
//  ModalDescOffset.swift
//  Enviroamer
//
//  Created by tiyas aria on 22/07/23.
//

import SwiftUI

struct ModalDescOffset: View {
    var activityOffset : OffsetActivity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 32){
            Text("About \(activityOffset.namaAktivitas)")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color("black800"))
            
            Text(activityOffset.deskripsiKegiatan[0])
                .foregroundColor(Color("black800"))
                .font(.system(size: 16, weight: .regular, design: .rounded))

            Text(activityOffset.deskripsiKegiatan[1])
                .foregroundColor(Color("black800"))
                .font(.system(size: 16, weight: .regular, design: .rounded))

        }
        .padding(.top, 70)
        .padding(.bottom, 20)
        .padding(.horizontal, 24)
    }
}

struct ModalDescOffset_Previews: PreviewProvider {
    static var previews: some View {
        ModalDescOffset(activityOffset: TourismViewModel().tourisms[0].kegiatanOffset[0])
           
    }
}
