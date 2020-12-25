//
//  City+CoreDataProperties.swift
//  Forecast
//
//  Created by Alexandr on 25.12.2020.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var temperature: Double
    @NSManaged public var feelsLikeTemperature: Double
    @NSManaged public var conditionCode: Int16
    @NSManaged public var dt: Date?

}

extension City : Identifiable {

}
