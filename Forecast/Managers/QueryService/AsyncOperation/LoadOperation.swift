
import Foundation


final class LoadOperation: AsyncOperation {

    let coordinate: (Double,Double)
    let networkManager: NetworkManager?
    var cityWeatherCopy: СityWeatherCopy?
    
    
    init(coordinate: (Double, Double), networkManager: NetworkManager)   {
        self.networkManager = networkManager
        self.coordinate.0 = coordinate.0
        self.coordinate.1 = coordinate.1
        super.init()
    }
    
    override func main() {
        networkManager?.fetchRequest(coordinate: coordinate) { [weak self] (cityWeatherCopy, error) in
            if error == nil {
                self?.cityWeatherCopy = cityWeatherCopy
                self?.state = .finished
            } else {
                self?.cityWeatherCopy = nil
                self?.state = .finished
                print(error as! NetworkManagerError)
            }
        }
    }
}
