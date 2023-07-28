//
//  PastTripScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 23/07/23.
//

import SwiftUI

struct PastTripScreen: View {
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            VStack(spacing: 20){
                Text("No trips recorded yet.")
                    .font(.system(size: 20 , weight: .bold, design: .rounded))
                Text("It will be automatically added here as you embark on new adventures!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14 , weight: .regular, design: .rounded))
            }
            Spacer()
        }.padding(.horizontal,24)
    }
}

struct PastTripScreen_Previews: PreviewProvider {
    static var previews: some View {
        PastTripScreen()
    }
}
