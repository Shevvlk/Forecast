
import Foundation

/// Почасовой прогноз
struct СityWeatherHourlyData: Decodable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int16
    let hourly: [Hourly]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case hourly
    }
}

struct Hourly: Codable {
    let dt: Date
    let temp: Double
    let weather: [Weather]
}
