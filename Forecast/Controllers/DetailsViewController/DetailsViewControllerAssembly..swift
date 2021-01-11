
import UIKit

/// Сборщик Details контроллера
final class DetailsViewControllerAssembly {
    func createViewController() -> DetailsViewController {
        
        let coreDataService = CoreDataService()
        let customizationOfDataDisplay = CustomizationOfDataDisplay()
        let receivingManager = ReceivingManager()
       
        let detailsViewController = DetailsViewController(receivingManager: receivingManager,
                                                          customizationOfDataDisplay: customizationOfDataDisplay,
                                                          coreDataService: coreDataService)
        
        return detailsViewController
    } 
}
