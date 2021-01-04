
import Foundation

class RequestСityWeatherManager {
    
    let networkManager = NetworkManager()
    let parseManager = ParseManager()
    
    func fetchCurrentСityWeather (forCity city: String, completionHandler: @escaping (CurrentСityWeather?, Error?) -> Void) {
        
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        networkManager.fetchRequest(urlString: urlString) { [weak self] (date, error) in
           
            guard let date = date, error == nil else {
                completionHandler(nil,error)
                return
            }
            self?.parseManager.parseJSON(data: date, model: CurrentСityWeatherData.self) { (data, error) in
                
                guard let currentСityWeatherData = data, error == nil else {
                    completionHandler(nil,error)
                    return
                }
                
                guard let currentWeather = CurrentСityWeather(currentWeatherData: currentСityWeatherData) else {
                    completionHandler(nil,nil)
                    return
                }
                
                completionHandler(currentWeather,nil)
            }
        }
    }
}
