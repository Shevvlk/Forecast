
import Foundation


final class LoadOperation: AsyncOperation {
    
    let cityName: String
    let currentСityWeatherCopyManager: CurrentСityWeatherCopyProtocol?
    var cityWeatherCopy: СityWeatherCopy?
    
    
    init(cityName: String, currentСityWeatherCopyManager: CurrentСityWeatherCopyProtocol)   {
        self.cityName = cityName
        self.currentСityWeatherCopyManager = currentСityWeatherCopyManager
        super.init()
    }
    
    override func main() {
        currentСityWeatherCopyManager?.fetchCurrentСityWeatherCopy(cityName: cityName) { [weak self] (currentСityWeatherCopy, error) in
            if error == nil {
                self?.cityWeatherCopy = currentСityWeatherCopy
                self?.state = .finished
            } else {
                self?.cityWeatherCopy = nil
                self?.state = .finished
                print(error?.localizedDescription)
            }
        }
    }
}
