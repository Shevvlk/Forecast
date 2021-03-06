
import Foundation

struct СityWeatherCopy {
    /// Название города
    let cityName: String
    /// Широта
    let latitude: Double
    /// Долгота
    let longitude: Double
    /// Температура Кельвин
    let temperature: Double
    /// Температура. Человеческое восприятие погоды. Кельвин
    let feelsLike: Double
    /// Идентификатор погодных условий
    let conditionCode: Int16
    /// Время расчета данных, unix, UTC
    let date: Date
    /// Атмосферное давление гПа
    let pressure: Int16
    /// Влажность %
    let humidity: Int16
    /// Облачность %
    let all: Int16
    /// Скорость ветра м/с
    let speed: Double
    /// Описание
    let description: String
    /// Почасовой прогноз
    let cityWeatherHourlyСopies: [СityWeatherHourlyCopy]
    
    var dtString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd, HH:mm")
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    /// Температура цельсий
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
    
    /// Температура восприятия цельсий
    var feelsLikeTemperatureСelsius: String {
        let temp = Int(feelsLike - 273 )
        if temp > 0 {
            return "+\(temp) °C"
        } else {
            return "\(temp) °C"
        }
    }
    
    /// Температура восприятия кельвин
    var feelsLikeTemperatureKelvin: String {
        let temp = Int(feelsLike)
        return "\(temp) K"
    }
    
    /// Температура восприятия фаренгейт
    var feelsLikeTemperatureFahrenheit: String {
        let temp = Int(feelsLike * 1.8 - 459)
        if temp > 0 {
            return "+\(temp) °F"
        } else {
            return "\(temp) °F"
        }
    }
    
    /// Атмосферное давление гектопаскаль
    var pressurehPa: String {
        return "\(pressure) гПа"
    }
    
    /// Атмосферное давление килопаскаль
    var pressurekPa: String {
        let pressureDouble = Double(pressure)/10
        let pressureString = String(format: "%.1f", pressureDouble)
        return "\(pressureString) кПа"
    }
    
    /// Атмосферное давление  миллиметры ртутного столба
    var pressureMM: String {
        let pressureDouble = Double(pressure) * 0.750063755419211
        let pressureString = String(format: "%.1f", pressureDouble)
        return "\(pressureString) мм рт.ст."
    }
    
    /// Атмосферное давление  дюймы
    var pressureInch: String {
        let pressureDouble = Double(pressure) * 0.02953
        let pressureString = String(format: "%.1f", pressureDouble)
        return "\(pressureString) дюйм"
    }
    
    /// Скорость ветра км/ч
    var speedKM: String {
        let speedDouble = speed * 3.6
        let speedString = String(format: "%.1f", speedDouble)
        return "\(speedString) км/ч"
    }
    
    /// Скорость ветра м/с
    var speedM: String {
        let speedString = String(format: "%.1f", speed)
        return "\(speedString) м/с"
    }
    
    /// Скорость ветра мили/ч
    var speedMilie: String {
        let speedDouble = speed * 2.24
        let speedString = String(format: "%.1f", speedDouble)
        return "\(speedString) миль/ч"
    }
    
    /// Скорость ветра узел
    var speedKn: String {
        let speedDouble = speed * 1.94
        let speedString = String(format: "%.1f", speedDouble)
        return "\(speedString) узел"
    }
    
    /// Облачность %
    var allString: String {
        return "\(all) %"
    }
    
    /// Влажность %
    var humidityString : String {
        return "\(humidity) %"
    }
    
    /// Идентификатор значка погоды
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
    
    func getTemperature (unit: String? ) -> String {
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
    
    func getSpeed (unit: String? ) -> String {
        switch unit {
        case "km":
            return speedKM
        case "milie":
            return speedMilie
        case "kn":
            return speedKn
        default:
            return speedM
        }
    }
    
    func getFeelsLike (unit: String? ) -> String{
        switch unit {
        case "C":
            return feelsLikeTemperatureСelsius
        case "F":
            return feelsLikeTemperatureFahrenheit
        case "K":
            return feelsLikeTemperatureKelvin
        default:
            return feelsLikeTemperatureСelsius
        }
    }
    
    func getPressure (unit: String? ) -> String{
        switch unit {
        case "kPa":
            return pressurekPa
        case "mm":
            return pressureMM
        case "inch":
            return pressureInch
        default:
            return pressurehPa
        }
    }
    
    init?(cityWeatherData: СityWeatherData, cityWeatherHourlyData: СityWeatherHourlyData) {
        
        guard let id = cityWeatherData.weather.first?.id else {
            return nil
        }
        
        self.cityName = cityWeatherData.name
        self.temperature = cityWeatherData.main.temp
        self.feelsLike = cityWeatherData.main.feelsLike
        self.conditionCode = id
        self.date = cityWeatherData.dt
        self.pressure = cityWeatherData.main.pressure
        self.humidity = cityWeatherData.main.humidity
        self.all = cityWeatherData.clouds.all
        self.speed = cityWeatherData.wind.speed
        self.latitude = cityWeatherData.coord.lat
        self.longitude = cityWeatherData.coord.lon
        self.description = cityWeatherData.weather.first?.description ?? ""
        
        var cityWeatherHourlyArray: [СityWeatherHourlyCopy] = []
        
        for hourly in cityWeatherHourlyData.hourly {
            
            let cityWeatherHourly = СityWeatherHourlyCopy(dt: hourly.dt,
                                                           temp: hourly.temp,
                                                           id: hourly.weather.first?.id ?? 0)
            
            cityWeatherHourlyArray.append(cityWeatherHourly)
        }
        
        self.cityWeatherHourlyСopies = cityWeatherHourlyArray
    }
    
    init(cityName:  String,
         temperature: Double,
         feelsLikeTemperature: Double,
         conditionCode: Int16,
         date: Date,
         pressure: Int16,
         humidity: Int16,
         all: Int16,
         speed: Double,
         latitude: Double,
         longitude: Double,
         description: String,
         cityWeatherHourlyArray: [СityWeatherHourlyCopy]) {
        
        self.cityName = cityName
        self.temperature = temperature
        self.feelsLike = feelsLikeTemperature
        self.conditionCode = conditionCode
        self.date = date
        self.pressure = pressure
        self.humidity = humidity
        self.all = all
        self.speed = speed
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
        self.cityWeatherHourlyСopies = cityWeatherHourlyArray
    }
    
}
