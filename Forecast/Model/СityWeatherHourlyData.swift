
import Foundation

/// Почасовой прогноз
struct СityWeatherHourlyData: Decodable, Equatable {
    /// Координаты
    let lat, lon: Double
    let hourly: [Hourly]

    enum CodingKeys: String, CodingKey {
        case lat, lon
        case hourly
    }
}

struct Hourly: Decodable, Equatable {
    /// Дата
    let dt: Date
    /// Температура
    let temp: Double
    let weather: [Weather]
}
