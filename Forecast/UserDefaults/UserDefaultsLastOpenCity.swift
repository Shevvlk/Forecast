
import Foundation

class LastOpenCity {
    
    let key = "cityName"
    
    func saveLastOpenCityName (currentСityWeather: CurrentСityWeather) {
        let cityName = currentСityWeather.cityName
        UserDefaults.standard.set(cityName, forKey: key)
    }
    
    func getLastOpenCityName () -> String? {
        let cityName = UserDefaults.standard.string(forKey: key)
        return cityName
    }
    
    func remove() {
       UserDefaults.standard.removeObject(forKey: key)
    }
    
}
