//
//  TripCardScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import SwiftUI



struct TripCardScreen: View {
    @EnvironmentObject var modelWisata : TourismViewModel
    @State private var selectedIndex = 0
    
    //     for core data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Trip.startDate, ascending: true)],
        animation: .default)
    private var trips: FetchedResults<Trip>
 
    
    
    let location: Location
    //    let trip : Trip? = nil
    
    var body: some View {
        let index = trips.first { trip in
            trip.idProvince == location.idProvinsi
        }
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32){
                    
                    if let index {
                        ItemImageCard(trip: index, location: location)
                    } else {
                       ItemImageCardNoTrip(location: location)
                    }
                   

                    
                    TabBarView(selectedIndex: $selectedIndex)
                    
                    if selectedIndex == 0 {
                        if let index {
                            CarbonContentTrip(trip: index, location: location)
                        } else {
                            VStack(alignment: .center, spacing: 16){
                                Text("Hi, you haven't added your traveling trip yet.")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 300)
                                
                                Text("Determine your destination for tourism and predict your carbon emissions right now.")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .multilineTextAlignment(.center)
                                   
                            }
                        }
                        
                    } else if selectedIndex == 1 {
                        DestinationContentTrip(idProvinsi: location.idProvinsi)
                    } else if selectedIndex == 2 {
                        ActivityOffsetContentTrip(idProvinsi: location.idProvinsi)
                    } else if selectedIndex == 3 {
                        TransportationContentTrip(idProvinsi: location.idProvinsi)
                    } else {
                        Text("")
                    }
                    
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle(location.namaProvinsi)
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(.hidden, for: .tabBar)
        
    }
    
    
    struct TabBarView : View {
        @Binding var selectedIndex : Int
        var tabBarOptions : [String] = ["Prediction" , "Eco-destination", "Offset", "Get around"]
        var body : some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 24){
                    ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)), id: \.0) {
                        index , name in
                        TabBarItem(selectedIndex: $selectedIndex, tabBarItemName: name, tab: index,
                                   colorText: (index == selectedIndex) ? Color("green600") : Color("grey300")
                        )
                    }
                }
            }
            .background(.white)
            .frame(height: 46)
        }
    }
    struct TabBarItem : View {
        @Binding var selectedIndex : Int
        var tabBarItemName : String
        var tab : Int
        var colorText : Color
        
        var body : some View {
            Button {
                self.selectedIndex = tab
            } label: {
                VStack{
                    Spacer()
                    Text(tabBarItemName)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .bold()
                        .foregroundColor(colorText)
                    
                    if selectedIndex == tab {
                        Color("green600")
                            .frame(height: 2)
                    } else {
                        Color.clear.frame(height: 2)
                        
                    }
                }
            }
            .buttonStyle(.plain)
            
        }
    }
    
    
    
}

struct TripCardScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripCardScreen(location: TourismViewModel().tourisms[0])
            .environmentObject(TourismViewModel())
            .environmentObject(FavoritesViewModel())
        
    }
}
