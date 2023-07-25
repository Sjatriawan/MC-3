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
    
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("\(viewModel.totalCarbonEmissions, specifier: "%.2f") grams CO2")
                    Image(systemName: "info.circle").foregroundColor(.green)
                }
                Divider().background(.black).padding()
                VStack(alignment: .leading){
                    Text("Where to?")
                    if let location = viewModel.locationManager.lastKnownLocation {
                        Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                            .frame(height: 51)
                            .padding(.leading)
                            .padding(.trailing)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                            )
                        
                    } else {
                        Text("Location not available")
                            .frame(height: 51)
                            .padding(.leading)
                            .padding(.trailing)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                            )
                        
                    }
                    
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading).padding()
                
                
                //
                Picker("Select a Province", selection: $viewModel.selectedProvinceIndex) {
                    ForEach(viewModel.provinces.indices, id: \.self) { index in
                        Text(viewModel.provinces[index].namaProvinsi).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
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
                                        VStack(alignment: .leading){
                                            HStack {
                                                Text("When")
                                            }
                                           
                                        }
                                        .padding(.horizontal)
                                    
                                    )
                            }
                            .contentShape(Rectangle())
                if isExpanded {
                    Section{
                        DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                        DatePicker("End Date", selection: $viewModel.endDate, displayedComponents: .date)
                    }
                    .padding(.horizontal)
                }
                           
                     Spacer()
         
                //
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 10){
                        Text("Save").foregroundColor(.white)
                    }.padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color(red: 0.25, green: 0.55, blue: 0.25))
                        .cornerRadius(10)
                }

            }.padding()
            Form {
                
                
                Section(header: Text("Current Location")) {
                    
                }
                
                //                Section(header: Text("Province Image")) {
                //                    if let imageURL = viewModel.selectedProvinceImageURL {
                //                        AsyncImage(url: imageURL) { image in
                //                            image
                //                                .resizable()
                //                                .aspectRatio(contentMode: .fit)
                //                        } placeholder: {
                //                            ProgressView()
                //                        }
                //                        .frame(height: 200) // Adjust the image frame as needed
                //                    } else {
                //                        Text("Image not available")
                //                    }
                //                }.hidden()
                
                
                Section(header: Text("Select a Province")) {
                    Picker("Select a Province", selection: $viewModel.selectedProvinceIndex) {
                        ForEach(viewModel.provinces.indices, id: \.self) { index in
                            Text(viewModel.provinces[index].namaProvinsi).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Plan your trip")
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
