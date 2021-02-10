
import Foundation

/// Класс для сохранения, получения и удаления параметров
class UserDefaultsManager<T> {

    private let userDefaults = UserDefaults.standard
    
    func save (_ value: T, key: UDParameter ) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func get (key: UDParameter) -> T? {
        let value = userDefaults.object(forKey: key.rawValue)
        return value as? T
    }
    
    func remove(key: UDParameter) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
