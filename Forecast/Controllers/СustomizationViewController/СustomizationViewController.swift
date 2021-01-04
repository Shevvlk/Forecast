
import UIKit

class СustomizationViewController: UIViewController {
    
    let сustomizationView = СustomizationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        сustomizationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(сustomizationView)
    
        setupConstraints ()

        
    }
    
    func setupConstraints () {
        сustomizationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        сustomizationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        сustomizationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        сustomizationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
