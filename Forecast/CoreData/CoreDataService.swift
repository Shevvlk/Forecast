
import CoreData


final class CoreDataService: NSObject {
    
    private let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "Weather")
        persistentContainer.loadPersistentStores(completionHandler: { _, _ in })
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func saveCity(currentWeather: CurrentWeather) {
        let context = backgroundContext
        context.perform {
            let city = City(context: context)
            city.cityName = currentWeather.cityName
            city.temperature = currentWeather.temperature
            city.conditionCode = Int16(currentWeather.conditionCode)
            city.feelsLikeTemperature = currentWeather.feelsLikeTemperature
            city.dt = currentWeather.dt
            try? context.save()
        }
    }
    
    func getCity() -> [CurrentWeather] {
        let context = persistentContainer.viewContext
        var models: [CurrentWeather] = []
        context.performAndWait {
            let request = NSFetchRequest<City>(entityName: "City")
            let result = try? context.fetch(request)
            models = result?.map({ return CurrentWeather(cityName: $0.cityName ?? "", temperature: $0.temperature ,feelsLikeTemperature: $0.feelsLikeTemperature , conditionCode: Int($0.conditionCode), dt: $0.dt ?? Date())}) ?? []
        }
        return models
    }
    
    func deleteCity (currentWeather: CurrentWeather) {
        let context = backgroundContext
        context.perform {
            let request = NSFetchRequest<City>(entityName: "City")

            request.predicate = NSPredicate(format: "ANY cityName = %@", currentWeather.cityName)
            
            let result = try! context.fetch(request)
            context.delete(result.first!)
            
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    
    func rewritingCity (currentWeather: CurrentWeather) {
//        let context = backgroundContext
//        let request = NSFetchRequest<City>(entityName: "City")
//
//        request.predicate = NSPredicate(format: "ANY cityName = %@", currentWeather.cityName)
//        
//        context.perform {
//            let city = City(context: context)
//            city.cityName = currentWeather.cityName
//            city.temperature = currentWeather.temperature
//            city.conditionCode = Int16(currentWeather.conditionCode)
//            city.feelsLikeTemperature = currentWeather.feelsLikeTemperature
//            city.dt = currentWeather.dt
//            try? context.save()
//        }
    }
    
    
    
}

