
import Foundation

struct Сity {
    
    /// Название города
    let cityName: String
    /// Температура Кельвин
    let temperature: Double
    /// Температура.Этот температурный параметр объясняет человеческое восприятие погоды. Кельвин
    let feelsLike: Double
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
        let temp = Int(temperature - 273)
        if temp > 0 {
            return "+\(temp) °C"
        } else {
            return "\(temp) °C"
        }
    }
    
    var temperatureKelvin: String {
        let temp = Int(temperature)
        return "\(temp) K"
    }
    
    var temperatureFahrenheit: String {
        let temp = Int((temperature * 1.8 - 459))
        if temp > 0 {
            return "+\(temp) °F"
        } else {
            return "\(temp) °F"
        }
    }
    
    var feelsLikeTemperatureСelsius: String {
        let temp = Int(feelsLike - 273 )
        if temp > 0 {
            return "+\(temp) °C"
        } else {
            return "\(temp) °C"
        }
    }
    
    var feelsLikeTemperatureKelvin: String {
        let temp = Int(feelsLike)
        return "\(temp) K"
    }
    
    var feelsLikeTemperatureFahrenheit: String {
        let temp = Int(feelsLike * 1.8 - 459)
        if temp > 0 {
            return "+\(temp) °F"
        } else {
            return "\(temp) °F"
        }
    }
    
    var pressurehPa: String {
        return "\(pressure) hPa"
    }
    
    var pressurekPa: String {
        let pressureDouble = Double(pressure)/10
        let pressureString = String(format: "%.1f", pressureDouble)
        return "\(pressureString) kPa"
    }
    
    var pressureMM: String {
        let pressureDouble = Double(pressure) * 0.750063755419211
        let pressureString = String(format: "%.1f", pressureDouble)
        return "\(pressureString) mm"
    }
    
    var pressureInch: String {
        let pressureDouble = Double(pressure) * 0.02953
        let pressureString = String(format: "%.1f", pressureDouble)
        return "\(pressureString) inch"
    }
    
    var speedKM: String {
        let speedDouble = speed * 3.6
        let speedString = String(format: "%.1f", speedDouble)
        return "\(speedString) km/h"
    }
    
    var speedM: String {
        let speedString = String(format: "%.1f", speed)
        return "\(speedString) m/c"
    }
    
    var speedMilie: String {
        let speedDouble = speed * 2.24
        let speedString = String(format: "%.1f", speedDouble)
        return "\(speedString) milie/h"
    }
    
    var speedKn: String {
        let speedDouble = speed * 1.94
        let speedString = String(format: "%.1f", speedDouble)
        return "\(speedString) kn"
    }
    
    var allString: String {
        return "\(all) %"
    }
    
    var humidityString : String {
        return "\(humidity) %"
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
    
    init?(currentWeatherData: СityData) {
        self.cityName = currentWeatherData.name
        self.temperature = currentWeatherData.main.temp
        self.feelsLike = currentWeatherData.main.feelsLike
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
        self.feelsLike = feelsLikeTemperature
        self.conditionCode = conditionCode
        self.date = date
        self.pressure = pressure
        self.humidity = humidity
        self.all = all
        self.speed = speed
    }
    
}
