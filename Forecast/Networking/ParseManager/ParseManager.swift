
import Foundation

protocol ParseManagerProtocol {
    func parseJSON<T: Decodable> (data: Data) -> Result<T, Error> 
}

struct ParseManager: ParseManagerProtocol {
    
    private let decoder = JSONDecoder()
    
    func parseJSON<T: Decodable> (data: Data) -> Result<T, Error> {
        
        do {
            let model = try decoder.decode(T.self, from: data)
            return .success(model)
        } catch {
            return .failure(NetworkManagerError.errorParseJSON)
        }
    }
}
