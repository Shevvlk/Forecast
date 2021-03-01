import Foundation

struct СityWeatherHourlyCopy {
    let dt: Date
    let temperature: Double
    let id: Int16
    let timezoneOffset: Int16

    var systemIconName: String {
        switch id {
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
    
    var temperatureСelsius: String {
        let temp = Int(temperature - 273)
        if temp > 0 {
            return "+\(temp) °C"
        } else {
            return "\(temp) °C"
        }
    }
    
    /// Температура кельвин
    var temperatureKelvin: String {
        let temp = Int(temperature)
        return "\(temp) K"
    }
    
    /// Температура  фаренгейт
    var temperatureFahrenheit: String {
        let temp = Int((temperature * 1.8 - 459))
        if temp > 0 {
            return "+\(temp) °F"
        } else {
            return "\(temp) °F"
        }
    }
    
    var dtString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH")
        let localDate = dateFormatter.string(from: dt)
        return localDate
    }
    
    func getTemperature (unit: String?) -> String {
        switch unit {
        case "C":
            return temperatureСelsius
        case "F":
            return temperatureFahrenheit
        case "K":
            return temperatureKelvin
        default:
            return temperatureСelsius
        }
    }
    
    init(dt: Date, temp: Double, id: Int16, timezoneOffset: Int16) {
        self.dt = dt
        self.temperature = temp
        self.id = id
        self.timezoneOffset = timezoneOffset
    }
}
