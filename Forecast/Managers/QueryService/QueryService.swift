
import Foundation

protocol ReceivingManagerProtocol {
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy]) -> Void)
    func fetchСityWeatherCopy (coordinate: (Double,Double), completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void) 
}

class QueryService: ReceivingManagerProtocol {
    
    private  let networkManager = NetworkManager()
    
    private let loadOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    func fetchСityWeatherCopy (coordinate: (Double,Double), completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void) {
        
        networkManager.fetchRequest(coordinate: coordinate) { (cityWeatherCopy, error) in
            completionHandler(cityWeatherCopy,error)
        }
    }
    
    
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy]) -> Void) {
        
        var сityWeatherCopyArrayNew: [СityWeatherCopy] = []
        
        for cityWeatherCopy in сityWeatherCopyArray {
            
            let networkManager = NetworkManager()
            
            let loadOperation = LoadOperation(coordinate: (cityWeatherCopy.latitude, cityWeatherCopy.longitude), networkManager: networkManager)
            
            loadOperation.completionBlock = { [weak loadOperation] in
                guard let currentСityWeatherCopy = loadOperation?.cityWeatherCopy
                else {
                    сityWeatherCopyArrayNew.append(cityWeatherCopy)
                    return
                }
                сityWeatherCopyArrayNew.append(currentСityWeatherCopy)
            }
            loadOperationQueue.addOperation(loadOperation)
        }
        
        loadOperationQueue.addOperation {
            DispatchQueue.main.async {
                completionHandler(сityWeatherCopyArrayNew)
            }
        }
    }
}
