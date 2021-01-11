 
 import UIKit
 
 class TapBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailsViewControllerAssembly = DetailsViewControllerAssembly()
        let detailsViewController = detailsViewControllerAssembly.createViewController()
        
        let listViewControllerAssembly = ListViewControllerAssembly()
        let listViewController = listViewControllerAssembly.createViewController(viewControllerFirst: detailsViewController)
        
        let navigationControllerRootList = UINavigationController(rootViewController: listViewController)
        let customizationViewController = UINavigationController(rootViewController: СustomizationViewController())
        
        let thermometerImage = UIImage(systemName: "thermometer")
        let globeImage = UIImage(systemName: "globe")
        let gearImage = UIImage(systemName: "gear")
        
        let thermometerTabBarItem = UITabBarItem(title: "Weather", image: thermometerImage, tag: 0)
        let globeTabBarItem = UITabBarItem(title: "City", image: globeImage, tag: 1)
        let gearTabBarItem = UITabBarItem(title: "Settings", image: gearImage, tag: 2)
        
        detailsViewController.tabBarItem = thermometerTabBarItem
        listViewController.tabBarItem = globeTabBarItem
        customizationViewController.tabBarItem = gearTabBarItem
        
        let tabBarList = [detailsViewController, navigationControllerRootList, customizationViewController]
        
        viewControllers = tabBarList
        
        ///      Отображение первого контроллера при запуске приложения
        selectedViewController = detailsViewController
    }
 }
