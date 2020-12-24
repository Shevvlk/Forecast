
import CoreData

final class CoreDataService: NSObject {

    private let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
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
            city.conditionCode = Int32(currentWeather.conditionCode)
            city.feelsLikeTemperature = currentWeather.feelsLikeTemperature
            try? context.save()
        }
    }

    func getCity() -> [CurrentWeather] {
        let contex = persistentContainer.viewContext
        var models: [CurrentWeather] = []
        contex.performAndWait {
            let request = NSFetchRequest<City>(entityName: "City")
            let result = try? contex.fetch(request)
            models = result?.map({ return CurrentWeather(cityName: $0.cityName ?? "", temperature: $0.temperature ,feelsLikeTemperature: $0.feelsLikeTemperature , conditionCode: Int($0.conditionCode) )}) ?? []
        }
        return models
    }
    
}

