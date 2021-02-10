
import Foundation

final class NetworkManager {
    
    private let urlSession = URLSession(configuration: .default)
    private let parseManager = ParseManager()
    
    func fetchRequest (coordinate: (Double,Double), completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void)  {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.0)&lon=\(coordinate.1)&appid=\(apiKey)&lang=ru"
        
        guard let url = URL(string: urlString) else { return completionHandler(nil, NetworkManagerError.errorUrl) }
        
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
            
            self?.parseManager.parseJSON(data: data, model: СityWeatherData.self) { (data, error) in
                
                guard let cityWeatherData = data, error == nil else {
                    completionHandler(nil,NetworkManagerError.errorParseJSON)
                    return
                }
                
                guard let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData) else {
                    completionHandler(nil,nil)
                    return
                }
                completionHandler(cityWeatherCopy,nil)
            }
        }
        
        task.resume()
    }
}
