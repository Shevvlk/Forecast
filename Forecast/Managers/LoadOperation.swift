
import Foundation


class LoadOperation: CustomAsyncOperation {
    
    let cityName: String
    let requestСityWeatherManager = RequestСityWeatherManager()
    var currentСityWeather: CurrentСityWeather?
    
    
    init(cityName: String)   {
        self.cityName = cityName
        super.init()
    }
    
    override func main() {
        requestСityWeatherManager.fetchCurrentСityWeather(forCity: cityName) { [weak self] (currentСityWeather, error) in
            print("Операция завершена")
            if error == nil {
                self?.currentСityWeather = currentСityWeather
                self?.state = .finished
             }
     }
    }
}
