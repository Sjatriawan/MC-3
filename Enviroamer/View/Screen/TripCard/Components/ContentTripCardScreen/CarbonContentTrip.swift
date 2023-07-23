//
//  CarbonContentTrip.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct CarbonContentTrip: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            VStack(alignment: .leading){
                Text("Get ready for the odyssey!")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Bold", size: 20))
                    .padding(.bottom,6)
                
                
                Text("Before start your trip, understand your carbon footprint first")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Regular", size: 16))
            }
          
            
            VStack(alignment: .leading){
                Text("Predicted carbon emission")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Bold", size: 20))
                    .padding(.bottom, 8)
                
                Text("Your total predicted carbon emission produced from your travelling.")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Regular", size: 16))
                    .padding(.bottom)
                
                Divider()
                    .background(.black)
                    .padding(.bottom)
                
                DetailCarbon(title: "1.595", valueProgres: 1.595, titleProgressBar: "Hotel" , color: Color(hex: "EE983A") , shadowColor: Color(hex: "AB6212"))
                
                DetailCarbon(title: "1.200", valueProgres: 1.200, titleProgressBar: "Airplane" , color: Color(hex: "7E4E75"), shadowColor: Color(hex: "1A0115"))
                
                HStack{
                    HStack{
                        Image("plane")
                        Text("get to the city")
                            .foregroundColor(Color("black800"))
                            .font(.custom("SFProRounded-Regular", size: 14))
                    }
                    Spacer()
                    HStack{
                        Image("akomodai")
                        Text("accommodation")
                            .foregroundColor(Color("black800"))
                            .font(.custom("SFProRounded-Regular", size: 14))

                    }
                }
            }
            .padding(24)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Apply a border as an overlay to the VStack
                    .stroke(Color(hex: "#A5B5A0"), lineWidth: 2) // Set the border color and width
            )
            
           
            
        }
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
                .foregroundColor(Color("black800"))
                .font(.custom("SFProRounded-Bold", size: 16))
                .padding(.bottom, 6)
            
            Rectangle()
                .frame(width: valueProgres * 100, height: 32)
                .foregroundColor(color)
                .cornerRadius(10)
                .overlay{
                    VStack (alignment: .leading){
                        Text(titleProgressBar)
                            .foregroundColor(.white)
                            .foregroundColor(Color("black800"))
                            .font(.custom("SFProRounded-Semibold", size: 16))
                        
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
