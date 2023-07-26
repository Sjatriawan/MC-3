//
//  DestinationContentTrip.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct DestinationContentTrip: View {
    @EnvironmentObject var modelWisata : TourismViewModel
    
    let idProvinsi : Int
    //    let tourism : Tourism
    
    var body: some View {
        let data = self.modelWisata.tourisms[idProvinsi - 1].listWisata
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 32){
                VStack(alignment: .leading, spacing: 6){
                    Text("Unforgettable adventure")
                        .foregroundColor(Color("black800"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Text("Welcome to the wonderland for eco-conscious tourist. Discover many more interesting places that really suit you!")
                        .foregroundColor(Color("black800"))
                        .font(.system(size: 16, weight: .regular, design: .rounded)) 
                }
                
                
                ForEach(data.indices){ index in
                    NavigationLink(destination: {
                        DestinationScreen(destinasi: data[index])
                    }, label: {
                        ItemDestinationActivity(
                            urlString: data[index].image[0],
                            title: data[index].nama
                        )
                    })
                    .accentColor(.black)
                    
                }
                
                
            }
        }
    }
}

struct DestinationContentTrip_Previews: PreviewProvider {
    static var previews: some View {
        DestinationContentTrip(idProvinsi: 1)
            .environmentObject(TourismViewModel())
    }
}
