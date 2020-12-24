 
import UIKit
 
 class TapBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailsViewController = DetailsViewController()
        let listViewController = UINavigationController(rootViewController: ListViewController()) 
        
       
        let thermometerImage = UIImage(systemName: "thermometer")
        let globeImage = UIImage(systemName: "globe")
               
        let thermometerTabBarItem = UITabBarItem(title: "Weather", image: thermometerImage, tag: 0)
        let globeTabBarItem = UITabBarItem(title: "City", image: globeImage, tag: 1)
        
                
        detailsViewController.tabBarItem = thermometerTabBarItem
        listViewController.tabBarItem = globeTabBarItem

        let tabBarList = [detailsViewController, listViewController]

        viewControllers = tabBarList
    }
 }
