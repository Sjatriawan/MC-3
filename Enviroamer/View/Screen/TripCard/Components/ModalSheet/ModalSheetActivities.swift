//
//  ModalSheetActivities.swift
//  Enviroamer
//
//  Created by tiyas aria on 21/07/23.
//

import SwiftUI

struct ModalSheetActivities: View {
   
    var destinasi : Tourism
    
    var body: some View {
        let acticity = destinasi.kegiatan
        let titleActivity = destinasi.judulKegiatan
        ScrollView {
            VStack(alignment: .leading, spacing: 32){
                Text("Activities in \(destinasi.nama)")
                    .foregroundColor(Color("black800"))
                    .font(.system(size: 20, weight: .bold, design: .rounded))

                ForEach(Array(zip(titleActivity, acticity)), id: \.0){ itemTitle, itemActivity in
                    VStack (alignment: .leading, spacing: 8){
                        HStack{
                            Image("activity")
                            Text(itemTitle)
                                .foregroundColor(Color("black800"))
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                       
                            
                            Text(itemActivity)
                            .foregroundColor(Color("black800"))
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                                .padding(.leading,40)
                        
                    }
                }
            }
            
            .padding(.top, 70)
            .padding(.bottom, 20)
            .padding(.horizontal,24)
        }
    }
}

struct ModalSheetActivities_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheetActivities(destinasi : TourismViewModel().tourisms[0].listWisata[0])
            
    }
}
