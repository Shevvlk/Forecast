//
//  City+CoreDataProperties.swift
//  Forecast
//
//  Created by Alexandr on 05.01.2021.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var all: Int16
    @NSManaged public var cityName: String?
    @NSManaged public var conditionCode: Int16
    @NSManaged public var date: Date?
    @NSManaged public var feelsLikeTemperature: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var pressure: Int16
    @NSManaged public var speed: Double
    @NSManaged public var temperature: Double

}

extension City : Identifiable {

}
