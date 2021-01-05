
import Foundation

struct CurrentСityWeather {
    
    /// Название города
    let cityName: String
    /// Температура Кельвин
    let temperature: Double
    /// Температура.Этот температурный параметр объясняет человеческое восприятие погоды. Кельвин
    let feelsLikeTemperature: Double
    /// Идентификатор погодных условий
    let conditionCode: Int
    /// Время расчета данных, unix, UTC
    let date: Date
    /// Атмосферное давление гПа
    let pressure: Int
    /// Влажность %
    let humidity: Int
    /// Облачность %
    let all: Int
    /// Скорость ветра м/с
    let speed: Double
    
    var dtString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd, HH:mm")
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    
    var temperatureСelsius: String {
        let temp = Int(temperature.rounded()) - 273
        if temp > 0 {
            return "+\(temp)°C"
        } else {
            return "\(temp)°C"
        }
    }
    
    var temperatureKelvin: String {
        let temp = Int(temperature.rounded())
            return "\(temp)K"
    }
    
    var temperatureFahrenheit: String {
        let temp = Int(temperature * 1.8 - 459)
        if temp > 0 {
            return "+\(temp)°F"
        } else {
            return "\(temp)°F"
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
    
    init?(currentWeatherData: CurrentСityWeatherData) {
        self.cityName = currentWeatherData.name
        self.temperature = currentWeatherData.main.temp
        self.feelsLikeTemperature = currentWeatherData.main.feelsLike
        self.conditionCode = currentWeatherData.weather.first!.id
        self.date = currentWeatherData.dt
        self.pressure = currentWeatherData.main.pressure
        self.humidity = currentWeatherData.main.humidity
        self.all = currentWeatherData.clouds.all
        self.speed = currentWeatherData.wind.speed
    }
    
    init(cityName: String, temperature: Double, feelsLikeTemperature: Double, conditionCode: Int, date: Date, pressure: Int, humidity: Int, all: Int,speed: Double) {
        self.cityName = cityName
        self.temperature = temperature
        self.feelsLikeTemperature = feelsLikeTemperature
        self.conditionCode = conditionCode
        self.date = date
        self.pressure = pressure
        self.humidity = humidity
        self.all = all
        self.speed = speed
    }
    
}
