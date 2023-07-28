//
//  ShimmerView.swift
//  Enviroamer
//
//  Created by tiyas aria on 25/07/23.
//

import SwiftUI

public struct ShimmerView: View {
    
    private struct Constants {
        static let duration: Double = 0.9

        static let minOpacity: Double = 0.25
        static let maxOpacity: Double = 1.00
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    
    public init() {}
    
    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.gray)
                .opacity(opacity)
                .transition(.opacity)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)
                    withAnimation(repeated) {
                        self.opacity = Constants.maxOpacity
                    }
                }
            
//            VStack{
//                RoundedRectangle(cornerRadius: Constants.cornerRadius)
//                    .fill(Color.gray)
//                    .opacity(opacity)
//                    .transition(.opacity)
//                    .onAppear {
//                        let baseAnimation = Animation.easeInOut(duration: Constants.duration)
//                        let repeated = baseAnimation.repeatForever(autoreverses: true)
//                        withAnimation(repeated) {
//                            self.opacity = Constants.maxOpacity
//                        }
//                    }.frame(width:250, height: 30)
//                RoundedRectangle(cornerRadius: Constants.cornerRadius)
//                    .fill(Color.gray)
//                    .opacity(opacity)
//                    .transition(.opacity)
//                    .onAppear {
//                        let baseAnimation = Animation.easeInOut(duration: Constants.duration)
//                        let repeated = baseAnimation.repeatForever(autoreverses: true)
//                        withAnimation(repeated) {
//                            self.opacity = Constants.maxOpacity
//                        }
//                    }.frame(width:250, height: 30)
//            }.position(x:150, y: 180)
        }
        
    }
    
}

public struct ShimmerViewVertical: View {
    
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.15
        static let maxOpacity: Double = 0.50
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    
    public init() {}
    
    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color.gray)
                .opacity(opacity)
                .transition(.opacity)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)
                    withAnimation(repeated) {
                        self.opacity = Constants.maxOpacity
                    }
                }
        
               
            
        }
        
    }
    
}




struct ShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerView()
    }
}

struct ShimmerViewV_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerViewVertical()
    }
}
