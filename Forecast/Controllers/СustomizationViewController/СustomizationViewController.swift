
import UIKit

class СustomizationViewController: UIViewController {
    
    let сustomizationView = СustomizationView()
    let customizationOfDataDisplay = CustomizationOfDataDisplay ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true

        view = сustomizationView
        
        сustomizationView.delegateView = self
    }
}


extension СustomizationViewController: SelectedValueViewDelegate {
    
    func selectedValueTemperature(target: UISegmentedControl) {
        switch target.selectedSegmentIndex {
        case 0:
            customizationOfDataDisplay.key = .temperature
            customizationOfDataDisplay.save(element: "C")
        case 1:
            customizationOfDataDisplay.key = .temperature
            customizationOfDataDisplay.save(element: "F")

        case 2:
            customizationOfDataDisplay.key = .temperature
            customizationOfDataDisplay.save(element: "K")
        default:
            break
        }
        print(target.selectedSegmentIndex)
        print("selectedValueTemperature")
    }
    
    func selectedValueWindSpeed(target: UISegmentedControl) {
//        switch target.selectedSegmentIndex {
//        case 0:
//            customizationOfDataDisplay.key = .windSpeed
//            customizationOfDataDisplay.save(element: "км/ч")
//        case 1:
//            customizationOfDataDisplay.key = .windSpeed
//            customizationOfDataDisplay.save(element: "миль/ч")
//
//        case 2:
//            customizationOfDataDisplay.key = .windSpeed
//            customizationOfDataDisplay.save(element: "м/с")
//        case 3:
//            customizationOfDataDisplay.key = .windSpeed
//            customizationOfDataDisplay.save(element: "Узел")
//        default:
//            break
//        }
        print(target.selectedSegmentIndex)
        print("selectedValueWindSpeed")
    }
    
    func selectedValuePressure(target: UISegmentedControl) {
//        switch target.selectedSegmentIndex {
//        case 0:
//            customizationOfDataDisplay.key = .pressure
//            customizationOfDataDisplay.save(element: "гПа")
//        case 1:
//            customizationOfDataDisplay.key = .pressure
//            customizationOfDataDisplay.save(element: "Дюймы")
//
//        case 2:
//            customizationOfDataDisplay.key = .pressure
//            customizationOfDataDisplay.save(element: "кПа")
//        case 3:
//            customizationOfDataDisplay.key = .pressure
//            customizationOfDataDisplay.save(element: "мм")
//        default:
//            break
//        }
        print(target.selectedSegmentIndex)
        print("selectedValuePressure")
    }
    
    func selectedValuePrecipitation(target: UISegmentedControl) {
//        switch target.selectedSegmentIndex {
//        case 0:
//            customizationOfDataDisplay.key = .precipitation
//            customizationOfDataDisplay.save(element: "Миллиметры")
//        case 1:
//            customizationOfDataDisplay.key = .pressure
//            customizationOfDataDisplay.save(element: "Дюймы")
//        default:
//            break
//        }
        print(target.selectedSegmentIndex)
        print("selectedValuePrecipitation")
    }
    
    func selectedValueDistance(target: UISegmentedControl) {
        
    }
    
    
}
