
import CoreData


final class CoreDataService {
    
    private let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CityWeatherModel")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    
    func saveСityWeather(cityWeatherCopy: СityWeatherCopy) {
        let context = backgroundContext
        
        context.perform {
            
            let cityWeather = CityWeather(context: context)
            
            cityWeather.cityName = cityWeatherCopy.cityName
            cityWeather.temperature = cityWeatherCopy.temperature
            cityWeather.conditionCode = cityWeatherCopy.conditionCode
            cityWeather.feelsLikeTemperature = cityWeatherCopy.feelsLike
            cityWeather.date = cityWeatherCopy.date
            cityWeather.all = cityWeatherCopy.all
            cityWeather.pressure = cityWeatherCopy.pressure
            cityWeather.humidity = cityWeatherCopy.humidity
            cityWeather.speed = cityWeatherCopy.speed
            cityWeather.latitude = cityWeatherCopy.latitude
            cityWeather.longitude = cityWeatherCopy.longitude
            cityWeather.descriptionWeather = cityWeatherCopy.description
            
            for cityWeatherHourlyCopy in cityWeatherCopy.cityWeatherHourlyСopies {
                
                let cityWeatherHourly = CityWeatherHourly(context: context)
                
                cityWeatherHourly.id = cityWeatherHourlyCopy.id
                cityWeatherHourly.date = cityWeatherHourlyCopy.dt
                cityWeatherHourly.temperature = cityWeatherHourlyCopy.temperature
                cityWeatherHourly.timezoneOffset = cityWeatherHourlyCopy.timezoneOffset
                
                cityWeather.addToHourly(cityWeatherHourly)
            }
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func getСitiesWeatherCopy() -> [СityWeatherCopy] {
        
        let context = persistentContainer.viewContext
        
        var cityWeatherCopyArray: [СityWeatherCopy] = []
        
        context.performAndWait {
            
            let request = NSFetchRequest<CityWeather>(entityName: "CityWeather")
            
            let result = try? context.fetch(request)
            
            cityWeatherCopyArray = result?.map({ return СityWeatherCopy(cityName: $0.cityName,
                                                                         temperature: $0.temperature,
                                                                         feelsLikeTemperature: $0.feelsLikeTemperature,
                                                                         conditionCode: $0.conditionCode,
                                                                         date: $0.date,
                                                                         pressure: $0.pressure,
                                                                         humidity: $0.humidity,
                                                                         all: $0.all,
                                                                         speed: $0.speed,
                                                                         latitude:  $0.latitude,
                                                                         longitude: $0.longitude, description: $0.description, cityWeatherHourlyArray: $0.hourly.map({ return СityWeatherHourlyCopy(dt: $0.date, temp: $0.temperature, id: $0.id, timezoneOffset: $0.timezoneOffset)
                                                                         }))}) ?? []
        }
        
        return cityWeatherCopyArray
    }
    
    func getСityWeatherCopy (coordinates: (Double,Double)) -> СityWeatherCopy? {
        let context = persistentContainer.viewContext
        
        var cityWeatherCopy: СityWeatherCopy?
        
        context.performAndWait {
            
            let request = NSFetchRequest<CityWeather>(entityName: "CityWeather")
            request.predicate = NSPredicate(format: "latitude = \(coordinates.0) AND longitude = \(coordinates.1)")
            
            let result = try? context.fetch(request)
            
            if let cityWeather = result?.first {
                cityWeatherCopy = СityWeatherCopy(cityName: cityWeather.cityName , temperature: cityWeather.temperature, feelsLikeTemperature: cityWeather.feelsLikeTemperature, conditionCode: cityWeather.conditionCode, date: cityWeather.date , pressure: cityWeather.pressure, humidity: cityWeather.humidity, all: cityWeather.all, speed: cityWeather.speed,latitude: cityWeather.latitude, longitude: cityWeather.longitude, description: cityWeather.descriptionWeather, cityWeatherHourlyArray: cityWeather.hourly.map({ return СityWeatherHourlyCopy(dt: $0.date, temp: $0.temperature, id: $0.id, timezoneOffset: $0.timezoneOffset)
                }) )
                
            } else {
                print("Data request error")
            }
            
            
        }
        
        return cityWeatherCopy
    }
    
    
    func deleteСityWeather (cityWeatherCopy: СityWeatherCopy) {
        let context = backgroundContext
        
        context.perform {
            let request = NSFetchRequest<CityWeather>(entityName: "CityWeather")
            request.predicate = NSPredicate(format: "latitude = \(cityWeatherCopy.latitude) AND longitude = \(cityWeatherCopy.longitude)")
            
            
            if let cityWeather = try? context.fetch(request).first {
                
                context.delete(cityWeather)
                
                do {
                    try context.save()
                } catch let error as NSError  {
                    print(error.localizedDescription)
                }
            } else {
                print("Data deletion error")
            }
        }
    }
    
    
    func rewritingСitiesWeather (cityWeatherCopyArray: [СityWeatherCopy]) {
        
        let context = backgroundContext
        for currentWeather in cityWeatherCopyArray {
            
            context.perform {
                
                let request = NSFetchRequest<CityWeather>(entityName: "CityWeather")
                request.predicate = NSPredicate(format: "latitude = \(currentWeather.latitude) AND longitude = \(currentWeather.longitude)")

                
                if let city = try? context.fetch(request).first {
                    
                    city.cityName = currentWeather.cityName
                    city.temperature = currentWeather.temperature
                    city.conditionCode = currentWeather.conditionCode
                    city.feelsLikeTemperature = currentWeather.feelsLike
                    city.date = currentWeather.date
                    city.all = currentWeather.all
                    city.pressure = currentWeather.pressure
                    city.humidity = currentWeather.humidity
                    city.speed = currentWeather.speed
                    city.latitude = currentWeather.latitude
                    city.longitude = currentWeather.longitude
                    city.descriptionWeather = currentWeather.description
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                } else {
                    print("Data request error")
                }
            }
        }
    }
}

