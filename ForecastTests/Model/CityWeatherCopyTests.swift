

import XCTest

@testable import Forecast

class CityWeatherCopyTests: XCTestCase {
    
    var coord: Coord!
    var main: Main!
    var wind: Wind!
    var weather: Weather!
    var clouds: Clouds!
    var hourly: Hourly!
    
    var cityWeatherData: СityWeatherData!
    var cityWeatherHourlyData: СityWeatherHourlyData!
    
    override func setUp() {
        super.setUp()
        
        coord = Coord(lat: 55.558741, lon: 37.378847)
        main = Main(temp: 4, feelsLike: 4, pressure: 1030, humidity: 80)
        wind = Wind(speed: 7)
        weather = Weather(id: 500, description: "ясно")
        clouds = Clouds(all: 0)
        hourly = Hourly(dt: Date(timeIntervalSinceReferenceDate: 10000), temp: 4, weather: [weather])
        
        cityWeatherData = СityWeatherData(name: "Moscow", coord: coord, main: main, wind: wind, weather: [weather], clouds: clouds, dt: Date())
        cityWeatherHourlyData = СityWeatherHourlyData(lat: 55.558741, lon: 37.378847, hourly: [hourly])
        
    }
    
    override func tearDown() {
        coord = nil
        main = nil
        wind = nil
        weather = nil
        clouds = nil
        hourly = nil
        cityWeatherData = nil
        cityWeatherHourlyData = nil
        
        super.tearDown()
    }
    
    
    func testInitCityWeatherCopy() {
        
        var cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)
        
        XCTAssertNotNil(cityWeatherCopy)
        XCTAssertEqual(cityWeatherCopy?.latitude, cityWeatherData.coord.lat)
        XCTAssertEqual(cityWeatherCopy?.longitude, cityWeatherData.coord.lon)
        XCTAssertEqual(cityWeatherCopy?.cityWeatherHourlyСopies.count, 1)
        XCTAssertEqual(cityWeatherCopy?.cityWeatherHourlyСopies[0].id, 500)
        XCTAssertEqual(cityWeatherCopy?.cityWeatherHourlyСopies[0].date, Date(timeIntervalSinceReferenceDate: 10000))
        XCTAssertEqual(cityWeatherCopy?.cityWeatherHourlyСopies[0].tempKelvin, 4)
        
        weather = Weather(id: nil, description: "ясно")
        
        cityWeatherData = СityWeatherData(name: "Moscow", coord: coord, main: main, wind: wind, weather: [weather], clouds: clouds, dt: Date())
        
        cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)
        
        XCTAssertNil(cityWeatherCopy)
        
        
        cityWeatherCopy = СityWeatherCopy(cityName: "Moscow", temperature: 4, feelsLikeTemperature: 4, conditionCode: 300, date: Date(), pressure: 1030, humidity: 80, all: 0, speed: 4, latitude: 55.558741, longitude: 37.378847, description: "Ясно", cityWeatherHourlyArray: [СityWeatherHourlyCopy(date: Date(), tempKelvin: 273, id: 300)])
        
        XCTAssertNotNil(cityWeatherCopy)
    }
    
    func testReceivingTemperatureСelsiusAndKelvinAndFahrenheit() {
        
        var cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)!
        
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: nil), "-269 °C")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "C"), "-269 °C")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "F"), "-451 °F")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "K"), "4 K")
        
        main = Main(temp: 278, feelsLike: 278, pressure: 1030, humidity: 80)
        cityWeatherData = СityWeatherData(name: "Moscow", coord: coord, main: main, wind: wind, weather: [weather], clouds: clouds, dt: Date())
        
        cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)!
        
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: nil), "+5 °C")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "C"), "+5 °C")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "F"), "+41 °F")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "K"), "278 K")
    }
    
    func testReceivingFeelsLikeСelsiusAndKelvinAndFahrenheit() {
        
        var cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)!
        
        XCTAssertEqual(cityWeatherCopy.getFeelsLike(unit: nil), "-269 °C")
        XCTAssertEqual(cityWeatherCopy.getFeelsLike(unit: "C"), "-269 °C")
        XCTAssertEqual(cityWeatherCopy.getFeelsLike(unit: "F"), "-451 °F")
        XCTAssertEqual(cityWeatherCopy.getFeelsLike(unit: "K"), "4 K")
        
        main = Main(temp: 278, feelsLike: 278, pressure: 1030, humidity: 80)
        cityWeatherData = СityWeatherData(name: "Moscow", coord: coord, main: main, wind: wind, weather: [weather], clouds: clouds, dt: Date())
        
        cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)!
        
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: nil), "+5 °C")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "C"), "+5 °C")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "F"), "+41 °F")
        XCTAssertEqual(cityWeatherCopy.getTemperature(unit: "K"), "278 K")
    }
    
    func testReceivingSpeedKmAndMilieAndKnAndMC() {
        
        let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)!
        
        XCTAssertEqual(cityWeatherCopy.getSpeed(unit: "km"), "25.2 км/ч")
        XCTAssertEqual(cityWeatherCopy.getSpeed(unit: "milie"), "15.7 миль/ч")
        XCTAssertEqual(cityWeatherCopy.getSpeed(unit: "kn"), "13.6 узел")
        XCTAssertEqual(cityWeatherCopy.getSpeed(unit: nil), "7.0 м/с")
    }
    
    func testReceivingPressureMmAndInchAndHPaAndKPa() {
        
        let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)!
        
        XCTAssertEqual(cityWeatherCopy.getPressure(unit: "mm"), "772.6 мм рт.ст.")
        XCTAssertEqual(cityWeatherCopy.getPressure(unit: "inch"), "30.4 дюйм")
        XCTAssertEqual(cityWeatherCopy.getPressure(unit: "kPa"), "103.0 кПа")
        XCTAssertEqual(cityWeatherCopy.getPressure(unit: nil), "1030 гПа")
    }
    
}
