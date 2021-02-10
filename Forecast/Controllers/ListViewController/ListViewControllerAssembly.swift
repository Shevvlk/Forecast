
import Foundation

/// Сборщик List контроллера
final class ListViewControllerAssembly {
    private let coreDataService: CoreDataService
    private let userDefaultsManager: UserDefaultsManager<String>
    
    init(coreDataService: CoreDataService,usDefMDataDisplay: UserDefaultsManager<String> ) {
        self.coreDataService = coreDataService
        self.userDefaultsManager = usDefMDataDisplay
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

