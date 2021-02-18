
import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func fetchRequest (coordinates: (Double,Double), completionHandler : @escaping (ModelType?, NetworkManagerError?) -> Void)
}

final class NetworkManager<Resource: ApiResource>  {
    var urlSession = URLSession(configuration: .default)
    private let parseManager = ParseManager()
    
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension NetworkManager: NetworkRequest {
    
    func fetchRequest (coordinates: (Double,Double), completionHandler: @escaping (Resource.ModelType?, NetworkManagerError?) -> Void) {
        
        var urlResource = resource.gettingURL(coordinates: coordinates)
        
        guard let url = urlResource else { return completionHandler(nil, NetworkManagerError.errorUrl) }
        
        let task = urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard error == nil, let data = data  else {
                completionHandler(nil, NetworkManagerError.errorServer)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(nil, NetworkManagerError.errorStatusCode)
                return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                completionHandler(nil, NetworkManagerError.errorMimeType)
                return
            }
            
            self?.parseManager.parseJSON(data: data, model: Resource.ModelType.self) { (data, error) in
                
                guard let cityWeatherData = data, error == nil else {
                    completionHandler(nil,NetworkManagerError.errorParseJSON)
                    return
                }
                
                completionHandler(cityWeatherData,nil)
            }
        }
        
        task.resume()
    }
}


