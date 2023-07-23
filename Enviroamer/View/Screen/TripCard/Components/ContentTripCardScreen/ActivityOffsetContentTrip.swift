//
//  ActivityOffsetContentTrip.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI

struct ActivityOffsetContentTrip: View {
    @EnvironmentObject var modelWisata : TourismViewModel

    var body: some View {
        let data = self.modelWisata.tourisms[0].kegiatanOffset

        NavigationStack {
            VStack(alignment: .leading, spacing: 32){
                VStack(alignment: .leading, spacing: 6){
                    Text("Neutralize carbon footprint")
                        .foregroundColor(Color("black800"))
                        .font(.custom("SFProRounded-Bold", size: 20))
                    
                    
                    Text("There will always be many ways to minimize or eliminate environmental impact from travelling by offsetting your carbon footprint")
                        .foregroundColor(Color("black800"))
                        .font(.custom("SFProRounded-Regular", size: 16))
                }
                
                ForEach(data.indices){ index in
                    NavigationLink(destination: {
                        ActivityOffsetScreen(activityOffset: data[index])
                    }, label: {
                        ItemDestinationActivity(
                            urlString: data[index].fotoKegiatan!,
                            title: data[index].namaAktivitas!
                        )
                    })
                    .accentColor(.black)
                        
                    }
               
            }
        }
    }
}

struct ActivityOffsetContentTrip_Previews: PreviewProvider {
    static var previews: some View {
        ActivityOffsetContentTrip()
            .environmentObject(TourismViewModel())
    }
}
