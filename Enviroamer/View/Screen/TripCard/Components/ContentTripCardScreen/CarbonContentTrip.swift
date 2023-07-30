//
//  CarbonContentTrip.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI
import Charts

struct CarbonContentTrip: View {
    let trip : Trip
    let location : Location
//    @EnvironmentObject viewModel : TravelPlannerViewModel

    var body: some View {
//        let totalAkomodasi = trip.totalCarbonAkomodasi * 100
//        let totalTransportasi  = trip.totalCarbonTransport * 100
        

        VStack(alignment: .leading, spacing: 32){
            VStack(alignment: .leading){
                Text("Get ready for the odyssey!")
                    .foregroundColor(Color("black800"))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.bottom,6)
                
                
                Text("Before start your trip, understand your carbon footprint first")
                    .foregroundColor(Color("black800"))
                    .font(.system(size: 16, weight: .regular, design: .rounded))
            }
          
            
            VStack(alignment: .leading){
                Text("Predicted carbon emission")
                    .foregroundColor(Color("black800"))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.bottom, 8)
                
                Text("Your total predicted carbon emission produced from your travelling.")
                    .foregroundColor(Color("black800"))
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.bottom)
                
                Divider()
                    .background(.black)
                    .padding(.bottom)
                
//                DetailCarbon(carbon: trip.totalCarbonTransport, valueProgres: 300, titleProgressBar:  "Transportasi", color: Color(hex: "EE983A"), shadowColor: Color(hex: "AB6212"))
//
//                DetailCarbon(carbon: trip.totalCarbonAkomodasi, valueProgres: 300, titleProgressBar: "Akomodasi" , color: Color(hex: "7E4E75") , shadowColor:Color(hex: "1A0115") )
//
//
                Chart{
                    BarMark(
                        x: .value("Total Carbon", trip.totalCarbonTransport),
                        y: .value("Transportation Method", trip.transportationMethod ?? "")
                    )
                    .foregroundStyle(.purple)
                    .annotation (position: .overlay) {
                        Text("\(trip.totalCarbonTransport / 1_000_000, specifier: "%.2f") tonsCO₂e")
                            .foregroundColor(.white)
                            .font(.system(size: 14 , weight: .semibold, design: .rounded))
                            

                    }
                    
                    BarMark(
                        x: .value("Total Carbon", trip.totalCarbonAkomodasi),
                        y: .value("Accomodation", trip.hotelStarRating ?? "")
                    )
                    .foregroundStyle(Color("green400"))
                    .annotation (position: .overlay) {
                        Text("\(trip.totalCarbonAkomodasi / 1_000_000, specifier: "%.2f") tonsCO₂e")
                            .foregroundColor(.white)
                            .font(.system(size: 14 , weight: .semibold, design: .rounded))
                    }
                    
                }
                .chartLegend(.hidden)
                .chartXAxis(.hidden)
                .chartYAxis{
                    AxisMarks { _ in
                        AxisValueLabel()

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

//struct CarbonContentTrip_Previews: PreviewProvider {
//    static var previews: some View {
//        CarbonContentTrip()
//    }
//}

struct DetailCarbon : View {
    let carbon : Double
    let valueProgres : Double
    let titleProgressBar : String
    let color : Color
    let shadowColor : Color
    
    var body : some View {
        VStack (alignment: .leading){
            Text("\(carbon / 1_000_000, specifier: "%.2f") tonsCO₂e")
                .foregroundColor(Color("black800"))
                .font(.system(size: 16, weight: .bold, design: .rounded)).padding(.bottom, 6)
            
            Rectangle()
                .frame(width: valueProgres, height: 32)
                .foregroundColor(color)
                .cornerRadius(10)
                .overlay{
                    VStack (alignment: .leading){
                        Text(titleProgressBar)
                            .foregroundColor(.white)
                            .foregroundColor(Color("black800"))
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
//                            .padding(.bottom, 3)
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

//    .frame(width: min(CGFloat(self.value)*geo.size.width, geo.size.width ), height: geo.size.height)
