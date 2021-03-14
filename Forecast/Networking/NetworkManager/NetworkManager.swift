
import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func fetchRequest (coordinates: (Double,Double), completionHandler: @escaping (Result<ModelType, Error>) -> Void)
}

final class NetworkManager<Resource: ApiResource>  {
    
    var urlSession: URLSession
    
    private let parseManager: ParseManagerProtocol?
    private let resource: Resource
    
    init(resource: Resource, urlSession: URLSession = URLSession(configuration: .default), parseManager: ParseManagerProtocol? = ParseManager()) {
        self.resource = resource
        self.urlSession = urlSession
        self.parseManager = parseManager
    }
    
}

extension NetworkManager: NetworkRequest {
    
    func fetchRequest (coordinates: (Double,Double), completionHandler: @escaping (Result<Resource.ModelType, Error>) -> Void) {
        
        let urlResource = resource.gettingURL(coordinates: coordinates)
        
        guard let url = urlResource else {
            return completionHandler(.failure(NetworkManagerError.errorUrl))
        }
        
        let task = urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard error == nil, let data = data  else {
                return completionHandler(.failure(NetworkManagerError.errorServer))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completionHandler(.failure(NetworkManagerError.errorStatusCode))
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                return completionHandler(.failure(NetworkManagerError.errorMimeType))
            }
            
            let resultOptional: Result<Resource.ModelType, Error>? = self?.parseManager?.parseJSON(data: data)
            
            
            guard let result = resultOptional else {
                return completionHandler(.failure(NetworkManagerError.errorInstanceDestroyed))
            }
            
            completionHandler(result)
        }
        
        task.resume()
    }
}


