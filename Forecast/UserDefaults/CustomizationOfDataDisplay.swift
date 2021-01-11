
import Foundation

/// Класс для сохранения, получения и удаления параметров
class CustomizationOfDataDisplay: UserDefaultsProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    /// Перечисление сохраняемых параметров
    enum Parameter: String {
        case cityName
        case temperature
        case speed
        case pressure
        case all
    }
    
    var key: Parameter?
    
    func save (element: String) {
        
        guard let key = key else { return }
        
        userDefaults.set(element, forKey: key.rawValue)
    }
    
    func get () -> String? {
        
        guard let key = key else { return nil }
        
        let cityName = userDefaults.string(forKey: key.rawValue)
        return cityName
    }
    
    func remove() {
        
        guard let key = key else { return }
        
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
