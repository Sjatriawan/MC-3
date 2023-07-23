//
//  TransportationContentTrip.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct TransportationContentTrip: View {
    @EnvironmentObject var modelWisata : TourismViewModel

    var body: some View {
        var data = modelWisata.tourisms[0].tranportasiProvinsi
        VStack(alignment: .leading, spacing: 32){
            VStack(alignment: .leading, spacing: 6){
                Text("Get around the city")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Bold", size: 20))
                
                
                Text("People say \"All roads lead to Rome.\" There are also many different ways to reach the same destination. Rethink how you will go there")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Regular", size: 16))
            }
            

            
            ForEach(data, id: \.self){ item in
                HStack(spacing: 14){
                    Image(getIconName(for: item))
                        .frame(width: 28)
                    Text(item)
                        .foregroundColor(Color("black800"))
                        .font(.custom("SFProRounded-Regular", size: 17))
                }
            }
           
        }
    }
    
    private func getIconName(for transportationType : String) -> String {
        switch transportationType{
        case "Bicycle" :
            return "bicycle icon"
        case "Car" :
            return "car icon"
        case "Bus" :
            return "bus icon"
        case "Motorcycle":
            return "Scooter icon"
        case "Walk":
            return "walk icon"
        case "Train" :
            return  "train icon"
        default:
            return ""
        }
    }
    
   
}



struct TransportationContentTrip_Previews: PreviewProvider {
    static var previews: some View {
        TransportationContentTrip()
            .environmentObject(TourismViewModel())
    }
}


