
import Foundation

/// Протокол определяющий работу с UserDefaults
protocol UserDefaultsProtocol {
    func save (element: String)
    func get () -> String?
    func remove ()
}
