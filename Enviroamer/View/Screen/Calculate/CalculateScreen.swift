//
//  CalculateScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 19/07/23.
//

import SwiftUI
import MapKit
import CoreLocation



struct TravelPlannerStepView: View {
    @StateObject private var viewModel = TravelPlannerViewModel()
    @State private var currentStep: Int = 1
    @StateObject private var locationManager = LocationManager()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Location"){
                    
                }
                if currentStep == 1 {
                    Form {
                        // Step 1: Current Location
                        Section(header: Text("Current Location")) {
                            if let location = viewModel.locationManager.lastKnownLocation {
                                Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                            } else {
                                Text("Location not available")
                            }
                            
                            
                            // Step 2: Select a Province
                            Section {
                                Picker("Select a Province", selection: $viewModel.selectedProvinceIndex) {
                                    ForEach(viewModel.provinces.indices, id: \.self) { index in
                                        Text(viewModel.provinces[index].namaProvinsi).tag(index)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                            
                            // Step 5: Distance to Province
                            Section(header: Text("Distance to Province")) {
                                Text(viewModel.distanceToProvince)
                            }
                            
                            
                        }
                    }
                } else if currentStep == 2 {
                    Form {
                        // Step 3: Trip Duration
                        Section(header: Text("Trip Duration")) {
                            DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                            DatePicker("End Date", selection: $viewModel.endDate, displayedComponents: .date)
                        }
                        
                        Section(header: Text("Days of Travel")) {
                            Text("\(viewModel.daysOfTravel) days")
                        }
                    }
                } else if currentStep == 3 {
                    Form {
                        // Step 6: Transportation Method
                        Section(header: Text("Transportation Method")) {
                            Picker("Transportation Method", selection: $viewModel.transportationMethod) {
                                Text("Walk").tag("Walk")
                                Text("Bicycle").tag("Bicycle")
                                Text("Bus").tag("Bus")
                                Text("Motorcycle").tag("Motorcycle")
                                Text("Ship").tag("Ship")
                                Text("Plane").tag("Plane")
                                Text("Train").tag("Train")
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                } else if currentStep == 4 {
                    Form {
                        // Step 7: Hotel Star Rating
                        Section(header: Text("Hotel Star Rating")) {
                            Picker("Hotel Star Rating", selection: $viewModel.hotelStarRating) {
                                Text("1 Star").tag("1 Star")
                                Text("2 Stars").tag("2 Stars")
                                Text("3 Stars").tag("3 Stars")
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                } else if currentStep == 5 {
                    ContentView()
                    NavigationLink(destination: ProvinceDetailView(province: viewModel.selectedProvince)) {
                        Text("Plan Your Trip")
                    }
                } else{
                }
                
                HStack {
                    Button("Previous") {
                        if currentStep > 1 {
                            currentStep -= 1
                        }
                    }
                    .disabled(currentStep == 1)
                    
                    Spacer()
                    
                    Button("Next") {
                        if currentStep < 5 {
                            currentStep += 1
                        }
                    }
                    .disabled(currentStep == 5)
                }
                .padding()
            }
            .navigationBarTitle("\(viewModel.totalCarbonEmissions, specifier: "%.2f") grams CO2")
        }
        
        
        
    }
   
}




struct TravelPlannerView: View {
    @StateObject private var viewModel = TravelPlannerViewModel()
    @State private var isExpanded = false
    let image: [String] = ["bali", "ntb","kepri","jabar"]
    @State private var startDate = Date()
       @State private var endDate = Date()
    @State private var locationDetails: String = ""

    
    
    var body: some View {
        ScrollView{
            NavigationView {
                
                VStack{
                    HStack{
                        Text("\(viewModel.totalCarbonEmissions, specifier: "%.2f") grams CO2")
                        Image(systemName: "info.circle").foregroundColor(.green)
                    }
                    Divider().background(.black).padding()
                    VStack(alignment: .leading){
        
                        Text("location detail\(locationDetails)")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                        
                    }.frame(maxWidth: .infinity, alignment: .leading).padding()
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHGrid(rows: gridLayout) {
                            ForEach(viewModel.provinces.indices, id: \.self) { index in
                                Button(action: {
                                    viewModel.selectedProvinceIndex = index
                                }) {
                                    VStack {
                                        Image(image[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10) // Add RoundedRectangle as overlay
                                                    .stroke(index == viewModel.selectedProvinceIndex ? Color("green600") : Color.gray, lineWidth: 2) // Apply different stroke color based on selection
                                            )
                                        
                                        
                                        Text(viewModel.provinces[index].namaProvinsi)
                                            .foregroundColor(index == viewModel.selectedProvinceIndex ? .green : .primary).font(.system(size: 12))
                                        
                                    }
                                }
                            }.padding()
                            
                        }
                    }.frame(height: 120)
                        .blur(radius: !isExpanded ? 0:5)
                    //
                    
                    
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                            .frame(width: 324, height: 51, alignment: .leading)
                            .overlay(
                                VStack{
                                    HStack{
                                        Text("When")
                                        Spacer()
                                        Text("\(formatteDate(viewModel.startDate)) - \(formatteDate(viewModel.endDate))")

                                    }
                                    
                                }.padding()
                                
                            )
                    }
                    .contentShape(Rectangle())
                    .blur(radius: !isExpanded ? 0:0)
                    
                    
                    if isExpanded {
                        VStack(alignment: .leading){
                            CustomRangeDatePicker(startDate: $viewModel.startDate, endDate: $viewModel.endDate)
                        }.blur(radius: !isExpanded ? 0:0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    
                    VStack{
                        Picker("Transportation Method", selection: $viewModel.transportationMethod) {
                            Text("Walk").tag("Walk")
                            Text("Bicycle").tag("Bicycle")
                            Text("Bus").tag("Bus")
                            Text("Motorcycle").tag("Motorcycle")
                            Text("Ship").tag("Ship")
                            Text("Plane").tag("Plane")
                            Text("Train").tag("Train")
                        }.frame(height: 51)
                            .frame(width: 324, height: 51, alignment: .leading)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                            ).blur(radius: !isExpanded ? 0:5)
                        Picker("Hotel Star Rating", selection: $viewModel.hotelStarRating) {
                            Text("3 Star").tag("3 Star")
                            Text("4 Stars").tag("4 Stars")
                            Text("5 Stars").tag("5 Stars")
                        }.frame(height: 51)
                            .frame(width: 324, height: 51, alignment: .leading)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                            ).blur(radius: !isExpanded ? 0:5)
                    }
                    
                    
                    
                    
                    Spacer()
                    
                    //
                    Button {
                        viewModel.saveData()
                    } label: {
                        HStack(alignment: .center, spacing: 10){
                            Text("Save").foregroundColor(.white)
                        }.padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color(red: 0.25, green: 0.55, blue: 0.25))
                            .cornerRadius(10)
                    }.alert(isPresented: $viewModel.isDataSaved) {
                        Alert(title: Text("Data Saved"), message: Text("Your trip data has been saved."), dismissButton: .default(Text("OK")) {
                            viewModel.resetIsDataSaved()
                        })
                    }.blur(radius: !isExpanded ? 0:5)
                    
                }.padding()
                
                
                
                
            }
        }
        
    }
    
    
    var gridLayout: [GridItem] {
        [GridItem(.flexible())]
    }
    
    private func formatteDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "d MMMM"
           return formatter.string(from: date)
       }
    
}



class ProvinceDetailViewModel: ObservableObject {
    let province: Location
    
    init(province: Location) {
        self.province = province
    }
}


struct ProvinceDetailView: View {
    @StateObject private var viewModel: ProvinceDetailViewModel
    
    init(province: Location) {
        _viewModel = StateObject(wrappedValue: ProvinceDetailViewModel(province: province))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.province.namaProvinsi)
                .font(.title)
        }
        .navigationBarTitle(viewModel.province.namaProvinsi)
    }
}




