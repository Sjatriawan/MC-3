//
//  ActivityOffsetScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 21/07/23.
//

import SwiftUI

struct ActivityOffsetScreen: View {
    var activityOffset : OffsetActivity
    @State  var isShowingModalDesc = false
    var contactOffset = ContactViewModel()
    
    var body: some View {
//        let dataOffset = modelWisata.tourisms[0].kegiatanOffset[1]
        ScrollView{
            VStack(alignment: .leading, spacing: 32){
                ItemImageOffset(offset: activityOffset)
                VStack(alignment: .leading){
                    Text("Support local community!")
                        .foregroundColor(Color("black800"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))                        .padding(.bottom,10)
                    
                    Text(activityOffset.deskripsiKegiatan[0])
                        .lineLimit(4)
                        .foregroundColor(Color("black800"))
                        .font(.system(size: 16, weight: .regular, design: .rounded))                        .padding(.bottom,2)

                    Button {
                        isShowingModalDesc.toggle()
                    } label: {
                        Text("Read More")
                            .font(.system(size: 14, weight: .bold, design: .rounded))                            .foregroundColor(Color("green600"))
                            .underline()
                    }
                    
                    
                }
                VStack(alignment: .leading, spacing: 12){
                    Text("Contact")
                        .foregroundColor(Color("black800"))
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                    HStack(spacing: 17){
                        ItemContact(image: "website") {
                            contactOffset.openSafari(url: activityOffset.website)
                        }
                        ItemContact(image: "email") {
                            contactOffset.openEmailApp(url: activityOffset.email)
                        }
                        ItemContact(image: "call") {
                            contactOffset.openPhoneApp(url: activityOffset.noTelp)
                        }
                        ItemContact(image: "instagram") {
                            contactOffset.openInstagram(url: activityOffset.instagram)
                        }
                    }
                }
                VStack(alignment: .leading){
                    Divider()
                        .frame(height: 1)
                        .background(Color("black800"))
                    HStack {
                        Spacer()
                        Text("Credit: \(activityOffset.resourceImage)")
                            .font(.system(size: 8, weight: .regular, design: .rounded))
                        Spacer()

                    }
                }
            }
            .sheet(isPresented: $isShowingModalDesc, content: {
                ModalDescOffset(activityOffset: activityOffset)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(10)
            })
            .padding(.horizontal,24)
            .navigationTitle(Text(activityOffset.namaAktivitas))
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(.hidden, for: .tabBar)

    }
}

struct ActivityOffsetScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActivityOffsetScreen(activityOffset : TourismViewModel().tourisms[0].kegiatanOffset[0] )
           
    }
}

struct ItemContact : View{
    let image : String
    let action: () -> Void

    var body : some View {
        Button {
            action()
        } label: {
            Image(image)
                .padding(18)
                .background(Color("neutral200"))
                .cornerRadius(12)
        }

    }
}

struct ItemImageOffset: View {
    var offset : OffsetActivity
    
    var body: some View {
        AsyncImage(url: URL(string: offset.fotoKegiatan)) { Image in
            Image
                .resizable()
              
               
        } placeholder: {
           ShimmerView()
        }
        .scaledToFill()
        .frame(width : 342,height : 400)
        .cornerRadius(12)
        .overlay{
            
            VStack {
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.clear)
                        .frame(width: 342, height: 103.07692)
                        .background(Color(red: 0.04, green: 0.17, blue: 0.2).opacity(0.6))
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6){
                            Text(offset.namaAktivitas)
                                .font(.system(size: 20, weight: .bold, design: .rounded))                                .foregroundColor(.white)
                                .lineLimit(2)
                            
                            Text(offset.company)
                                .font(.system(size: 16, weight: .regular, design: .rounded))                                .lineLimit(2)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 24)
                        Spacer()
                    }
              

                    
                    
                }
            }
        }

    }
}

