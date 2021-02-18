
import Foundation

class ParseManager {
    
    private let decoder = JSONDecoder()
    
    func parseJSON<T:Codable> (data: Data, model: T.Type, completionHandler: @escaping (T?, Error?) -> Void) {
        
        do {
            let currentWeatherData = try decoder.decode(model, from: data)
            completionHandler(currentWeatherData,nil)
        } catch {
            completionHandler(nil,error)
        }
    }
    
    
}
