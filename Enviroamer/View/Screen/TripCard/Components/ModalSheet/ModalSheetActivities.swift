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
                Text("Activities in \(destinasi.nama!)")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Bold", size: 20))
                
                ForEach(Array(zip(titleActivity, acticity)), id: \.0){ itemTitle, itemActivity in
                    VStack (alignment: .leading, spacing: 8){
                        HStack{
                            Image("activity")
                            Text(itemTitle)
                                .foregroundColor(Color("black800"))
                                .font(.custom("SFProRounded-Bold", size: 16))
                        }
                       
                            
                            Text(itemActivity)
                            .foregroundColor(Color("black800"))
                            .font(.custom("SFProRounded-Regular", size: 14))
                                .padding(.leading,40)
                        
                    }
                }
            }
            
            .padding(.vertical, 32)
            .padding(.horizontal,24)
        }
    }
}

struct ModalSheetActivities_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheetActivities(destinasi : TourismViewModel().tourisms[0].listWisata[0])
            
    }
}
