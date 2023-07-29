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
//    @StateObject private var viewModel = TravelPlannerViewModel()
    @State private var isCalenderExpanded = false
    @State private var isTransportExpanded = false
    @State private var isHotelExpanded = false
    let image: [String] = ["bali", "ntb","kepri","jabar"]
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var locationDetails: String = ""
    @EnvironmentObject private var viewModel : TravelPlannerViewModel
    @State private var isShowingModal  = false
//    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
   
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    HStack {
                        Text("\((viewModel.totalCarbonEmissions / 1_000_000), specifier: "%.2f") tonsCO₂e")
                            .font(.system(size: 20, weight : .bold , design: .rounded ))
                        
                        Button {
                            isShowingModal.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .font(.system(size: 20))
                                .foregroundColor(Color("green600"))
                        }

                       
                    }
                    
                    VStack(alignment: .leading){
                        HStack{
                            
                            Image("location").frame(width: 20, height: 20).padding(.leading)
                            Text(viewModel.locationDetails)
                                .foregroundColor(Color("green600"))
                        }   .frame(width: 324, height: 51, alignment: .leading)
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color("green600"), lineWidth: 1)
                            )
                        VStack{
//
                        }
                        
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHGrid(rows: gridLayout) {
                            ForEach(viewModel.provinces.indices, id: \.self) { index in
                                Button(action: {
                                    viewModel.selectedProvinceIndex = index
                                }) {
                                    VStack {
                                        Image(image[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                            .opacity(index == viewModel.selectedProvinceIndex ? 1.0 : 0.4) // Set opacity based on selection

                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10) // Add RoundedRectangle as overlay
                                                    .stroke(index == viewModel.selectedProvinceIndex ? Color("green600") : Color.gray, lineWidth: 2) // Apply different stroke color based on selection
                                            )
                                        
                                        
                                        Text(viewModel.provinces[index].namaProvinsi)
                                            .foregroundColor(index == viewModel.selectedProvinceIndex ? Color("green600") : .primary).font(.system(size: 12))
                                        
                                    }
                                }
                            }.padding()
                            
                        }
                    }.frame(height: 120)
                        .blur(radius: !isCalenderExpanded ? 0:5)
                    //
                    calenderView
                    transportView
                    hotelView
                
              
                }
                .sheet(isPresented: $isShowingModal, content: {
                    ModalSheetCarbon()
                        .presentationDetents([.height(200)])
                        .presentationCornerRadius(10)
                })
                .padding()
                .onChange(of: viewModel.locationManager.lastKnownLocation) { newLocation in
                    if let location = newLocation {
                        viewModel.reverseGeocodeLocation(location)
                    }
                }
            }
            Button {
                viewModel.saveData()
            } label: {
                HStack(alignment: .center, spacing: 10){
                    Text("Save").foregroundColor(.white)
                }.padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color("green600"))
                    .cornerRadius(16)
            }.alert("Data Saved", isPresented: $viewModel.isDataSaved) {
                Button("Ok") {
                    viewModel.resetIsDataSaved()
                    dismiss()
                }
            }message: {
                 Text("Your data success added in trip screen")
            }
            .blur(radius: !isCalenderExpanded ? 0:5)
            .frame(width: 330,alignment: .trailing).padding()
           
            
           
        }
        .navigationBarTitle("Plan Your Trip")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .padding()
        
        
        
    }
    
    
    var gridLayout: [GridItem] {
        [GridItem(.flexible())]
    }
    var gridLayouta: [GridItem] {
        [GridItem(.adaptive(minimum: 100), spacing: 10, alignment: .leading)]
    }
    
    private func formatteDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
    
    
    
}

extension TravelPlannerView {
    private var  calenderView : some View {
        VStack{
            Button(action: {
                withAnimation {
                    isCalenderExpanded.toggle()
                    isTransportExpanded = false
                    isHotelExpanded = false
                }
            }) {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                    .frame(height: 51, alignment: .leading)
                    .overlay(
                        VStack{
                            HStack{
                                Text("When")
                                Spacer()
                                Text("\(formatteDate(viewModel.startDate)) - \(formatteDate(viewModel.endDate))")
                            }
                            
                        }.padding(.horizontal)
                        
                    )
            }
            .contentShape(Rectangle())
            .blur(radius: !isCalenderExpanded ? 0:0)
            .padding(.horizontal)
            
            
            if isCalenderExpanded {
                VStack(alignment: .leading){
                    CustomRangeDatePicker(startDate: $viewModel.startDate, endDate: $viewModel.endDate)
                }.blur(radius: !isCalenderExpanded ? 0:0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
    }
    
    private var transportView: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isTransportExpanded.toggle()
                    isHotelExpanded = false
                    isCalenderExpanded = false
                }
            }) {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                    .frame(height: 51, alignment: .leading)
                    .overlay(
                        VStack {
                            HStack {
                                Text("How will you get there?")
                                Spacer()
                                Text("\(viewModel.transportationMethod)")
                            }
                        }.padding(.horizontal)
                    )
            }
            .contentShape(Rectangle())
            .blur(radius: !isCalenderExpanded ? 0 : 5)
            .padding(.horizontal)
            

