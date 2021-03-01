
import UIKit

extension ListViewController {
    
    func presentErrorAlert(error: Error) {
        
        var errorTitle = ""
        var errorMessage = "Повторите запрос"
        
        let error = error as? NetworkManagerError
        
        switch error {
        case .errorStatusCode:
            errorTitle = "Ошибка при получении данных c сервера"
        case .errorServer:
            errorTitle = "Ошибка при получении данных c сервера"
            errorMessage = "Проверьте подключение к сотовой сети или Wi-Fi для доступа к данным"
        case .errorParseJSON:
            errorTitle = "Ошибка сериализации данных"
        case .errorMimeType:
            errorTitle = "Сервер вернул неподдерживаемый тип данных"
        case .errorUrl:
            errorTitle = "Запрос не может быть принят сервером"
        default:
            return
        }
        
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        
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
    
    func notUpdatedСitiesAlert (cities: [String]) {
        
        let cities = cities.joined(separator: ", ")
        
        let title = " Грод(а) \(cities) не обновлены"

        let alertController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        
        present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            alertController.dismiss(animated: true, completion: nil)
        }
        
    }
}

