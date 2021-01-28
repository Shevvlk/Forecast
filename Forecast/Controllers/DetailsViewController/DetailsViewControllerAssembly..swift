
import Foundation

/// Сборщик Details контроллера
final class DetailsViewControllerAssembly {
    private let coreDataService: CoreDataService

    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }

    func createViewController() -> DetailsViewController {
        
        let customizationOfDataDisplay = CustomizationOfDataDisplay()
        let receivingManager = ReceivingManager()
        
        let detailsViewController = DetailsViewController(receivingManager: receivingManager,
                                                          customizationOfDataDisplay: customizationOfDataDisplay,
                                                          coreDataService: coreDataService)
        
        return detailsViewController
    }
}
