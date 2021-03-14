
import Foundation

/// Текущий прогноз погоды
struct СityWeatherData: Codable, Equatable {
    
    /// Название города
    let name: String
    let coord: Coord
    let main: Main
    let wind: Wind
    let weather: [Weather]
    let clouds: Clouds
    /// Время расчета данных, unix, UTC
    let dt: Date
    
}

struct Main: Codable, Equatable {
    /// Температура Кельвин
    let temp: Double
    /// Температура. Этот температурный параметр объясняет человеческое восприятие погоды. Кельвин
    let feelsLike: Double
    /// Атмосферное давление  гПа
    let pressure: Int16
    /// Влажность %
    let humidity: Int16
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure 
        case humidity
    }
}

struct Clouds: Codable, Equatable {
    /// Облачность %
    let all: Int16
}

struct Wind: Codable, Equatable {
    /// Скорость ветра метр/сек
    let speed: Double
}

struct Weather: Codable, Equatable {
    /// Идентификатор погодных условий
    let id: Int16?
    /// Описание погодных условий
    let description: String
}

/// Координаты 
struct Coord: Codable, Equatable {
    var lat, lon: Double
}
