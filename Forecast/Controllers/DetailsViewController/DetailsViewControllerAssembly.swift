
import Foundation

/// Сборщик Details контроллера
final class DetailsViewControllerAssembly {
    
    private let coreDataService: CoreDataService
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(coreDataService: CoreDataService, userDefaultsManager: UserDefaultsManagerProtocol) {
        self.coreDataService = coreDataService
        self.userDefaultsManager = userDefaultsManager
    }
    
    func createViewController() -> DetailsViewController {
        
        let queryService = QueryService()
        
        let detailsViewController = DetailsViewController(queryService: queryService,
                                                          userDefaultsManager: userDefaultsManager,
                                                            coreDataService: coreDataService)
        
        return detailsViewController
    }
    
}
