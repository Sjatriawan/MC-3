import SwiftUI
////
////  ItemContentHorizontal.swift
////  Enviroamer
////
////  Created by tiyas aria on 20/07/23.
////
//
//import SwiftUI
//
//// file ini adalah component costum untuk content di explore screen yang horizontal scroll
//


struct ItemContentHorizontal: View {
    var activity: OffsetActivity
    @State private var isShowingContent = false
    @State private var isShowingText = false

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: activity.fotoKegiatan)) { image in
                image
                    .resizable()
            } placeholder: {
                ShimmerViewVertical()
            }
            .scaledToFill()
            .frame(width: 342, height: 237)
            .cornerRadius(12)
            .overlay {
                VStack {
                    Spacer()
                    if isShowingContent {
                        ZStack {
                            Rectangle()
                                .frame(width: 342, height: 75)
                                .foregroundColor(.black)
                                .opacity(0.4)
                                .blur(radius: 8)

                            HStack {
                                VStack(alignment: .leading) {
                                    Text(activity.namaAktivitas)
                                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                                        .padding(.horizontal)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .foregroundColor(.white)

                                    HStack {
                                        Image("pin_location")
                                            .frame(width: 10, height: 15)
                                        Text(activity.company)
                                            .font(.system(size: 15, weight: .regular, design: .rounded))
                                            .lineLimit(1)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom, 10)

                                }
                                Spacer()
                            }
                        }
                    }
                }
            }

        }
        .onAppear {
            // Setelah 5 detik, atur isShowingContent dan isShowingText menjadi true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isShowingContent = true
                isShowingText = true
            }
        }
    }
}
