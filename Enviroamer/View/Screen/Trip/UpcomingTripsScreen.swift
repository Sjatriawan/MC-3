//
//  UpcomingTripsScreen.swift
//  Enviroamer
//
//  Created by tiyas aria on 23/07/23.
//

import SwiftUI

struct UpcomingTripsScreen: View {
    @State private var upcomingTripsItems : [Trips] = []
    @EnvironmentObject var modelWisata : TourismViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                    TripScreenList()
            }
        }
    }
}

struct TripScreenList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Trip.startDate, ascending: true)],
        animation: .default)
    private var trips: FetchedResults<Trip>

    @EnvironmentObject var modelWisata : TourismViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false){
            if trips.isEmpty {
                EmptyUpcomingTrips()
            } else {
                LazyVStack {
                    ForEach(trips) { trip in
                        NavigationLink(destination: {
                            
                            let location = modelWisata.tourisms.first { location in
                                location.idProvinsi == Int(trip.idProvince)
                            }
                            
                            if let location {
                                TripCardScreen(location: location)
                            } else {
                                Text("Location not found")
                            }
                        }, label: {
                            CardViewList(trip: trip)
                                .frame(width: 322, height: 270)
                        })
                    }
                }
    //            .padding()
            }
        }
    }
}

struct CardViewList: View {
    let trip: Trip
    @State private var image: UIImage? = nil
    @State private var isImageLoaded = false // Track if the image is successfully loaded

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 322, height: 230)
                    .scaledToFit()
                    .cornerRadius(12)
                    .onAppear {
                        isImageLoaded = true // Set the flag to indicate that the image is loaded
                    }
            } else {
                ShimmerView()
                    .frame(width: 322, height: 230)
                    .cornerRadius(12)
            }
            
            if isImageLoaded { // Show the text only when the image is loaded
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(.black)
                    .opacity(0.4)
                    .blur(radius: 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(trip.provinceName ?? "")")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(formattedDate(date: trip.startDate)) - \(formattedDate(date: trip.endDate))")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
        .cornerRadius(12)
        .padding(.vertical, 8)
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let imageURL = URL(string: trip.imageKota ?? "") else { return }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
    
    private func formattedDate(date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
        return ""
    }
}



struct CardScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample Trip for preview
        let trip = Trip(context: PersistenceController.shared.container.viewContext)
        trip.provinceName = "Jawa Barat"
        trip.imageKota = "https://example.com/sample_image.jpg"
        trip.startDate = Date()
        trip.endDate = Date().addingTimeInterval(86400) // Adding one day to the start date

        return CardViewList(trip: trip)
           
    }
}



struct UpcomingTripsScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingTripsScreen()
            .environmentObject(TourismViewModel())
        
    }
}

struct EmptyUpcomingTrips : View {
    var body : some View {
        NavigationStack {
            VStack(spacing: 12){
                Spacer()
                Image("travel-ilutration")
                Text("No trip plan yet")
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Bold", size: 20))
                Text("Create your trip!\nBe mindful to our environment while strolling around.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("black800"))
                    .font(.custom("SFProRounded-Regular", size: 14))
                NavigationLink(destination: {
                    TravelPlannerView()
                }, label: {
                    Text("Create a Trip")
                        .foregroundColor(.white)
                        .frame(width: 156, height: 56)
                        .font(.custom("SFProRounded-Semibold", size: 17))
                        .background(Color("green600"))
                    .cornerRadius(12)
                })
                Spacer()
                Spacer()
                
                
                
            }
        }
    }
}

struct ItemUpcomingTrips : View{
    var location : Location
    
    var body : some View {
        AsyncImage(url: URL(string: location.imageKota)) { Image in
            Image
                .resizable()
            
            
        } placeholder: {
            Image("placeholder")
                .resizable()
            
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 342, height: 205)
        .cornerRadius(12)
        .overlay{
            VStack {
                Spacer()
                ZStack{
                    Rectangle()
                        .frame(width: 342, height: 67)
                        .foregroundColor(Color("neutral200"))
                        .clipShape(CustomCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                    
                    HStack {
                        VStack {
                            Text(location.namaProvinsi)
                                .foregroundColor(Color("black800"))
                                .font(.custom("SFProRounded-Semibold", size: 17))
                            
                            Text("6 Jul - 14 Jul")
                                .foregroundColor(Color("black800"))
                                .font(.custom("SFProRounded-Regular", size: 15))
                            
                        }
                        Spacer()
                        
                        Image("delete")
                    }
                    .padding(.horizontal,24)
                    
                    
                }
            }
        }
    }
}
