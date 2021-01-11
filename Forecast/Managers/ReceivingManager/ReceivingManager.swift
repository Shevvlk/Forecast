
import Foundation

protocol ReceivingManagerProtocol {
    func fetchСityWeatherCopy (cityName: String, completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void)
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy]) -> Void)
}

class ReceivingManager: ReceivingManagerProtocol {
    
    private let currentСityWeatherCopyManager = CurrentСityWeatherCopyManager()
    private let dispatchGroup = DispatchGroup()
    private let loadOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    
    func fetchСityWeatherCopy (cityName: String, completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void) {
        
        currentСityWeatherCopyManager.fetchCurrentСityWeatherCopy(cityName: cityName) { (cityWeatherCopy, error) in
            completionHandler(cityWeatherCopy, error)
        }
        
    }
    
    
    func fetchСitiesWeatherCopy (сityWeatherCopyArray: [СityWeatherCopy], completionHandler: @escaping ([СityWeatherCopy]) -> Void) {
        
        var сityWeatherCopyArrayNew: [СityWeatherCopy] = []
        
        for cityWeatherCopy in сityWeatherCopyArray {
            
            let currentСityWeatherCopyManager = CurrentСityWeatherCopyManager()
            
            let loadOperation = LoadOperation(cityName: cityWeatherCopy.cityName, currentСityWeatherCopyManager: currentСityWeatherCopyManager)
            
            dispatchGroup.enter()
            
            loadOperationQueue.addOperation(loadOperation)
            
            loadOperation.completionBlock = { [weak self] in
                guard let currentСityWeatherCopy = loadOperation.cityWeatherCopy
                else {
                    сityWeatherCopyArrayNew.append(cityWeatherCopy)
                    self?.dispatchGroup.leave()
                    return
                }
                сityWeatherCopyArrayNew.append(currentСityWeatherCopy)
                self?.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify( queue: DispatchQueue.main) {
            completionHandler(сityWeatherCopyArrayNew)
        }
    }
}
