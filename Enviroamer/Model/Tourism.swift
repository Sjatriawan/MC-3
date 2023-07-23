//
//  Tourism.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import Foundation

import Foundation
import CoreLocation

struct Tourism : Codable, Identifiable, Hashable {


    var id : Int?
    var nama : String?
    var isWishlistDestination : Bool
    var lokasi : String?
    var waktuOperasional : String?
<<<<<<< HEAD
    var deskripsi : String?
    var image : [String]?
    var kegiatan : [String]
    var transportasiWisata : [String]
=======
    var deskripsiSingkat : String?
    var deskripsi :[ String]
    var image : [String]?
    var judulKegiatan : [String]
    var kegiatan : [String]
    var transportasiWisata : [String]
    var timeToDestination : [String]
    var kotaPusat : String
>>>>>>> origin/trip-card-screen
    
    var coordinateWisata :  Coordinates
    var locationCoordinate : CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinateWisata.latitude,
            longitude: coordinateWisata.longitude
        )
    }
    struct Coordinates : Hashable, Codable {
        var latitude : Double
        var longitude : Double
    }
}
