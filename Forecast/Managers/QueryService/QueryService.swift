
import Foundation

protocol ReceivingManagerProtocol {
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy]) -> Void)
    func fetchСityWeatherCopy (coordinate: (Double,Double), completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void) 
}

class QueryService {
    
    private let loadOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    private let networkManagerCW = NetworkManager(resource: СityWeatherResource())
    private let networkManagerCWH = NetworkManager(resource: СityWeatherHourlyResource())
    private var cityWeatherData: СityWeatherData?
    private var cityWeatherHourlyData: СityWeatherHourlyData?
    
    
    func fetchСityWeatherCopy (coordinate: (Double,Double),  completionHandler: @escaping (СityWeatherCopy?, NetworkManagerError?) -> Void) {
        
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
        
        cityWeatherData = nil
        cityWeatherHourlyData = nil
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManagerCW.fetchRequest(coordinates: coordinate) { [weak self] (modelCW, error) in
            if let cityWeatherData = modelCW {
                self?.cityWeatherData = cityWeatherData
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManagerCWH.fetchRequest(coordinates: coordinate) { [weak self] (modelCWH, error) in
            
            if let cityWeatherHourlyData = modelCWH {
                self?.cityWeatherHourlyData = cityWeatherHourlyData
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global()) { [weak self] in
            if let cityWeatherData = self?.cityWeatherData, let cityWeatherHourlyData = self?.cityWeatherHourlyData{
                let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)
                completionHandler(cityWeatherCopy,nil)
            }
            else {
                completionHandler(nil, NetworkManagerError.errorServer)
            }
        }
    }
    
    
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy]) -> Void) {
        
        if loadOperationQueue.operationCount > 0 {
            return
        }
        
        var сityWeatherCopyArrayNew: [СityWeatherCopy] = []
        
        for cityWeatherCopy in сityWeatherCopyArray {
            
            let loadOperation = LoadOperation(coordinate: (cityWeatherCopy.latitude, cityWeatherCopy.longitude))
            
            loadOperation.completionBlock = { [weak loadOperation] in
                if let currentСityWeatherCopy = loadOperation?.cityWeatherCopy {
                    
                    сityWeatherCopyArrayNew.append(currentСityWeatherCopy)
                }
                else {
                    сityWeatherCopyArrayNew.append(cityWeatherCopy)
                }
            }
            loadOperationQueue.addOperation(loadOperation)
        }
        
        loadOperationQueue.addOperation {
            DispatchQueue.main.async {
                if сityWeatherCopyArrayNew.count == сityWeatherCopyArray.count {
                    completionHandler(сityWeatherCopyArrayNew)
                } else {
                    print("Нет")
                }
            }
        }
        
        print(loadOperationQueue.operationCount)
    }
}
