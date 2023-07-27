//
//  ModalSheetCarbon.swift
//  Enviroamer
//
//  Created by tiyas aria on 27/07/23.
//

import SwiftUI

struct ModalSheetCarbon: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("0 tonsCO₂e ")
                .font(.system(size: 20, weight: .bold, design: .rounded))
            Text("Is an estimated carbon calculation generated from your trip.You can consider your trip with the carbon estimates we have calculated")
                .font(.system(size: 16, weight: .regular, design: .rounded))

            
        }
        .padding(.all,24)
    }
}

struct ModalSheetCarbon_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheetCarbon()
    }
}
