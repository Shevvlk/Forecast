
import UIKit

extension DetailsViewController {
    func presentNetworkFailureAlert() {
        let alertController = UIAlertController(title:"Sing cellular data transfer", message: "Check your cellular or Wi-Fi data connection to access data", preferredStyle: .alert)
        
        let search = UIAlertAction(title: "Settings", style: .default) { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(search)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}

