import Foundation

class NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather)-> Void)?
    
    func fetchCurrentWeatherManager (forCity city: String)  {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url =  URL(string: urlString) else {return}
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) { (data, Response, error) in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON (withData data: Data) -> CurrentWeather?  {
        let decoder = JSONDecoder()
        
        
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self , from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
        
        
    }
}
