 
import UIKit
 
 class TapBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailsViewController = DetailsViewController()
        let listViewController = UINavigationController(rootViewController: ListViewController()) 
        let customizationViewController = UINavigationController(rootViewController: СustomizationViewController())
       
        let thermometerImage = UIImage(systemName: "thermometer")
        let globeImage = UIImage(systemName: "globe")
        let gearImage = UIImage(systemName: "gear")
               
        let thermometerTabBarItem = UITabBarItem(title: "Погода", image: thermometerImage, tag: 0)
        let globeTabBarItem = UITabBarItem(title: "Города", image: globeImage, tag: 1)
        let gearTabBarItem = UITabBarItem(title: "Настройки", image: gearImage, tag: 2)
        
                
        detailsViewController.tabBarItem = thermometerTabBarItem
        listViewController.tabBarItem = globeTabBarItem
        customizationViewController.tabBarItem = gearTabBarItem
        let tabBarList = [detailsViewController, listViewController, customizationViewController]

        viewControllers = tabBarList
        
///      Отображение первого контроллера при запуске приложения
        selectedViewController = detailsViewController
    }
 }
