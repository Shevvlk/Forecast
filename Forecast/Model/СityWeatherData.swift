
import Foundation

/// Текущий прогноз
struct СityWeatherData: Decodable   {
    
    let name: String
    let coord: Coord
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
    /// Температура. Этот температурный параметр объясняет человеческое восприятие погоды. Кельвин
    let feelsLike: Double
    /// Атмосферное давление  гПа
    let pressure: Int16
    /// Влажность %
    let humidity: Int16
    
    enum CodingKeys: String,CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure 
        case humidity
    }
}

struct Clouds: Codable {
    /// Облачность %
    let all: Int16
}

struct Wind: Codable {
    /// Скорость ветра метр / сек
    let speed: Double
}

struct Weather: Codable {
    /// Идентификатор погодных условий
    let id: Int16
    let description: String
}

/// Координаты 
struct Coord: Codable {
    var lat: Double
    var lon: Double
}
