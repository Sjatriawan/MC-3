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

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Carbon Emissions")) {
                    Text("\(viewModel.totalCarbonEmissions, specifier: "%.2f") grams CO2")
                }
                
                Section(header: Text("Current Location")) {
                    if let location = viewModel.locationManager.lastKnownLocation {
                        Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                    } else {
                        Text("Location not available")
                    }
                }
                
                Section(header: Text("Select a Province")) {
                    Picker("Select a Province", selection: $viewModel.selectedProvinceIndex) {
                        ForEach(viewModel.provinces.indices, id: \.self) { index in
                            Text(viewModel.provinces[index].namaProvinsi).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                Section(header: Text("Trip Duration")) {
                    DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $viewModel.endDate, displayedComponents: .date)
                }
                
                Section(header: Text("Days of Travel")) {
                    Text("\(viewModel.daysOfTravel) days")
                }
                
                Section(header: Text("Distance to Province")) {
                    Text(viewModel.distanceToProvince)
                }
                
                Picker("Transportation Method", selection: $viewModel.transportationMethod) {
                    Text("Walk").tag("Walk")
                    Text("Bicycle").tag("Bicycle")
                    Text("Bus").tag("Bus")
                    Text("Motorcycle").tag("Motorcycle")
                    Text("Ship").tag("Ship")
                    Text("Plane").tag("Plane")
                    Text("Train").tag("Train")
                }
                
                Picker("Hotel Star Rating", selection: $viewModel.hotelStarRating) {
                    Text("1 Star").tag("1 Star")
                    Text("2 Stars").tag("2 Stars")
                    Text("3 Stars").tag("3 Stars")
                }
                
                NavigationLink(destination: ProvinceDetailView(province: viewModel.selectedProvince)) {
                    Text("Plan Your Trip")
                }
            }
            .navigationBarTitle("Travel Planner")
            .navigationBarItems(trailing: Button("Save") {
                viewModel.saveData()
            })
            .alert(isPresented: $viewModel.isDataSaved) {
                            Alert(title: Text("Data Saved"), message: Text("Your trip data has been saved."), dismissButton: .default(Text("OK")) {
                                viewModel.resetIsDataSaved()
                            })
                        }
        }
    }
}

struct ProvinceDetailView: View {
    var province: Province
    
    var body: some View {
        // Add the details of the selected province here
        Text(province.namaProvinsi)
    }
}



class ProvinceDetailViewModel: ObservableObject {
    let province: Province
    
    init(province: Province) {
        self.province = province
    }
}







struct CalculateScreen_Previews: PreviewProvider {
    static var previews: some View {
        TravelPlannerStepView()
    }
}


struct StepTwo: View {
    @StateObject private var viewModel = TravelPlannerViewModel()
    @State private var currentStep: Int = 1
    @StateObject private var locationManager = LocationManager()
    @State private var selectedProvinceIndex = 0
    @StateObject var SViewModel = ModernSegmentedPickerViewModel(options: ["Walk", "Bicycle", "Bus", "Motorcycle", "Ship", "Plane", "Train"])



    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(viewModel.totalCarbonEmissions, specifier: "%.2f") grams CO2")
                Image(systemName: "info.circle").foregroundColor(.green)
            }
            
            Divider().padding()
            Text("Where to")
            HStack{
                Image("Pin Point Location Icon")
                .frame(width: 15, height: 21)
                .background(Color(red: 0.25, green: 0.55, blue: 0.25))
                if let location = viewModel.locationManager.lastKnownLocation {
                    Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                } else {
                    Text("Location not available")
                }
            }.frame(width:340, height: 30, alignment: .leading).padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
            )
            
            
            Section(header: Text(".")) {
                                Picker("Select a Province", selection: $selectedProvinceIndex) {
                                    ForEach(viewModel.provinces.indices, id: \.self) { index in
                                        Text(viewModel.provinces[index].namaProvinsi).tag(index)
                                    }
                                }.frame(width:340, height: 30, alignment: .leading).padding()
                                .pickerStyle(MenuPickerStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                                )

                               
                            }
            
            Divider()
            
            HStack{
                Section(header: Text("When")) {
                    DatePicker("", selection: $viewModel.startDate, displayedComponents: .date)
                    DatePicker("-", selection: $viewModel.endDate, displayedComponents: .date)
                }
            }.frame(width:340, height: 30, alignment: .leading).padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
            )
            
            Text("How will you get there?")
            ModernSegmentedPicker(viewModel: SViewModel)
                        Text("Selected Option: \(SViewModel.selectedOption)")
                
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).padding()
    }
}

struct ModernSegmentedPicker: View {
    @ObservedObject var viewModel: ModernSegmentedPickerViewModel
    
    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 2) {
                ForEach(viewModel.options[0..<3], id: \.self) { option in
                    outlineButton(for: option)
                }
            }
            
            HStack(spacing: 2) {
                ForEach(viewModel.options[3..<6], id: \.self) { option in
                    outlineButton(for: option)
                }
            }
            
            HStack(spacing: 2) {
                ForEach(viewModel.options[6..<viewModel.options.count], id: \.self) { option in
                    outlineButton(for: option)
                }
            }
        }
        .frame(height: 100)
    }
    
    @ViewBuilder
    private func outlineButton(for option: String) -> some View {
        OutlineButton(action: {
            viewModel.selectedOption = option
        }) {
            HStack {
                Image(systemName: viewModel.selectedOption == option ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .frame(width: 30)
                
                Text(option)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(viewModel.selectedOption == option ? Color.green : Color.gray)
            .cornerRadius(8)
        }
    }
}

struct OutlineButton<Content: View>: View {
    var action: () -> Void
    var content: () -> Content
    
    var body: some View {
        Button(action: action) {
            content()
        }
    }
}


class ModernSegmentedPickerViewModel: ObservableObject {
    @Published var selectedOption: String = ""
    let options: [String]
    
    init(options: [String]) {
        self.options = options
    }
}



struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepTwo()
    }
}
