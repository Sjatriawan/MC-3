//
//  CalculateScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 19/07/23.
//

import SwiftUI
import MapKit
import CoreLocation








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
                
                Section(header: Text("Province Image")) {
                    if let imageURL = viewModel.selectedProvinceImageURL {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200) // Adjust the image frame as needed
                    } else {
                        Text("Image not available")
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
