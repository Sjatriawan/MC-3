////
////  SplashScreen.swift
////  Enviroamer
////
////  Created by M Yogi Satriawan on 27/07/23.
////


import SwiftUI

struct SplashScreen: View {
    
    @State private var shouldShowSplash = false
    @Environment(\.colorScheme) var colorScheme
    @State private var size = 0.3
    @State private var opacity = 0.5
    
    @StateObject  private var userViewModel = UserViewModel()
    
    var body: some View {
        if self.shouldShowSplash {
            if userViewModel.currentUserSignIn {
                HomeScreen()
            } else {
                OnboardingView()
            }
        } else {
            
            VStack {
                VStack{
                    Image("app_logo") // Gambar untuk light mode
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .scaleEffect(size)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: 2))
                     
                    
                }
                .onAppear{
                    withAnimation(.easeInOut(duration: 2)) {
                        size = 1.0
                        opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldShowSplash = true
                }
                
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
