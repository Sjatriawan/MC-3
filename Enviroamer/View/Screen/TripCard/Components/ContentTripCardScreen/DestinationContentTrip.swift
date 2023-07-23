//
//  DestinationContentTrip.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct DestinationContentTrip: View {
    @EnvironmentObject var modelWisata : TourismViewModel
    
    
    
    var body: some View {
        var data = self.modelWisata.tourisms[0].listWisata
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 32){
                VStack(alignment: .leading, spacing: 6){
                    Text("Unforgettable adventure")
                        .foregroundColor(Color("black800"))
                        .font(.custom("SFProRounded-Bold", size: 20))
                    
                    
                    Text("Welcome to the wonderland for eco-conscious tourist. Discover many more interesting places that really suit you!")
                        .foregroundColor(Color("black800"))
                        .font(.custom("SFProRounded-Regular", size: 16))
                }
                
                
                ForEach(data.indices){ index in
                    NavigationLink(destination: {
                        DestinationScreen(destinasi: data[index])
                    }, label: {
                        ItemDestinationActivity(
                            urlString: data[index].image![0],
                            title: data[index].nama!
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
        DestinationContentTrip()
            .environmentObject(TourismViewModel())
    }
}
