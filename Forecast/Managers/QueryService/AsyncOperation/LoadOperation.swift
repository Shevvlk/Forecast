
import Foundation


final class LoadOperation: AsyncOperation {

    let coordinate: (Double,Double)
    var cityWeatherCopy: СityWeatherCopy?
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
        networkManagerCW.fetchRequest(coordinates: coordinate) { (model, error) in
            if let model = model {
                cityWeatherData = model
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManagerCWH.fetchRequest(coordinates: coordinate) {(model, error) in

            if let model = model {
                cityWeatherHourlyData = model
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: DispatchQueue.global()) { [weak self] in
            if let cityWeatherData = cityWeatherData, let cityWeatherHourlyData = cityWeatherHourlyData{
                let cityWeatherCopy = СityWeatherCopy(cityWeatherData: cityWeatherData, cityWeatherHourlyData: cityWeatherHourlyData)
                self?.cityWeatherCopy = cityWeatherCopy
                self?.state = .finished
            }
            else {
                self?.state = .finished
            }
        }
        
        
        
        
//        
//        networkManager?.fetchRequest(coordinate: coordinate) { [weak self] (cityWeatherCopy, error) in
//            if error == nil {
//                self?.cityWeatherCopy = cityWeatherCopy
//                self?.state = .finished
//            } else {
//                self?.cityWeatherCopy = nil
//                self?.state = .finished
//                print(error as! NetworkManagerError)
//            }
//        }
    }
}
