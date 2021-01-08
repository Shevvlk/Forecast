
import CoreData


final class CoreDataService: NSObject {
    
    let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "Weather")
        persistentContainer.loadPersistentStores(completionHandler: { _, _ in })
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func saveCity(currentWeather: Сity) {
        let context = backgroundContext
        context.perform {
            let city = City(context: context)
            city.cityName = currentWeather.cityName
            city.temperature = currentWeather.temperature
            city.conditionCode = Int16(currentWeather.conditionCode)
            city.feelsLikeTemperature = currentWeather.feelsLike
            city.date = currentWeather.date
            city.all = Int16(currentWeather.all)
            city.pressure = Int16(currentWeather.pressure)
            city.humidity = Int16(currentWeather.humidity)
            city.speed = currentWeather.speed
            try? context.save()
        }
    }
    
    func getСities() -> [Сity] {
        let context = persistentContainer.viewContext
        var models: [Сity] = []
        context.performAndWait {
            let request = NSFetchRequest<City>(entityName: "City")
            let result = try? context.fetch(request)
            models = result?.map({ return Сity(cityName: $0.cityName ?? "",
                                                              temperature: $0.temperature ,
                                                              feelsLikeTemperature: $0.feelsLikeTemperature,
                                                              conditionCode: Int($0.conditionCode),
                                                              date: $0.date ?? Date(),
                                                              pressure: Int($0.pressure),
                                                              humidity: Int($0.humidity),
                                                              all: Int($0.all),
                                                              speed: $0.speed)}) ?? []
        }
        return models
    }
    
    func deleteCity (currentWeather: Сity) {
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
    
    
    func rewriting (currentWeatherArray: [Сity]) {
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
                city.feelsLikeTemperature = currentWeather.feelsLike
                city.date = currentWeather.date
                city.all = Int16(currentWeather.all)
                city.pressure = Int16(currentWeather.pressure)
                city.humidity = Int16(currentWeather.humidity)
                city.speed = currentWeather.speed
               
                try? context.save()
            }
        }
        
    }
    
    
    
}

