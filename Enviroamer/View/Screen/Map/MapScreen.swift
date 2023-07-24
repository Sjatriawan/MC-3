//
//  MapScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 19/07/23.
//


import SwiftUI
import CoreLocation
import MapKit

struct Province: Decodable, Identifiable, Hashable {
    let idProvinsi: Int
    let namaProvinsi: String
    let listWisata: [TouristAttraction]
    let coordinateKota: Coordinate
    let imageKota: String
    let tranportasiProvinsi: [String]
    let kegiatanOffset: [Activity]

    var id: Int {
        return idProvinsi
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(idProvinsi)
    }

    static func == (lhs: Province, rhs: Province) -> Bool {
        return lhs.idProvinsi == rhs.idProvinsi
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


struct MapAnnotationItem: Identifiable {
    var id = UUID()
    var annotation: MKPointAnnotation
}

struct CardViewPr: View {
    let title: String
    let message: String
    let image:String

    var body: some View {
        HStack{
            ZStack{
                Text(title)
                    .font(.title)
            }
            Spacer()
            VStack{
                NavigationLink(destination: TravelPlannerView()) {
                    Text("Add trip")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 44)
                        .background(Color.green)
                        .cornerRadius(12)
                        .shadow(radius: 8)
                }

                
                Button {
                    
                } label: {
                    Text("See more")
                }
                .foregroundColor(.green)
                .frame(width: 150, height: 44)
                .background(.white)
                .cornerRadius(12)
                .overlay(
                RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color(red: 0.25, green: 0.55, blue: 0.25), lineWidth: 1)
                )

               
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
}



struct MapScreen: View {
    @StateObject private var locationManager = LocationManager()
       @State private var annotations: [MapAnnotationItem] = []
       @State private var selectedAnnotation: MapAnnotationItem? = nil

    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                    MapView(annotations: $annotations, selectedAnnotation: $selectedAnnotation)
                                           .edgesIgnoringSafeArea(.all)
                                           .onTapGesture {
                                               selectedAnnotation = nil
                                           }
                                       
                                       if let annotation = selectedAnnotation?.annotation {
                                           createCardView(for: annotation)
                                               .transition(.move(edge: .bottom))
                                               .position(x:200, y: 600)
                                       }
                }
      
            }
            .onAppear {
                if let url = Bundle.main.url(forResource: "map", withExtension: "json") {
                        do {
                            let jsonData = try Data(contentsOf: url)
                            let provinces = try JSONDecoder().decode([Province].self, from: jsonData)
                            var newAnnotations: [MapAnnotationItem] = []
                            
                            for province in provinces {
                                let annotation = MKPointAnnotation()
                                annotation.coordinate = CLLocationCoordinate2D(latitude: province.coordinateKota.latitude, longitude: province.coordinateKota.longitude)
                                annotation.title = province.namaProvinsi
                                newAnnotations.append(MapAnnotationItem(annotation: annotation))
                            }
                            
                            if let userLocation = locationManager.lastKnownLocation {
                                let userAnnotation = MKPointAnnotation()
                                userAnnotation.coordinate = userLocation.coordinate
                                userAnnotation.title = "Current Location"
                                newAnnotations.append(MapAnnotationItem(annotation: userAnnotation))
                            }
                            
                            annotations = newAnnotations
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                
            }
        }

    }

    func createAlert(for annotation: MKPointAnnotation) -> Alert {
        let distanceString = distanceFromCurrentLocation(to: annotation.coordinate)
        let alertTitle = annotation.title ?? "Unknown Location"
        let message = "Distance from Current Location: \(distanceString)"

        return Alert(title: Text(alertTitle), message: Text(message), dismissButton: .default(Text("OK")))
    }
    
    func createCardView(for annotation: MKPointAnnotation) -> some View {
        let distanceString = distanceFromCurrentLocation(to: annotation.coordinate)
        let title = annotation.title ?? "Unknown Location"
        let message = "Distance from Current Location: \(distanceString)"
        let image = ""

        return CardViewPr(title: title, message: message, image: image)
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
    @Binding var annotations: [MapAnnotationItem]
    @Binding var selectedAnnotation: MapAnnotationItem?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator // Set the delegate to the coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations.map(\.annotation)) // Extract the annotations from the MapAnnotationItem
        
        print("Number of annotations:", annotations.count)
        print("Selected annotation:", selectedAnnotation?.annotation.title ?? "None")
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            // Get the selected annotation and set it in the parent view
            if let selectedAnnotation = view.annotation as? MKPointAnnotation {
                parent.selectedAnnotation = parent.annotations.first(where: { $0.annotation == selectedAnnotation })
            }
        }
    }
}


struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
