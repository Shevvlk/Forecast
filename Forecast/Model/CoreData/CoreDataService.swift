
import CoreData


final class CoreDataService: NSObject {
    
    private let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "CityWeatherModel")
        persistentContainer.loadPersistentStores(completionHandler: { _, _ in })
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    
    func saveСityWeather(cityWeatherCopy: СityWeatherCopy) {
        let context = backgroundContext
        
        context.perform {
            
            let cityWeather = CityWeather(context: context)
            cityWeather.cityName = cityWeatherCopy.cityName
            cityWeather.temperature = cityWeatherCopy.temperature
            cityWeather.conditionCode = Int16(cityWeatherCopy.conditionCode)
            cityWeather.feelsLikeTemperature = cityWeatherCopy.feelsLike
            cityWeather.date = cityWeatherCopy.date
            cityWeather.all = Int16(cityWeatherCopy.all)
            cityWeather.pressure = Int16(cityWeatherCopy.pressure)
            cityWeather.humidity = Int16(cityWeatherCopy.humidity)
            cityWeather.speed = cityWeatherCopy.speed
            
            do {
                try context.save()
            } catch {
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
            cityWeatherCopyArray = result?.map({ return СityWeatherCopy(cityName: $0.cityName ?? "",
                                                                         temperature: $0.temperature ,
                                                                         feelsLikeTemperature: $0.feelsLikeTemperature,
                                                                         conditionCode: Int($0.conditionCode),
                                                                         date: $0.date ?? Date(),
                                                                         pressure: Int($0.pressure),
                                                                         humidity: Int($0.humidity),
                                                                         all: Int($0.all),
                                                                         speed: $0.speed)}) ?? []
        }
        
        return cityWeatherCopyArray
    }
    
    
    func deleteСityWeather (cityWeatherCopy: СityWeatherCopy) {
        let context = backgroundContext
        
        context.perform {
            let request = NSFetchRequest<CityWeather>(entityName: "CityWeather")
            request.predicate = NSPredicate(format: "ANY cityName = %@", cityWeatherCopy.cityName)
            
            do {
                let result = try context.fetch(request)
                guard let cityWeather = result.first else { return }
                context.delete(cityWeather)
            } catch {
                print(error.localizedDescription)
            }
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func rewritingСitiesWeather (cityWeatherCopyArray: [СityWeatherCopy]) {
        var result: [CityWeather]?
        let context = backgroundContext
        for currentWeather in cityWeatherCopyArray {
            
            context.perform {
                
                let request = NSFetchRequest<CityWeather>(entityName: "CityWeather")
                request.predicate = NSPredicate(format: "ANY cityName = %@", currentWeather.cityName)
                
                do {
                    result = try context.fetch(request)
                } catch {
                    print(error.localizedDescription)
                }
                
                guard let city = result?.first else { return }
                
                city.cityName = currentWeather.cityName
                city.temperature = currentWeather.temperature
                city.conditionCode = Int16(currentWeather.conditionCode)
                city.feelsLikeTemperature = currentWeather.feelsLike
                city.date = currentWeather.date
                city.all = Int16(currentWeather.all)
                city.pressure = Int16(currentWeather.pressure)
                city.humidity = Int16(currentWeather.humidity)
                city.speed = currentWeather.speed
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

