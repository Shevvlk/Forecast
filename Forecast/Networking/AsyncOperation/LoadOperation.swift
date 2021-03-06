
import Foundation


final class LoadOperation: AsyncOperation {
    
    var cityWeatherCopy: СityWeatherCopy?
    
    private let coordinate: (Double,Double)
    private let networkManagerCW = NetworkManager(resource: СityWeatherResource())
    private let networkManagerCWH = NetworkManager(resource: СityWeatherHourlyResource())
    
    init (coordinate: (Double, Double))   {
        self.coordinate.0 = coordinate.0
        self.coordinate.1 = coordinate.1
        super.init()
    }
    
    override func main() {
        
        var cityWeatherData: СityWeatherData?
        var cityWeatherHourlyData: СityWeatherHourlyData?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManagerCW.fetchRequest(coordinates: coordinate) { result in
            
            if let model = try? result.get() {
                cityWeatherData = model
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManagerCWH.fetchRequest(coordinates: coordinate) { result in
            
            if let model = try? result.get() {
                cityWeatherHourlyData = model
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global()) { [weak self] in
            if let cityWeatherData = cityWeatherData, let cityWeatherHourlyData = cityWeatherHourlyData{
                let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)
                self?.cityWeatherCopy = cityWeatherCopy
            }
            self?.state = .finished
        }
    }
    
}
