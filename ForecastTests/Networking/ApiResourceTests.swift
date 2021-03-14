
import XCTest

@testable import Forecast

class ApiResourceTests: XCTestCase {
    
    var cityWeatherResource: СityWeatherResource!
    var cityWeatherHourlyResource: СityWeatherHourlyResource!
    
    override func setUp() {
        super.setUp()
        cityWeatherResource = СityWeatherResource()
        cityWeatherHourlyResource = СityWeatherHourlyResource()
    }
    
    override func tearDown() {
        cityWeatherResource = nil
        cityWeatherHourlyResource = nil
        super.tearDown()
    }
   
    func testmMethodPath() {
        XCTAssertEqual(cityWeatherResource.methodPath, BasePath.weather.rawValue)
        XCTAssertEqual(cityWeatherHourlyResource.methodPath, BasePath.oneCall.rawValue)
    }
    
    func testmBuildURLCityWeatherResource() {
        
        let receivedUrl = cityWeatherResource.gettingURL(coordinates: (55.558741, 37.378847))
        
        let necessaryUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=55.558741&lon=37.378847&appid=540f8d5d4f28c254980258e02d000adf&lang=ru")
        
        XCTAssertEqual(receivedUrl,necessaryUrl)
    }
    
    func testmBuildURLСityWeatherHourlyResource() {
        
        let receivedUrl = cityWeatherHourlyResource.gettingURL(coordinates: (55.558741, 37.378847))
        
        let necessaryUrl = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.558741&lon=37.378847&exclude=daily,current,minutely,alerts&appid=540f8d5d4f28c254980258e02d000adf&lang=ru")
        
        XCTAssertEqual(receivedUrl,necessaryUrl)
    }
    
    
}
