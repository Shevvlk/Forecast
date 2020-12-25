

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    let feelsLikeTemperature: Double
    let conditionCode: Int
    let dt: Date
    
    var dtString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd, HH:mm")
        let localDate = dateFormatter.string(from: dt)
        return localDate
    }
    
    
    var temperatureString: String {
        if Int(temperature.rounded()) - 273 > 0 {
            return "+\(Int(temperature.rounded()) - 273)°"
        } else {
            return "\(Int(temperature.rounded()) - 273)°"
        }
    }
    
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
  
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        self.cityName = currentWeatherData.name
        self.temperature = currentWeatherData.main.temp
        self.feelsLikeTemperature = currentWeatherData.main.feelsLike
        self.conditionCode = currentWeatherData.weather.first!.id
        self.dt = currentWeatherData.dt
    }
    
    init(cityName: String, temperature: Double, feelsLikeTemperature: Double, conditionCode: Int, dt: Date ) {
        self.cityName = cityName
        self.temperature = temperature
        self.feelsLikeTemperature = feelsLikeTemperature
        self.conditionCode = conditionCode
        self.dt = dt
    }
    
}
