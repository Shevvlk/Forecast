import Foundation

class NetworkManagerCityWeather {
        
    func fetchCurrentWeatherManager (forCity city: String, completionHandler: @escaping (CurrentСityWeather) -> Void)  {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url =  URL(string: urlString) else {return}
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) { (data, Response, error) in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                completionHandler(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    
    func parseJSON (withData data: Data) -> CurrentСityWeather?  {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(CurrentСityWeatherData.self , from: data)
            guard let currentWeather = CurrentСityWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
}
