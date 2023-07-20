//
//  HomeScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 18/07/23.
//

import SwiftUI


struct TabBar: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }.onAppear(
                )
            
            ContentView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
    }
}





struct HomeScreen: View {
    @State private var selectedSegment = 0
        private let segments = ["Upcoming trips", "Past trips"]
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack{
                    Text("Trip")
                    Spacer()
         
                    NavigationLink(destination: TravelPlannerStepView()) {
                        Text("add")
                    }

                    
                }
                MenuTrips()
            }.frame(alignment: .leading).padding()
        }
    }
}




struct SegmentedBar: View {
    @Binding var selectedSegment: Int
    let segments: [String]

    var body: some View {
        HStack {
            ForEach(0..<segments.count) { index in
                Button(action: {
                    selectedSegment = index
                }) {
                    Text(segments[index])
                        .foregroundColor(selectedSegment == index ? .white : .blue)
                        .padding()
                        .background(selectedSegment == index ? Color.blue : Color.clear)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct MenuTrips: View {
    @State private var selectedSegment = 0
        private let segments = ["Upcoming trips", "Past trips"]
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                
                SegmentedBar(selectedSegment: $selectedSegment, segments: segments)
                
                if selectedSegment == 0 {
                    UpcomingTrips()
                }else if selectedSegment == 1 {
                    Text("Content for Segment 2")
                }
            }
        }
    }
}




struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
