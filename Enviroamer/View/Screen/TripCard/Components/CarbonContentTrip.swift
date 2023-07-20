//
//  CarbonContentTrip.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct CarbonContentTrip: View {
    var body: some View {
        ZStack{
            Color(.white)
            
            VStack(alignment: .leading){
               Text("Predicted carbon emission")
                    .bold()
                    .font(.system(size: 20))
                    .padding(.bottom, 8)
                
                Text("Your total predicted carbon emission produced from your travelling.")
                     .font(.system(size: 14))
                     .padding(.bottom)
                
                Divider()
                    .background(.black)
                    .padding(.bottom)
                
                DetailCarbon(title: "1.595", valueProgres: 1.595, titleProgressBar: "Hotel" , color: Color(hex: "EE983A") , shadowColor: Color(hex: "AB6212"))
                
                DetailCarbon(title: "1.200", valueProgres: 1.200, titleProgressBar: "Airplane" , color: Color(hex: "7E4E75"), shadowColor: Color(hex: "1A0115"))
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 24)
            
        }
        .border(Color(hex: "A5B5A0"), width: 1.5)
        .cornerRadius(12)
        .padding()

    }
}

struct CarbonContentTrip_Previews: PreviewProvider {
    static var previews: some View {
        CarbonContentTrip()
    }
}

struct DetailCarbon : View {
    let title : String
    let valueProgres : Double
    let titleProgressBar : String
    let color : Color
    let shadowColor : Color
    
    var body : some View {
        VStack (alignment: .leading){
            Text("\(title) kgCO2")
                .bold()
                .font(.system(size: 16))
                .padding(.bottom, 6)
            
            Rectangle()
                .frame(width: valueProgres * 100, height: 32)
                .foregroundColor(color)
                .cornerRadius(10)
                .overlay{
                    VStack (alignment: .leading){
                        Text(titleProgressBar)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))

                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .shadow(color: shadowColor,
                                radius: 0, x: 0, y: 2)
                      
                )
            
        }
        .padding(.bottom)
    }
}
