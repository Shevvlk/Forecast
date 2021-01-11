
import Foundation

/// Сборщик List контроллера
final class ListViewControllerAssembly {
    func createViewController(viewControllerFirst:DetailsViewController) -> ListViewController {
        
        let coreDataService = CoreDataService()
        let customizationOfDataDisplay = CustomizationOfDataDisplay()
        let receivingManager = ReceivingManager()
        
        let listViewController = ListViewController(receivingManager: receivingManager,
                                                    customizationOfDataDisplay: customizationOfDataDisplay,
                                                    coreDataService: coreDataService,
                                                    viewControllerFirst: viewControllerFirst)
        
        return listViewController
    }
}
