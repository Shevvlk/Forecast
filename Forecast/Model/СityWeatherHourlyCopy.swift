
import Foundation

struct СityWeatherHourly {
    let dt: Date
    let temperature: Double
    let id: Int
    let timezoneOffset: Int

    var systemIconNameString: String {
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
    
    init(dt: Date, temp: Double, id: Int, timezoneOffset: Int) {
        self.dt = dt
        self.temperature = temp
        self.id = id
        self.timezoneOffset = timezoneOffset
    }
    
}
