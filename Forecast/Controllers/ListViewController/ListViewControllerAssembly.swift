
import Foundation

/// Сборщик List контроллера
final class ListViewControllerAssembly {
    private let coreDataService: CoreDataService
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(coreDataService: CoreDataService,userDefaultsManager: UserDefaultsManagerProtocol ) {
        self.coreDataService = coreDataService
        self.userDefaultsManager = userDefaultsManager
    }

    func createViewController(viewControllerFirst: DetailsViewController) -> ListViewController {
        let queryService = QueryService()
        
        let listViewController = ListViewController(queryService: queryService,
                                                    userDefaultsManager: userDefaultsManager,
                                                    coreDataService: coreDataService,
                                                    viewControllerFirst: viewControllerFirst)
        
        return listViewController
    }
}