struct CalculateScreen_Previews: PreviewProvider {
    static var previews: some View {
        TravelPlannerView()
    }
}



struct CalendarView: View {
    @Binding var isSelectingStartDate: Bool
    @Binding var startDate: Date
    @Binding var endDate: Date

    var body: some View {
        VStack {
            DatePicker("", selection: isSelectingStartDate ? $startDate : $endDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(height: 300)
                .onChange(of: startDate) { newValue in
                    if startDate > endDate {
                        endDate = startDate
                    }
                }
                .onChange(of: endDate) { newValue in
                    if endDate < startDate {
                        startDate = endDate
                    }
                }

            HStack {
                Button("Start Date") {
                    isSelectingStartDate = true
                }
                .padding()
                .foregroundColor(isSelectingStartDate ? .white : .green)
                .background(isSelectingStartDate ? Color.green : Color.clear)
                .cornerRadius(42)
                Spacer()
                Button("End Date") {
                    isSelectingStartDate = false
                }
                .padding()
                .foregroundColor(isSelectingStartDate ? .green : .white)
                .background(isSelectingStartDate ? Color.clear : Color.green)
                .cornerRadius(42)
            }
            .padding(.top, 8)
        }
    }
}

struct CustomRangeDatePicker: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @State private var isSelectingStartDate = true

    var body: some View {
        VStack {
            CalendarView(isSelectingStartDate: $isSelectingStartDate, startDate: $startDate, endDate: $endDate)
        }
        .padding()
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
