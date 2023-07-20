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
            Color("grey100")
                
            VStack(alignment: .leading){
               Text("Predicted carbon emission")
                    .bold()
                    .font(.system(size: 20))
                    .padding(.bottom, 8)
                
                Text("Your total predicted carbon emission produced from the transportation is OK.")
                     .font(.system(size: 14))
                     .padding(.bottom)
                
                Divider()
                    .background(.black)
                    .padding(.bottom)
                
                DetailCarbon(title: "1.595", valueProgres: 1.595, titleProgressBar: "Hotel" )
                
                DetailCarbon(title: "1.200", valueProgres: 1.200, titleProgressBar: "Airplane" )
                
                DetailCarbon(title: "1.500", valueProgres: 1.500, titleProgressBar: "Car" )
            
                    
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 24)
            
        }
        .cornerRadius(15)
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
    
    var body : some View {
        VStack (alignment: .leading){
            Text("\(title) kgCO2")
                .bold()
                .font(.system(size: 16))
                .padding(.bottom, 6)
            
            Rectangle()
                .frame(width: valueProgres * 100, height: 30)
                .foregroundColor(.gray)
                .cornerRadius(10)
                .overlay{
                    VStack (alignment: .leading){
                        Text(titleProgressBar)
                    }
                }
            
        }
        .padding(.bottom)
    }
}
