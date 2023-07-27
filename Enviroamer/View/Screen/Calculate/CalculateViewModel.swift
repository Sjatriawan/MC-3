//
//  CalculateViewModel.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 19/07/23.
//

import Foundation
import CoreLocation
import SwiftUI
import CoreData

class TravelPlannerViewModel: ObservableObject {
    @Published var locationManager = LocationManager()
    @Published var currentLocation: String = ""
    @Published var selectedProvinceIndex: Int = 0
    
    @Published var locationDetails: String = ""

    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var isDataSaved: Bool = false
    
    @Published var selectedProvinceImageURL: URL?

    
    @Published var transportationMethod = "Walk"
    @Published var hotelStarRating = "3 stars"
    
    internal var provinces: [Location] {
        loadProvincesFromJSON()
    }
    
    var selectedProvince: Location {
        provinces[selectedProvinceIndex]
    }

    
    func updateDateRange() {
           // Add logic to update the endDate when the startDate changes if needed
           // For simplicity, I'll set the endDate to be one day after the startDate
           let calendar = Calendar.current
           endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
       }
       
       var dateRange: ClosedRange<Date> {
           startDate...endDate
       }
       
       var dateClosedRange: ClosedRange<Date> {
           // Customize the available date range as per your requirements
           let calendar = Calendar.current
           let minDate = calendar.date(byAdding: .day, value: -365, to: Date())!
           let maxDate = calendar.date(byAdding: .day, value: 365, to: Date())!
           return minDate...maxDate
       }
 
    
    var daysOfTravel: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
    
    
    var distanceToProvince: String {
        if let userLocation = locationManager.lastKnownLocation {
            let provinceCoordinate = CLLocationCoordinate2D(latitude: selectedProvince.coordinateKota.latitude, longitude: selectedProvince.coordinateKota.longitude)
            return calculateDistance(from: userLocation.coordinate, to: provinceCoordinate)
        } else {
            return "N/A"
        }
    }
    
    func updateSelectedProvinceImageURL() {
        if selectedProvinceIndex >= 0 && selectedProvinceIndex < provinces.count {
            let selectedProvince = provinces[selectedProvinceIndex]
            selectedProvinceImageURL = URL(string: selectedProvince.imageKota)
        } else {
            selectedProvinceImageURL = nil
        }
    }



    
    func calculateDistance(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) -> String {
        let startLocation = CLLocation(latitude: start.latitude, longitude: start.longitude)
        let endLocation = CLLocation(latitude: end.latitude, longitude: end.longitude)
        
        let distanceInMeters = startLocation.distance(from: endLocation)
        let distanceInKilometers = distanceInMeters / 1000.0
        
        return String(format: "%.2f km", distanceInKilometers)
    }

    let carbonEmissionsPerKilometer: [String: Double] = [
        "Walk": 5,
        "Bicycle": 0,
        "Bus": 105,
        "Motorcycle": 103,
        "Ship": 19,
        "Plane": 255,
        "Train": 41
    ]
    
    let carbonEmissionsPerNight: [String: Double] = [
        "3 stars": 35.600,
        "4 stars": 71.700 ,
        "5 stars": 135.000
    ]
    
    func calculateDistanceInKilometers() -> Double {
        if let userLocation = locationManager.lastKnownLocation {
            let provinceCoordinate = CLLocationCoordinate2D(latitude: selectedProvince.coordinateKota.latitude, longitude: selectedProvince.coordinateKota.longitude)
            let userLocationCoordinate = userLocation.coordinate
            
            let startLocation = CLLocation(latitude: userLocationCoordinate.latitude, longitude: userLocationCoordinate.longitude)
            let endLocation = CLLocation(latitude: provinceCoordinate.latitude, longitude: provinceCoordinate.longitude)
            
            return startLocation.distance(from: endLocation) / 1000.0
        } else {
            return 0.0
        }
    }
    
    var totalCarbonEmissions: Double {
        let distanceInKilometers = calculateDistanceInKilometers()
        
        // Calculate carbon emissions for transportation
        let transportationCarbonEmissions = carbonEmissionsPerKilometer[transportationMethod] ?? 0
        let totalTransportationCarbon = distanceInKilometers * transportationCarbonEmissions
        
        // Calculate carbon emissions for hotel stays
        let nightsOfStay = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        let hotelCarbonEmissionsPerNight = carbonEmissionsPerNight[hotelStarRating] ?? 0
        let totalHotelCarbon = Double(nightsOfStay) * hotelCarbonEmissionsPerNight
        
        return totalTransportationCarbon + totalHotelCarbon
    }
    
    var totalCarbonTransport : Double {
        let distanceInKilometers = calculateDistanceInKilometers()
        
        // Calculate carbon emissions for transportation
        let transportationCarbonEmissions = carbonEmissionsPerKilometer[transportationMethod] ?? 0
        let totalTransportationCarbon = distanceInKilometers * transportationCarbonEmissions
         return totalTransportationCarbon
    }
    
    var totalCarbonAkomodasi : Double {
        // Calculate carbon emissions for hotel stays
        let nightsOfStay = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        let hotelCarbonEmissionsPerNight = carbonEmissionsPerNight[hotelStarRating] ?? 0
        let totalHotelCarbon = Double(nightsOfStay) * hotelCarbonEmissionsPerNight
        
        return totalHotelCarbon
    }
    // Core Data context
    private let context = PersistenceController.shared.container.viewContext

    // Save the input data to Core Data
    func saveData() {
        let newTrip = Trip(context: context)
        newTrip.startDate = startDate
        newTrip.endDate = endDate
        newTrip.transportationMethod = transportationMethod
        newTrip.hotelStarRating = hotelStarRating
        newTrip.distanceToProvince = distanceToProvince
        newTrip.totalCarbonEmissions = totalCarbonEmissions
        newTrip.provinceName = provinces[selectedProvinceIndex].namaProvinsi
        newTrip.imageKota = provinces[selectedProvinceIndex].imageKota
        newTrip.idProvince = Int64(provinces[selectedProvinceIndex].idProvinsi)
        newTrip.totalCarbonAkomodasi = totalCarbonAkomodasi
        newTrip.totalCarbonTransport = totalCarbonTransport
        
        
        PersistenceController.shared.save()
        isDataSaved = true
    }
    
    func deleteTrip(_ trip : Trip) {
            context.delete(trip)
            PersistenceController.shared.save()
            }

    func resetIsDataSaved() {
            isDataSaved = false
        }
    
    // Fetch the saved data from Core Data
    func fetchSavedTrips() -> [Trip] {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    private func loadProvincesFromJSON() -> [Location] {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                return try JSONDecoder().decode([Location].self, from: jsonData)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return []
    }
    
    func reverseGeocodeLocation(_ location: CLLocation) {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    self.locationDetails = "Reverse geocoding failed with error: \(error.localizedDescription)"
                    return
                }

                if let placemark = placemarks?.first {
                    let province = placemark.administrativeArea ?? ""
                    let city = placemark.locality ?? ""

                
                    self.locationDetails = "\(city),\(province)"
                }
            }
        }

    
    
}
