
import UIKit

class СustomizationViewController: UIViewController {
    
    private let сustomizationView = СustomizationView()
    private let customizationOfDataDisplay = CustomizationOfDataDisplay ()
    
    override func loadView() {
        view = сustomizationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        сustomizationView.delegateView = self
        installingSegmentedControl()
    }
    
    func installingSegmentedControl() {
        
        customizationOfDataDisplay.key = .temperature
        let temperature = customizationOfDataDisplay.get()
        
        switch temperature {
        case "F":
            сustomizationView.temperatureSegmentedControl.selectedSegmentIndex = 1
        case "K":
            сustomizationView.temperatureSegmentedControl.selectedSegmentIndex = 2
        default:
            сustomizationView.temperatureSegmentedControl.selectedSegmentIndex = 0
        }
        
        customizationOfDataDisplay.key = .speed
        let speed = customizationOfDataDisplay.get()
        
        switch speed {
        case "km":
            сustomizationView.windSpeedSegmentedControl.selectedSegmentIndex = 0
        case "milie":
            сustomizationView.windSpeedSegmentedControl.selectedSegmentIndex = 1
        case "kn":
            сustomizationView.windSpeedSegmentedControl.selectedSegmentIndex = 3
        default:
            сustomizationView.windSpeedSegmentedControl.selectedSegmentIndex = 2
        }
        
        customizationOfDataDisplay.key = .pressure
        let pressure = customizationOfDataDisplay.get()
        
        switch pressure {
        case "kPa":
            сustomizationView.pressureSegmentedControl.selectedSegmentIndex = 2
        case "mm":
            сustomizationView.pressureSegmentedControl.selectedSegmentIndex = 3
        case "inch":
            сustomizationView.pressureSegmentedControl.selectedSegmentIndex = 1
        default:
            сustomizationView.pressureSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
}


extension СustomizationViewController: SelectedValueViewDelegate {
    
    func selectedValueTemperature(target: UISegmentedControl) {
        customizationOfDataDisplay.key = .temperature
        switch target.selectedSegmentIndex {
        case 0:
            customizationOfDataDisplay.save(element: "C")
        case 1:
            customizationOfDataDisplay.save(element: "F")
        case 2:
            customizationOfDataDisplay.save(element: "K")
        default:
            break
        }
    }
    
    func selectedValueWindSpeed(target: UISegmentedControl) {
        customizationOfDataDisplay.key = .speed
        switch target.selectedSegmentIndex {
        case 0:
            customizationOfDataDisplay.save(element: "km")
        case 1:
            customizationOfDataDisplay.save(element: "milie")
        case 2:
            customizationOfDataDisplay.save(element: "m")
        case 3:
            customizationOfDataDisplay.save(element: "kn")
        default:
            break
        }
    }
    
    func selectedValuePressure(target: UISegmentedControl) {
        customizationOfDataDisplay.key = .pressure
        switch target.selectedSegmentIndex {
        case 0:
            customizationOfDataDisplay.save(element: "hPa")
        case 1:
            customizationOfDataDisplay.save(element: "inch")
        case 2:
            customizationOfDataDisplay.save(element: "kPa")
        case 3:
            customizationOfDataDisplay.save(element: "mm")
        default:
            break
        }
    }
    
    func selectedValuePrecipitation(target: UISegmentedControl) {
        
    }
    
    func selectedValueDistance(target: UISegmentedControl) {
        
    }
}
