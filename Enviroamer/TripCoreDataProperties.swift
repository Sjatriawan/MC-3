//
//  Trip+CoreDataProperties.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 23/07/23.
//
//

import Foundation
import CoreData


extension Trips {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trips> {
        return NSFetchRequest<Trips>(entityName: "Trip")
    }

    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var transportationMethod: String?
    @NSManaged public var hotelStarRating: String?
    @NSManaged public var distanceToProvince: String?
    @NSManaged public var totalCarbonEmissions: Double
    @NSManaged public var provinceName: String?
    @NSManaged public var imageKota: String?
//    nyoba tambah ini ya

}

extension Trips : Identifiable {

}
