
import XCTest
@testable import Forecast

class NetworkManagerTests: XCTestCase {
    
    var cityWeatherResource: СityWeatherResource!
    var cityWeatherHourlyResource: СityWeatherHourlyResource!
    
    override func setUp()  {
        super.setUp()
        cityWeatherResource = СityWeatherResource()
        cityWeatherHourlyResource = СityWeatherHourlyResource()
    }
    
    override func tearDown() {
        cityWeatherResource = nil
        cityWeatherResource = nil
        super.tearDown()
    }
    
    
    func testPassingURL () {
        
        let urlSessionMock = URLSessionMock(data: nil, error: nil, response: nil)
        
        let networkManagerCW = NetworkManager(resource: cityWeatherResource, urlSession: urlSessionMock)
        networkManagerCW.fetchRequest(coordinates: (5, 6)) { _ in
            
        }
        
        let urlCityWeatherResource = cityWeatherResource.gettingURL(coordinates: (5, 6))
        
        XCTAssertEqual(urlSessionMock.lastURL, urlCityWeatherResource)
        
        let networkManagerCWH = NetworkManager(resource: cityWeatherHourlyResource, urlSession: urlSessionMock)
        networkManagerCWH.fetchRequest(coordinates: (5, 6)) { _ in
            
        }
        
        let urlCityWeatherHourlyResource = cityWeatherHourlyResource.gettingURL(coordinates: (5, 6))
        
        XCTAssertEqual(urlSessionMock.lastURL, urlCityWeatherHourlyResource)
        
    }
    
    func testErrorServer () {
        
        let urlSessionMock = URLSessionMock(data: nil, error: nil, response: nil)
        
        let networkManagerCW = NetworkManager(resource: cityWeatherResource, urlSession: urlSessionMock)
        networkManagerCW.fetchRequest(coordinates: (5, 6)) { result in
            
            do {
                _ = try result.get()
                XCTFail()
            } catch {
                XCTAssertEqual(error as? NetworkManagerError, NetworkManagerError.errorServer)
            }
        }
    }
    
    
}


extension NetworkManagerTests {
    
    class URLSessionDataTaskMock: URLSessionDataTask {
        private let closure: () -> Void
        
        init(closure: @escaping () -> Void) {
            self.closure = closure
        }
        
        override func resume() {
            closure()
        }
    }
    
    class URLSessionMock: URLSession {
        
        let data: Data?
        let error: Error?
        let response: URLResponse?
        
        private (set) var lastURL: URL?
        
        
        init(data: Data?, error: Error?, response: URLResponse?) {
            self.data = data
            self.error = error
            self.response = response
        }
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            lastURL = url
            
            let data = self.data
            let error = self.error
            let response = self.response
            
            return URLSessionDataTaskMock {completionHandler(data, response, error) }
        }
    }
    
}
