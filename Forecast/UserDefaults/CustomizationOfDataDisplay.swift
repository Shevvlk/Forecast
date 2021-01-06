
import Foundation

/// Класс для сохранения, получения и удаления выбранных едениц измерения

class CustomizationOfDataDisplay: UserDefaultsProtocol {
    
    /// Перечисление настраиваемых едениц измерения 
    
    enum Parameter: String {
        case temperature
        case windSpeed
        case pressure
        case precipitation
        case distance
    }
   
    var key: Parameter?
    
    func save (element: String) {
        guard let key = key else { return }
        
        UserDefaults.standard.set(element, forKey: key.rawValue)
    }
    
    func get () -> String? {
        guard let key = key else { return nil }
        
        let cityName = UserDefaults.standard.string(forKey: key.rawValue)
        return cityName
    }
    
    func remove() {
        guard let key = key else { return }
        
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
