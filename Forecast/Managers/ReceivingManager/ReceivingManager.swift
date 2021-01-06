
import Foundation

class ReceivingManager {
    
    let requestСityWeatherManager: CurrentСityWeatherProtocol = CurrentСityWeatherManager()
    
    let dispatchGroup = DispatchGroup()
    
    let loadOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    
    func fetchCurrentСityWeather (forCity city: String, completionHandler: @escaping (CurrentСityWeather?, Error?) -> Void) {
        
        requestСityWeatherManager.fetchCurrentСityWeather(forCity: city) { (currentСityWeather, error) in
            completionHandler(currentСityWeather, error)
        }
        
    }
    
    
    func fetch (cityArray: [CurrentСityWeather], completionHandler: @escaping ([CurrentСityWeather], Error?) -> Void) {
        
        var cityArrayNew: [CurrentСityWeather] = []
        
        for city in cityArray {
            
            let currentСityWeatherManager = CurrentСityWeatherManager()
            
            let loadOperation = LoadOperation(cityName: city.cityName, currentСityWeatherManager: currentСityWeatherManager)
            
            dispatchGroup.enter()
            
            loadOperationQueue.addOperation(loadOperation)
            
            loadOperation.completionBlock = { [weak self] in
                guard let currentСityWeather = loadOperation.currentСityWeather
                else {
                    cityArrayNew.append(city)
                    self?.dispatchGroup.leave()
                    return
                }
                
                cityArrayNew.append(currentСityWeather)
                self?.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify( queue: DispatchQueue.main) {
            completionHandler(cityArrayNew, nil)
        }
    }
}