            if isTransportExpanded {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 0) {
                                    ForEach(TransportationMethod.allCases, id: \.self) { method in
                                        Button(action: {
                                            viewModel.transportationMethod = method.rawValue
                                        }) {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color("green600"), lineWidth: 2)
                                                    .background(viewModel.transportationMethod == method.rawValue ? Color("green600") : Color.clear)
                                                    .cornerRadius(12)

                                                HStack {
                                                    Image(systemName: method.iconName) // Use the associated icon for each item
                                                        .foregroundColor(viewModel.transportationMethod == method.rawValue ? .white : Color("green600"))
                                                        .frame(width: 30, height: 30) // Adjust the size of the icon as needed

                                                    Text(method.rawValue)
                                                        .frame(width: 60, height: 40, alignment: .leading)
                                                        .foregroundColor(viewModel.transportationMethod == method.rawValue ? .white : Color("green600"))
                                                }
                                            }
                                            .padding(.bottom)
                                        }
                                    }
                                }
                                .padding()
            }
        }
    }

    private var hotelView : some View{
        VStack{
            Button(action: {
                withAnimation {
                    isHotelExpanded.toggle()
                    isTransportExpanded = false
                }
            }) {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                    .frame(height: 51, alignment: .leading)
                    .overlay(
                        VStack{
                            HStack{
                                Text("Hotel star rating")
                                Spacer()
                                Text("\(viewModel.hotelStarRating)")
                            }
                            
                        }.padding(.horizontal)
                        
                    )
            }
            .contentShape(Rectangle())
            .blur(radius: !isCalenderExpanded ? 0:5)
            .padding(.horizontal)
            
            if isHotelExpanded {
                LazyVGrid(columns: gridLayouta, spacing: 0) {
                    ForEach(HotelStarMethod.allCases) { method in
                        Button(action: {
                            viewModel.hotelStarRating = method.rawValue
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("green600"), lineWidth: 2)
                                    .background(viewModel.hotelStarRating == method.rawValue ? Color("green600") : Color.clear)
                                
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(viewModel.hotelStarRating == method.rawValue ? .white : Color("green600"))
                                        .frame(width: 20, height: 30)
                                    
                                    Text(method.rawValue)
                                        .foregroundColor(viewModel.hotelStarRating == method.rawValue ? .white : Color("green600"))
                                        .frame(width: 55, height: 30, alignment: .leading)
                                }
                            }
                            .frame(width: 100, height: 40)
                            .cornerRadius(12)
                          
                        
                        }
                    }
                }
                    .padding()
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
            .environmentObject(TravelPlannerViewModel())
    }
}



struct CalendarView: View {
    @Binding var isSelectingStartDate: Bool
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Button("Start Date") {
                    isSelectingStartDate = true
                }
                .frame(height: 10)
                .padding()
                .foregroundColor(isSelectingStartDate ? .white : Color("green600"))
                .background(isSelectingStartDate ? Color("green600") : Color.clear)
                .cornerRadius(42)
                Spacer()
                Text("to")
                Spacer()
                Button("End Date") {
                    isSelectingStartDate = false
                }
                .frame(height: 10)
                .padding()
                .foregroundColor(isSelectingStartDate ? Color("green600") : .white)
                .background(isSelectingStartDate ? Color.clear : Color("green600"))
                .cornerRadius(42)
               
            }
          
            DatePicker("", selection: isSelectingStartDate ? $startDate : $endDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(height: 300)
                .onChange(of: startDate) { newValue in
                    if startDate > endDate {
                        endDate = startDate
                    }
                }
                .onChange(of: endDate) { newValue in
                    if endDate < startDate {
                        startDate = endDate
                    }
                }
            
          
        }
    }
}

struct CustomRangeDatePicker: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @State private var isSelectingStartDate = true
    
    var body: some View {
        VStack {
            CalendarView(isSelectingStartDate: $isSelectingStartDate, startDate: $startDate, endDate: $endDate)
        }
        .padding()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


//Picker transport ViewModel no refactor code yet
enum TransportationMethod: String, CaseIterable, Identifiable {
    case walk = "Walk"
    case bicycle = "Bicycle"
    case bus = "Bus"
    case motorcycle = "Motorcycle"
    case ship = "Ship"
    case plane = "Plane"
    case train = "Train"
    
    var id: String { rawValue }
    
    
    var iconName: String {
        switch self {
        case .walk:
            return "figure.walk"
        case .bicycle:
            return "bicycle"
        case .bus:
            return "bus.fill"
        case .motorcycle:
            return "scooter"
        case .ship:
            return "ferry.fill"
        case .plane:
            return "airplane"
        case .train:
            return "tram.fill"
        }
    }
}


enum HotelStarMethod: String, CaseIterable, Identifiable {
    case tri = "3 stars"
    case four = "4 stars"
    case five = "5 stars"

    var id: String { rawValue }
}



