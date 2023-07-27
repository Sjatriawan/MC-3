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
        NavigationView {
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
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 3.09524, height: 3.09524)
                                .background(Color(red: 0.25, green: 0.55, blue: 0.25))
                                .cornerRadius(3.09524)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3.09524)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.25, green: 0.55, blue: 0.25), lineWidth: 1)
                                )
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 3.09524, height: 3.09524)
                                .background(Color(red: 0.25, green: 0.55, blue: 0.25))
                                .cornerRadius(3.09524)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3.09524)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.25, green: 0.55, blue: 0.25), lineWidth: 1)
                                )
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 3.09524, height: 3.09524)
                                .background(Color(red: 0.25, green: 0.55, blue: 0.25))
                                .cornerRadius(3.09524)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3.09524)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.25, green: 0.55, blue: 0.25), lineWidth: 1)
                                )
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
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10) // Add RoundedRectangle as overlay
                                                    .stroke(index == viewModel.selectedProvinceIndex ? Color("green600") : Color.gray, lineWidth: 2) // Apply different stroke color based on selection
                                            )
                                        
                                        
                                        Text(viewModel.provinces[index].namaProvinsi)
                                            .foregroundColor(index == viewModel.selectedProvinceIndex ? .green : .primary).font(.system(size: 12))
                                        
                                    }
                                }
                            }.padding()
                            
                        }
                    }.frame(height: 120)
                        .blur(radius: !isCalenderExpanded ? 0:5)
                    //
//                    call the extension , buat extension untuk mempermudah aturan viewnya
                    calenderView
                    transportView
                    hotelView
                  
                    Button {
                        viewModel.saveData()
                        dismiss()
                    } label: {
                        HStack(alignment: .center, spacing: 10){
                            Text("Save").foregroundColor(.white)
                        }.padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color(red: 0.25, green: 0.55, blue: 0.25))
                            .cornerRadius(10)
                    }.alert("Data Saved", isPresented: $viewModel.isDataSaved) {
                        Button("Ok") {
                            viewModel.resetIsDataSaved()
                        }
                    }message: {
                         Text("Your data success added in trip screen")
                    }
                    .blur(radius: !isCalenderExpanded ? 0:5)
                    
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
                }
            }) {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                    .frame(width: 324, height: 51, alignment: .leading)
                    .overlay(
                        VStack{
                            HStack{
                                Text("When")
                                Spacer()
                                Text("\(formatteDate(viewModel.startDate)) - \(formatteDate(viewModel.endDate))")
                            }
                            
                        }.padding()
                        
                    )
            }
            .contentShape(Rectangle())
            .blur(radius: !isCalenderExpanded ? 0:0)
            
            
            if isCalenderExpanded {
                VStack(alignment: .leading){
                    CustomRangeDatePicker(startDate: $viewModel.startDate, endDate: $viewModel.endDate)
                }.blur(radius: !isCalenderExpanded ? 0:0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
    }
    
    private var transportView : some View {
        VStack{
            Button(action: {
                withAnimation {
                    isTransportExpanded.toggle()
                }
            }) {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                    .frame(width: 324, height: 51, alignment: .leading)
                    .overlay(
                        VStack{
                            HStack{
                                Text("How will you get there?")
                                Spacer()
                                Text("\(viewModel.transportationMethod)")
                            }
                            
                        }.padding()
                        
                    )
            }
            .contentShape(Rectangle())
            .blur(radius: !isCalenderExpanded ? 0:5)
            
            if isTransportExpanded {
                LazyVGrid(columns: gridLayouta, spacing: 0) {
                    ForEach(TransportationMethod.allCases) { method in
                        Button(action: {
                            viewModel.transportationMethod = method.rawValue
                        }) {
                            HStack {
                                Text(method.rawValue)
                                    .frame(width: 90, height: 40, alignment: .leading).padding(.leading)
                                    .foregroundColor(viewModel.transportationMethod == method.rawValue ? .white : .green)
                                    .background(
                                        ZStack {
                                            if viewModel.transportationMethod != method.rawValue {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.green, lineWidth: 2) // Add outline border when not selected
                                            }
                                        }
                                    )
                                    .background(viewModel.transportationMethod == method.rawValue ? Color.green : Color.clear)
                                    .cornerRadius(12)
                                
                            }.padding(.bottom)
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
                }
            }) {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                    .frame(width: 324, height: 51, alignment: .leading)
                    .overlay(
                        VStack{
                            HStack{
                                Text("Hotel star rating")
                                Spacer()
                                Text("\(viewModel.hotelStarRating)")
                            }
                            
                        }.padding()
                        
                    )
            }
            .contentShape(Rectangle())
            .blur(radius: !isCalenderExpanded ? 0:5)
            
            if isHotelExpanded {
                LazyVGrid(columns: gridLayouta, spacing: 0) {
                    ForEach(HotelStarMethod.allCases) { method in
                        Button(action: {
                            viewModel.hotelStarRating = method.rawValue
                        }) {
                            HStack {
                                Text(method.rawValue)
                                    .frame(width: 90, height: 40, alignment: .leading).padding(.leading)
                                    .foregroundColor(viewModel.hotelStarRating == method.rawValue ? .white : .green)
                                    .background(
                                        ZStack {
                                            if viewModel.hotelStarRating != method.rawValue {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.green, lineWidth: 2) // Add outline border when not selected
                                            }
                                        }
                                    )
                                    .background(viewModel.hotelStarRating == method.rawValue ? Color.green : Color.clear)
                                    .cornerRadius(12)
                                
                            }.padding(.bottom)
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
            
            HStack {
                Button("Start Date") {
                    isSelectingStartDate = true
                }
                .padding()
                .foregroundColor(isSelectingStartDate ? .white : .green)
                .background(isSelectingStartDate ? Color.green : Color.clear)
                .cornerRadius(42)
                Spacer()
                Button("End Date") {
                    isSelectingStartDate = false
                }
                .padding()
                .foregroundColor(isSelectingStartDate ? .green : .white)
                .background(isSelectingStartDate ? Color.clear : Color.green)
                .cornerRadius(42)
            }
            .padding(.top, 8)
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
}


enum HotelStarMethod: String, CaseIterable, Identifiable {
    case tri = "3 stars"
    case four = "4 stars"
    case five = "5 stars"
    
    
    var id: String { rawValue }
}
