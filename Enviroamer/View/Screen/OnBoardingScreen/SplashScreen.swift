//
//  SplashScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 27/07/23.
//


import SwiftUI

struct SplashScreen: View {

        @State private var shouldShowSplash = false
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            ZStack{
                ContainerRelativeShape()
                    .fill(Color("offWhite"))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(shouldShowSplash ? 0 : 1)
                
                VStack{
                    if colorScheme == .dark {
                        Image("applogo") // Gambar untuk dark mode
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
//                            .opacity(shouldShowSplash ? 0 : 1)
                    } else {
                        Image("applogo") // Gambar untuk light mode
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
//                            .opacity(shouldShowSplash ? 0 : 1)
                    }
    
                    Text("Travel consciously, Experience differently")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(Color("green600"))
                }
                .opacity(shouldShowSplash ? 0 : 1)
                .padding(.horizontal, 24)
            }
            
            .onAppear {
                withAnimation(.easeInOut(duration: 2.5)) {
                    shouldShowSplash = true // Mengubah nilai shouldShowSplash untuk memicu animasi fade
                    }
            }
        }
    }

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
