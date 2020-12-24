

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        if  Int(temperature.rounded()) - 273 > 0 {
            return "+\(Int(temperature.rounded()) - 273)°"
        } else {
            return "\(Int(temperature.rounded()) - 273)°"
        }
    }
    
    let feelsLikeTemperature: Double
    
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    let conditionCode: Int
    
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
    }
    
    init(cityName: String, temperature: Double, feelsLikeTemperature: Double, conditionCode: Int ) {
        self.cityName = cityName
        self.temperature = temperature
        self.feelsLikeTemperature = feelsLikeTemperature
        self.conditionCode = conditionCode
    }
    
}
