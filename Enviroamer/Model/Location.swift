//
//  Location.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import Foundation

import Foundation
import CoreLocation

struct Location : Codable,Identifiable, Hashable {
    
    
    var id : Int?
    var namaProvinsi : String?
    var listWisata : [Tourism]
    var isWishlist : Bool
    var isAddTrip : Bool
    var isFinishTrip : Bool
    var imageKota : String
    var tranportasiProvinsi : [String]
    var kegiatanOffset : [OffsetActivity]
    
    var coordinateKota :  Coordinates
    var locationCoordinate : CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinateKota.latitude,
            longitude: coordinateKota.longitude
        )
    }
    struct Coordinates : Hashable , Codable {
        var latitude : Double
        var longitude : Double
    }
<<<<<<< HEAD
=======
    

>>>>>>> origin/trip-card-screen

}
