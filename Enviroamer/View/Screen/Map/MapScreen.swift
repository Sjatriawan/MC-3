//
//  MapScreen.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 19/07/23.
//


import SwiftUI
import CoreLocation
import MapKit




struct MapAnnotationItem: Identifiable {
    var id = UUID()
    var annotation: MKPointAnnotation
}

struct CardViewPr: View {
    let location: Location
    
    var body: some View {
        ZStack{
            Color("neutral200")
            HStack{
                AsyncImage(url: URL(string: location.imageKota)) { Image in
                    Image
                        .resizable()
                    
                } placeholder: {
                    ShimmerView()
                }
                .frame(width: 172, height: 186)
                .overlay{
                    VStack {
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.clear)
                                .frame(height: 75)
                                .background(Color(red: 0.04, green: 0.17, blue: 0.2).opacity(0.6))
                                .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft]))
                            
                            Text(location.namaProvinsi)
                                .foregroundColor(Color.white)
                                .font(.system(size: 20 , weight:.bold, design: .rounded ))
                                
                               

                            
                        }
                    }
                }
                
                Spacer()
                
                VStack{
                    NavigationLink(destination: TravelPlannerView()) {
                        Text("Add trip")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 44)
                            .background(Color("green600"))
                            .cornerRadius(12)
                    }
    
    
                    NavigationLink {
                        TripCardScreen(location: location)
                    } label: {
                        Text("See more")
                            .foregroundColor(Color("green600"))
                            .frame(width: 150, height: 44)
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color("green600"), lineWidth: 1)
                            )
                    }
                }
                
                Spacer()

            }
        }
        .frame(width: .infinity, height: 186)
        .cornerRadius(12)
        .padding()
    }
}



struct MapScreen: View {
    @StateObject private var locationManager = LocationManager()
    @State private var annotations: [MapAnnotationItem] = []
    @State private var selectedAnnotation: MapAnnotationItem? = nil
    //     add this data
    @EnvironmentObject private var modelWisata : TourismViewModel
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
                if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
                    do {
                        let jsonData = try Data(contentsOf: url)
                        let provinces = try JSONDecoder().decode([Location].self, from: jsonData)
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
            .toolbar(.hidden, for: .tabBar)
        }
        
    }
    
    func createAlert(for annotation: MKPointAnnotation) -> Alert {
        let distanceString = distanceFromCurrentLocation(to: annotation.coordinate)
        let alertTitle = annotation.title ?? "Unknown Location"
        let message = "Distance from Current Location: \(distanceString)"
        
        return Alert(title: Text(alertTitle), message: Text(message), dismissButton: .default(Text("OK")))
    }
    //     tambah code ini
    func getLocationObject(for annotation: MKPointAnnotation) -> Location? {
        guard let idString = annotation.title,
              let location = modelWisata.tourisms.first(where: { $0.namaProvinsi == idString }) else {
            // Handle the scenario where the Location object is not found or the idProvinsi is not valid
            return nil
        }
        return location
    }
    
    func createCardView(for annotation: MKPointAnnotation) -> some View {
        let distanceString = distanceFromCurrentLocation(to: annotation.coordinate)
        return Group {
            if let location = getLocationObject(for: annotation) {
                CardViewPr(location: location)
            } else {
                Text("An error occurred")
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
            .environmentObject(TourismViewModel())
    }
}
