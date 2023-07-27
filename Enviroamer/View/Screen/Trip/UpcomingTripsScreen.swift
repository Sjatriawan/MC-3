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

    @EnvironmentObject var travelViewModel : TravelPlannerViewModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: trip.imageKota ?? "")) { phase in
                switch phase {
                case .empty:
                    ShimmerView()
                        .frame(width: 322, height: 230)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 322, height: 230)
                        .scaledToFit()
                    
                case .failure:
                    // Placeholder view for failed loading
                    Color.gray
                @unknown default:
                    // Placeholder view for unknown cases
                    Color.gray
                }
            }
            .cornerRadius(12)
            
            Rectangle()
                .frame(height: 75)
                .foregroundColor(.black)
                .opacity(0.4)
                .blur(radius: 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(trip.provinceName ?? "")")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    Text("\(formattedDate(date: trip.startDate)) - \(formattedDate(date: trip.endDate))")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                Spacer()
                Menu {
                    Button("Delete") {
                        travelViewModel.deleteTrip(trip)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }.padding(.horizontal, 16)
                    .padding(.vertical, 8)
                

            }
        }
        .cornerRadius(12)
        //        .padding(.horizontal, 16)
        .padding(.vertical, 8)
       
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
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text("Create your trip!\nBe mindful to our environment while strolling around.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("black800"))
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                NavigationLink(destination: {
                    TravelPlannerView()
                }, label: {
                    Text("Create a Trip")
                        .foregroundColor(.white)
                        .frame(width: 156, height: 56)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .background(Color("green600"))
                        .cornerRadius(12)
                })
                Spacer()
                Spacer()
                
                
                
            }
        }
    }
}


