//
//  MapScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 19/07/23.
//

import SwiftUI


import SwiftUI
import CoreLocation
import MapKit

struct Province: Decodable, Identifiable, Hashable{
    
    let idProvinsi: Int
    let namaProvinsi: String
    let listWisata: [TouristAttraction]
    let coordinateKota: Coordinate
    let imageKota: String
    let tranportasiProvinsi: [String]
    let kegiatanOffset: [Activity]

    var id: Int { // Implementing the Identifiable protocol with 'id' property
        return idProvinsi
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idProvinsi)
    }

    static func == (lhs: Province, rhs: Province) -> Bool {
        lhs.idProvinsi == rhs.idProvinsi
    }
}

struct TouristAttraction: Decodable {
    let id: Int
    let nama: String
    let coordinateWisata: Coordinate
    let lokasi: String
    let waktuOperasional: String
    let deskripsi: String
    let image: [String]
    let kegiatan: [String]
    let transportasiWisata: [String]
}

struct Coordinate: Decodable {
    let latitude: Double
    let longitude: Double
}

struct Activity: Decodable {
    let id: Int
    let namaAktivitas: String
    let company: String
    let deskripsiKegiatan: String
    let fotoKegiatan: String
    let alamat: String
    let noTelp: String
    let email: String
    let website: String
    let instagram: String
}

struct MapScreen: View {
    @StateObject private var locationManager = LocationManager()
    @State private var annotations: [MKPointAnnotation] = []

    var body: some View {
        VStack {
            MapView(annotations: $annotations)
                .edgesIgnoringSafeArea(.all)

            List {
                ForEach(annotations, id: \.self) { annotation in
                    Text("\(annotation.title ?? "Unknown"): \(distanceFromCurrentLocation(to: annotation.coordinate))")
                }
            }
          
            
        }
        .onAppear {
            
            if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
                do {
                    let jsonData = try Data(contentsOf: url)
                    let provinces = try JSONDecoder().decode([Province].self, from: jsonData)
                    var newAnnotations: [MKPointAnnotation] = []

                    for province in provinces {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: province.coordinateKota.latitude, longitude: province.coordinateKota.longitude)
                        annotation.title = province.namaProvinsi
                        newAnnotations.append(annotation)
                    }

                    // Add current user location annotation
                    if let userLocation = locationManager.lastKnownLocation {
                        let userAnnotation = MKPointAnnotation()
                        userAnnotation.coordinate = userLocation.coordinate
                        userAnnotation.title = "Current Location"
                        newAnnotations.append(userAnnotation)
                    }
                    

                    annotations = newAnnotations
                    
                    
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            
        }
    }

    func distanceFromCurrentLocation(to coordinate: CLLocationCoordinate2D) -> String {
        guard let userLocation = locationManager.lastKnownLocation else {
            return "N/A"
        }

        let currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let destinationLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let distanceInMeters = currentLocation.distance(from: destinationLocation)
        let distanceInKilometers = distanceInMeters / 1000.0

        return String(format: "%.2f km", distanceInKilometers)
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var lastKnownLocation: CLLocation? = nil

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last
    }
    
   
}

struct MapView: UIViewRepresentable {
    @Binding var annotations: [MKPointAnnotation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
    }
}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
