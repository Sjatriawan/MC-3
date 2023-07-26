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
    

    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var isDataSaved: Bool = false
    
    @Published var selectedProvinceImageURL: URL?

    
    @Published var transportationMethod = "Walk"
    @Published var hotelStarRating = "1 Star"
    
    internal var provinces: [Location] {
        loadProvincesFromJSON()
    }
    
    var selectedProvince: Location {
        provinces[selectedProvinceIndex]
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
        "Walk": 0,
        "Bicycle": 0,
        "Bus": 90,
        "Motorcycle": 120,
        "Ship": 120,
        "Plane": 285,
        "Train": 60
    ]
    
    // Sample data for carbon emissions (in grams) per night for each hotel star rating
    let carbonEmissionsPerNight: [String: Double] = [
        "1 Star": 100,
        "2 Stars": 150,
        "3 Stars": 200
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
        
        PersistenceController.shared.save()
        isDataSaved = true
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
}
