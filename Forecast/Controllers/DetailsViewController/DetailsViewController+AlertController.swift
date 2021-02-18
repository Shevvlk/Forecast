
import UIKit

extension DetailsViewController {
    
    func presentErrorAlert() {
        let alertController = UIAlertController(title:"Ошибка передачи данных", message: "Проверьте подключение к сотовой сети или Wi-Fi для доступа к данным", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        let settings = UIAlertAction(title: "Настройки", style: .default) { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        
        alertController.addAction(settings)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}

