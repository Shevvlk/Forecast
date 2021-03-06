 
 import UIKit
 
 class TapBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreDataService = CoreDataService()
        
        let userDefaultsManager = UserDefaultsManager()
        
        let detailsViewControllerAssembly = DetailsViewControllerAssembly(coreDataService: coreDataService, userDefaultsManager: userDefaultsManager)
        let detailsViewController = detailsViewControllerAssembly.createViewController()
        
        let listViewControllerAssembly = ListViewControllerAssembly(coreDataService: coreDataService, userDefaultsManager: userDefaultsManager)
        let listViewController = listViewControllerAssembly.createViewController(viewControllerFirst: detailsViewController)
        
        let navigationControllerRootList = UINavigationController(rootViewController: listViewController)
        let customizationViewController = UINavigationController(rootViewController: SettingsViewController(userDefaultsManager: userDefaultsManager))
        
        let thermometerImage = UIImage(systemName: "thermometer")
        let globeImage = UIImage(systemName: "globe")
        let gearImage = UIImage(systemName: "gear")
        
        let thermometerTabBarItem = UITabBarItem(title: "Погода", image: thermometerImage, tag: 0)
        let globeTabBarItem = UITabBarItem(title: "Города", image: globeImage, tag: 1)
        let gearTabBarItem = UITabBarItem(title: "Настройки", image: gearImage, tag: 2)
        
        detailsViewController.tabBarItem = thermometerTabBarItem
        listViewController.tabBarItem = globeTabBarItem
        customizationViewController.tabBarItem = gearTabBarItem
        
        let tabBarList = [detailsViewController, navigationControllerRootList, customizationViewController]
        
        viewControllers = tabBarList
    }
 }
