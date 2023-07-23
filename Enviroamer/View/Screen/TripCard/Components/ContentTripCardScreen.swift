//
//  ContentTripCardScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ContentTripCardScreen<Content : View>: View {
    let title : String
    let desc : String
    let content :  Content
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 12){
                Text(title)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                
                Text(desc)
                    .font(.system(size: 16))
                    .padding(.bottom, 32)
                
                content
                
            }
        }
        
    }
}

struct ContentTripCardScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentTripCardScreen(title: "Get ready for the odyssey!", desc: "Your trip will happen in just few days. Keep in mind the environmental impact while explore the beauty around.", content: VStack{})
        
    }
}
