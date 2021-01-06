
import Foundation

struct CurrentСityWeatherData: Codable   {
    
    let name:  String
    let main: Main
    let wind: Wind
    let weather: [Weather]
    let clouds: Clouds
    /// Время расчета данных, unix, UTC
    let dt: Date
}

struct Main: Codable {
    /// Температура Кельвин
    let temp: Double
    // Температура.Этот температурный параметр объясняет человеческое восприятие погоды. Кельвин
    let feelsLike: Double
    /// Атмосферное давление  гПа
    let pressure: Int
    /// Влажность %
    let humidity: Int
    
    enum CodingKeys: String,CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure 
        case humidity
    }
}

struct Clouds: Codable {
    /// Облачность %
    let all: Int
}

struct Wind: Codable {
   /// Скорость ветра метр / сек
   let speed: Double
}

struct Weather: Codable {
    /// Идентификатор погодных условий
    let id: Int
}
