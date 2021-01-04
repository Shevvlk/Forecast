
import Foundation

protocol ReceivingManagerProtocol: class {
    func fetchCurrentWeatherManager (forCity city: String, completionHandler: @escaping (CurrentСityWeather?, Error?) -> Void)
}

class ReceivingManager {
    
    let requestСityWeatherManager = RequestСityWeatherManager()

    
    func fetchCurrentСityWeather (forCity city: String, completionHandler: @escaping (CurrentСityWeather?, Error?) -> Void) {
        
        requestСityWeatherManager.fetchCurrentСityWeather(forCity: city) { (currentСityWeather, error) in
            completionHandler(currentСityWeather, error)
        }
        
    }
    
    
    
    func fetch (cityArray: [CurrentСityWeather], completionHandler: @escaping ([CurrentСityWeather], Error?) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var cityArrayNew: [CurrentСityWeather] = []
        let loadQueue = OperationQueue()
        
        loadQueue.maxConcurrentOperationCount = 1
        
        for city in cityArray {
            
            let loadOperation = LoadOperation(cityName: city.cityName)
            dispatchGroup.enter()
            loadQueue.addOperation(loadOperation)
            loadOperation.completionBlock = {
                guard let currentСityWeather = loadOperation.currentСityWeather
                else {
                    return
                }
                cityArrayNew.append(currentСityWeather)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify( queue: DispatchQueue.main) {
            completionHandler(cityArrayNew, nil)
        }
    }
}
