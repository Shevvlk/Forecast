
import Foundation

struct СityWeatherHourlyData: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
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
