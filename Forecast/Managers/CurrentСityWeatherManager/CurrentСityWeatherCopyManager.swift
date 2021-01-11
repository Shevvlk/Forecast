
import Foundation

protocol CurrentСityWeatherCopyProtocol {
    func fetchCurrentСityWeatherCopy (cityName city: String, completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void)
}

class CurrentСityWeatherCopyManager: CurrentСityWeatherCopyProtocol {
    
    private  let networkManager = NetworkManager()
    private  let parseManager = ParseManager()
    
    func fetchCurrentСityWeatherCopy (cityName: String, completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
        
        networkManager.fetchRequest(urlString: urlString) { [weak self] (date, error) in
            
            guard let date = date, error == nil else {
                completionHandler(nil,error)
                return
            }
            
            self?.parseManager.parseJSON(data: date, model: СityWeatherData.self) { (data, error) in
                
                guard let cityWeatherData = data, error == nil else {
                    completionHandler(nil,error)
                    return
                }
                
                guard let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData) else {
                    completionHandler(nil,nil)
                    return
                }
                
                completionHandler(cityWeatherCopy,nil)
            }
        }
    }
}
