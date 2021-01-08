
import Foundation


final class LoadOperation: AsyncOperation {
    
    let cityName: String
    let requestСityWeatherManager: CurrentСityWeatherProtocol?
    var currentСityWeather: Сity?
    var error: Error?
    
    
    init(cityName: String, currentСityWeatherManager: CurrentСityWeatherProtocol)   {
        self.cityName = cityName
        self.requestСityWeatherManager = currentСityWeatherManager
        super.init()
    }
    
    override func main() {
        requestСityWeatherManager?.fetchCurrentСityWeather(forCity: cityName) { [weak self] (currentСityWeather, error) in
            if error == nil {
                self?.currentСityWeather = currentСityWeather
                self?.state = .finished
            } else {
                self?.currentСityWeather = nil
                self?.state = .finished
                self?.error = error
            }
        }
    }
}
