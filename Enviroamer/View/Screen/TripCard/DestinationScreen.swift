//
//  DestinationScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 21/07/23.
//

import SwiftUI

struct DestinationScreen: View {
    
    @State private var isShowingModalDesc = false
    @State private var isShowingModalActivities = false
    var destinasi : Tourism
    
    var body: some View {
        let data = destinasi.transportasiWisata
        let time = destinasi.timeToDestination
        let kotaPusat = destinasi.kotaPusat
        
        ScrollView {
            VStack(alignment: .leading, spacing: 32){
                //                 image
                ItemImageDestination(destination: destinasi)
                //                deskripsi
                VStack(alignment: .leading, spacing: 8){
                    Text("About \(destinasi.nama!)")
                        .font(.custom("SFProRounded-Bold", size: 20))
                        .foregroundColor(Color("black800"))
                    
                    
                    
                    Text(destinasi.deskripsi[0])
                        .lineLimit(4)
                        .font(.custom("SFProRounded-Regular", size: 16))
                        .foregroundColor(Color("black800"))
                    
                    Button {
                        isShowingModalDesc.toggle()
                    } label: {
                        Text("Read More")
                            .font(.custom("SFProRounded-Bold", size: 16))
                            .foregroundColor(Color("green600"))
                            .underline()
                    }
                    
                    
                }
                //                lokasi nd time
                VStack(alignment: .leading, spacing: 8){
                    HStack(spacing: 16){
                        VStack {
                            Image("location")
                            Spacer()
                        }
                        Text(destinasi.lokasi!)
                            .font(.custom("SFProRounded-Regular", size: 16))
                            .foregroundColor(Color("black800"))
                        
                        
                    }
                    
                    HStack(spacing: 16){
                        VStack {
                            Image("time")
                        }
                        Text(destinasi.waktuOperasional!)
                            .font(.custom("SFProRounded-Regular", size: 16))
                            .foregroundColor(Color("black800"))
                        
                        
                    }
                }
                
                //                 activity
                VStack(alignment: .leading){
                    HStack{
                        Text("Activities")
                            .foregroundColor(Color("black800"))
                            .font(.custom("SFProRounded-Bold", size: 20))
                        
                        Spacer()
                        
                        Button {
                            isShowingModalActivities.toggle()
                        } label: {
                            Text("View All")
                                .font(.custom("SFProRounded-Bold", size: 16))
                                .foregroundColor(Color("green600"))
                                .underline()
                        }
                    }
                    Divider()
                        .background(.black)
                        .frame(height: 2)
                    HStack{
                        Image("activity")
                        Text(destinasi.judulKegiatan[0])
                            .font(.custom("SFProRounded-Regular", size: 16))
                            .foregroundColor(Color("black800"))
                    }
                    .padding(.bottom,24)
                    
                    HStack{
                        Image("activity")
                        Text(destinasi.judulKegiatan[1])
                            .font(.custom("SFProRounded-Regular", size: 16))
                            .foregroundColor(Color("black800"))
                    }
                    
                    
                    
                }
                .padding(.horizontal,12)
                .padding(.vertical,24)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "#D1D1D1"), lineWidth: 2)
                )
                
                //                trasnportasi
                VStack(alignment: .leading){
                    Text("How to get there?")
                        .foregroundColor(Color("black800"))
                        .font(.custom("SFProRounded-Bold", size: 20))
                        .padding(.bottom,8)
                    
                    VStack{
                        ForEach(Array(zip(data, time)), id: \.0){ transport, times in
                            HStack(spacing: 14){
                                VStack(alignment: .leading) {
                                    Text(transport)
                                        .foregroundColor(Color("black800"))
                                        .font(.custom("SFProRounded-Bold", size: 17))
                                        .padding(.bottom , 2)
                                    
                                    Text("\(times) from \(kotaPusat)")
                                        .foregroundColor(Color("black800"))
                                        .font(.custom("SFProRounded-Regular", size: 14))
                                }
                                Spacer()
                                Image(getIconName(for: transport))
                                    .frame(width: 28)
                                
                            }
                            .padding(.horizontal,24)
                            .padding(.vertical,16)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "#D1D1D1"), lineWidth: 2)
                            )
                        }
                        .padding(.bottom, 12)
                        
                    }
                }
                
                
            }
            .sheet(isPresented: $isShowingModalDesc, content: {
                ModalSheetDescription(destinasi: destinasi)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(10)
            })
            .sheet(isPresented: $isShowingModalActivities, content: {
                ModalSheetActivities(destinasi: destinasi)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(10)
            })
            .padding(.horizontal,24)
            .navigationTitle(Text(destinasi.nama!))
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func getIconName(for transportationType : String) -> String {
        switch transportationType{
        case "Car" :
            return "car icon"
        case "Motorcycle":
            return "Scooter icon"
        case "Walk":
            return "walk icon"
        default:
            return ""
        }
    }
}

struct DestinationScreen_Previews: PreviewProvider {
    static var previews: some View {
        DestinationScreen(destinasi: TourismViewModel().tourisms[0].listWisata[0])
    }
}

