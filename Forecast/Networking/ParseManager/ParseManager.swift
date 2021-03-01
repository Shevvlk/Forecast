
import Foundation

class ParseManager {
    
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