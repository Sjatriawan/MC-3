//
//  OnBoardingScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 27/07/23.
//

import SwiftUI



struct OnboardingView: View {
    
    @State private var currentPage: Int = 0
        private let pageCount = 3
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                TabView(selection: $currentPage) {
                    OnboardingScreen(imageName: "mount",
                                     title: "Welcome to EnviRoamer",
                                     description: "Discover eco-friendly destinations in Indonesia that support the practice of eco-conscious travel",
                                     isLastPage: false)
                        .tag(0)
                    OnboardingScreen(imageName: "airplane",
                                     title: "Calculate Travel Footprint ",
                                     description: "Estimate carbon footprint from different destinations and choose a better option to minimize the impact",
                                     isLastPage: false)
                        .tag(1)
                    OnboardingScreen(imageName: "bicycle",
                                     title: "Stay Conscious on Your Journey",
                                     description: "Track upcoming trips and create wishlist to encourage you to go for sustainable adventures in the future",
                                     isLastPage: true)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide the default page indicator

                HStack(spacing: 8) {
                    ForEach(0..<pageCount) { index in
                        Rectangle()
                            .fill(index == currentPage ? Color("green600") : Color.white)
                            .frame(width: 28, height: 4)
                            .cornerRadius(2)
                    }
                }
                .padding(.bottom, 150)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct OnboardingScreen: View {
    
    var imageName: String
    var title: String
    var description: String
    var isLastPage: Bool

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 48, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 22, weight: .light, design: .rounded))
                    .foregroundColor(.white)
                

            }
            .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .bottom)
            .padding(.horizontal, 24)
            .padding(.bottom, 190)
            
            VStack{
                if isLastPage {
                    Button(action: {
                        HomeScreen() //navigate ke halaman selanjutnya
                    }) {
                        Text("Get Started")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 350, height: 58, alignment: .center)
                            .background(Color("green600"))
                            .cornerRadius(12)
                            .padding(.bottom, 70)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .bottom)
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
