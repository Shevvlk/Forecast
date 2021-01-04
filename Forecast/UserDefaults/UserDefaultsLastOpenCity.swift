
import Foundation

/// Класс для сохранения, получения и удаления  последнего просмотренного города

class UserDefaultsLastOpenCity: UserDefaultsProtocol {
   
    let key = "cityName"
    
    func save (element: String) {
        UserDefaults.standard.set(element, forKey: key)
    }
    
    func get () -> String? {
        let cityName = UserDefaults.standard.string(forKey: key)
        return cityName
    }
    
    func remove() {
       UserDefaults.standard.removeObject(forKey: key)
    }
    
}
