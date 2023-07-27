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
    @StateObject  private var userViewModel = UserViewModel()

        var body: some View {
            ZStack{
                if self.shouldShowSplash {
                    if userViewModel.currentUserSignIn {
                        HomeScreen()
                    } else {
                        OnboardingView()
                    }
                } else {
                    ContainerRelativeShape()
                        .fill(Color("neutral200"))
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
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldShowSplash = true
                }
               
            }
        }
    }

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
