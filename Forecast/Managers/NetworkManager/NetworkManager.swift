
import Foundation

class NetworkManager {
    
    private let urlSession = URLSession(configuration: .default)
    
    func fetchRequest (urlString: String, completionHandler: @escaping (Data?, Error?) -> Void)  {
        
        guard let url = URL(string: urlString) else { return completionHandler(nil, NetworkManagerError.errorUrl) }
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(nil, NetworkManagerError.server)
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
            
            completionHandler(data,nil)
        }
        
        task.resume()
    }
}
