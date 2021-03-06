
import Foundation

protocol QueryServiceProtocol {
    func fetchСityWeatherCopy (coordinate: (Double,Double),  completionHandler: @escaping (Result<СityWeatherCopy, Error>) -> Void)
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy],[String]) -> Void)
}

final class QueryService {
    
    private let networkManagerCW = NetworkManager(resource: СityWeatherResource())
    private let networkManagerCWH = NetworkManager(resource: СityWeatherHourlyResource())
    
    private let loadOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
}


extension QueryService: QueryServiceProtocol {
    
    func fetchСityWeatherCopy (coordinate: (Double,Double),  completionHandler: @escaping (Result<СityWeatherCopy, Error>) -> Void) {
        
        networkManagerCW.urlSession.getAllTasks { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
        
        networkManagerCWH.urlSession.getAllTasks { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
        
        var cityWeatherDataResult: Result<СityWeatherData, Error>?
        var cityWeatherHourlyDataResult: Result<СityWeatherHourlyData, Error>?
        
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManagerCW.fetchRequest(coordinates: coordinate) { result in
            
            cityWeatherDataResult = result
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManagerCWH.fetchRequest(coordinates: coordinate) { result in
            
            cityWeatherHourlyDataResult = result
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global()) {
            
            do {
                let cityWeatherData = try cityWeatherDataResult?.get()
                let cityWeatherHourlyData = try cityWeatherHourlyDataResult?.get()
                
                if let cityWeatherData = cityWeatherData, let cityWeatherHourlyData = cityWeatherHourlyData,  let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)
                {
                    completionHandler(.success(cityWeatherCopy))
                    
                } else {
                    completionHandler(.failure(NetworkManagerError.errorParseJSON))
                }
                
            } catch {
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
    
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy],[String]) -> Void) {
        
        if loadOperationQueue.operationCount > 0 {
            return
        }
        
        var сityWeatherCopyArrayNew: [СityWeatherCopy] = []
        var notUpdatedСities: [String] = []
        
        
        for cityWeatherCopy in сityWeatherCopyArray {
            
            let loadOperation = LoadOperation(coordinate: (cityWeatherCopy.latitude, cityWeatherCopy.longitude))
            
            loadOperation.completionBlock = { [weak loadOperation] in
                if let currentСityWeatherCopy = loadOperation?.cityWeatherCopy {
                    сityWeatherCopyArrayNew.append(currentСityWeatherCopy)
                }
                else {
                    сityWeatherCopyArrayNew.append(cityWeatherCopy)
                    notUpdatedСities.append(cityWeatherCopy.cityName)
                }
            }
            
            loadOperationQueue.addOperation(loadOperation)
        }
        
        loadOperationQueue.addOperation {
            DispatchQueue.main.async {
                if сityWeatherCopyArrayNew.count == сityWeatherCopyArray.count {
                    completionHandler(сityWeatherCopyArrayNew, notUpdatedСities)
                }
            }
        }
    }
    
}
