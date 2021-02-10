
import Foundation

/// Протокол определяющий работу с UserDefaults
protocol UserDefaultsProtocol{
    associatedtype ItemType
    func save (_ element: ItemType, key: ParameterUD)
    func get (key: ParameterUD) -> ItemType?
    func remove(key: ParameterUD)
}
