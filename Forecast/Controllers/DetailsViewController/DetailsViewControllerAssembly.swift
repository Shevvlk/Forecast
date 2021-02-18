
import Foundation

/// Сборщик Details контроллера
final class DetailsViewControllerAssembly {
    private let coreDataService: CoreDataService
    private let usDefMDataDisplay: UserDefaultsManager<String>
    private let usDefMСoordinates: UserDefaultsManager<[String:Double]>
    
    init(coreDataService: CoreDataService,usDefMDataDisplay: UserDefaultsManager<String>, usDefMСoordinates: UserDefaultsManager<[String:Double]>) {
        self.coreDataService = coreDataService
        self.usDefMDataDisplay = usDefMDataDisplay
        self.usDefMСoordinates = usDefMСoordinates
    }
    
    func createViewController() -> DetailsViewController {
        
        let queryService = QueryService()
        
        let detailsViewController = DetailsViewController(queryService: queryService,
                                                            usDefMDataDisplay: usDefMDataDisplay,
                                                            usDefMСoordinates: usDefMСoordinates,
                                                            coreDataService: coreDataService)
        
        return detailsViewController
    }
    
}
