
import Foundation

/// Сборщик List контроллера
final class ListViewControllerAssembly {
    private let coreDataService: CoreDataService

    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }

    func createViewController(viewControllerFirst:DetailsViewController) -> ListViewController {
        
        let customizationOfDataDisplay = CustomizationOfDataDisplay()
        let receivingManager = ReceivingManager()
        
        let listViewController = ListViewController(receivingManager: receivingManager,
                                                    customizationOfDataDisplay: customizationOfDataDisplay,
                                                    coreDataService: coreDataService,
                                                    viewControllerFirst: viewControllerFirst)
        
        return listViewController
    }
}

