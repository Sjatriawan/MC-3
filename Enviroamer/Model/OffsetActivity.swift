//
//  OffsetActivity.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import Foundation

struct OffsetActivity  : Codable , Hashable ,Identifiable {
    var id : Int?
    var namaAktivitas : String?
    var company : String?
<<<<<<< HEAD
    var deskripsiKegiatan : String?
=======
    var deskripsiKegiatan : [String]
>>>>>>> origin/trip-card-screen
    var fotoKegiatan : String?
    var alamat : String?
    var noTelp : String?
    var email : String?
    var website : String?
    var instagram : String?
}
