
import CoreData


final class CoreDataService: NSObject {
    
    let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "Weather")
        persistentContainer.loadPersistentStores(completionHandler: { _, _ in })
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func saveCity(currentWeather: CurrentСityWeather) {
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
    
    func getCity() -> [CurrentСityWeather] {
        let context = persistentContainer.viewContext
        var models: [CurrentСityWeather] = []
        context.performAndWait {
            let request = NSFetchRequest<City>(entityName: "City")
            let result = try? context.fetch(request)
            models = result?.map({ return CurrentСityWeather(cityName: $0.cityName ?? "", temperature: $0.temperature ,feelsLikeTemperature: $0.feelsLikeTemperature , conditionCode: Int($0.conditionCode), dt: $0.dt ?? Date())}) ?? []
        }
        return models
    }
    
    func deleteCity (currentWeather: CurrentСityWeather) {
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
    
    
    func rewriting (currentWeatherArray:[CurrentСityWeather]) {
        let context = backgroundContext
        for currentWeather in currentWeatherArray {
            context.perform {
                let request = NSFetchRequest<City>(entityName: "City")
                request.predicate = NSPredicate(format: "ANY cityName = %@", currentWeather.cityName)
                let result = try! context.fetch(request)
                let city = result.first!
                
                city.cityName = currentWeather.cityName
                city.temperature = currentWeather.temperature
                city.conditionCode = Int16(currentWeather.conditionCode)
                city.feelsLikeTemperature = currentWeather.feelsLikeTemperature
                city.dt = currentWeather.dt
                try? context.save()
            }
        }
        
    }
    
    
    
}

