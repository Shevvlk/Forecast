
import UIKit

class SettingsViewController: UIViewController {
    
    private let сustomizationView = SettingsView()
    private var usDefMDataDisplay: UserDefaultsManager<String>
    
    init(usDefMDataDisplay: UserDefaultsManager<String>) {
        self.usDefMDataDisplay = usDefMDataDisplay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = сustomizationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        сustomizationView.delegateView = self
        installingSegmentedControl()
    }
    
    func installingSegmentedControl() {
    
        let temperature = usDefMDataDisplay.get(key: .temperature)
        
        switch temperature {
        case "F":
            сustomizationView.temperatureSegmentedControl.selectedSegmentIndex = 1
        case "K":
            сustomizationView.temperatureSegmentedControl.selectedSegmentIndex = 2
        default:
            сustomizationView.temperatureSegmentedControl.selectedSegmentIndex = 0
        }
        
        let speed = usDefMDataDisplay.get(key: .speed)
        
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
        
        let pressure = usDefMDataDisplay.get(key: .pressure)
        
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


extension SettingsViewController: SelectedValueViewDelegate {
    
    func selectedValueTemperature(target: UISegmentedControl) {
       
        
        switch target.selectedSegmentIndex {
        case 0:
            usDefMDataDisplay.save("C", key: .temperature)
        case 1:
            usDefMDataDisplay.save("F", key: .temperature)
        case 2:
            usDefMDataDisplay.save("K", key: .temperature)
        default:
            break
        }
    }
    
    func selectedValueWindSpeed(target: UISegmentedControl) {
        switch target.selectedSegmentIndex {
        case 0:
            usDefMDataDisplay.save("km", key: .speed)
        case 1:
            usDefMDataDisplay.save("milie", key: .speed)
        case 2:
            usDefMDataDisplay.save("m", key: .speed)
        case 3:
            usDefMDataDisplay.save("kn", key: .speed)
        default:
            break
        }
    }
    
    func selectedValuePressure(target: UISegmentedControl) {
        switch target.selectedSegmentIndex {
        case 0:
            usDefMDataDisplay.save("hPa", key: .pressure)
        case 1:
            usDefMDataDisplay.save("inch", key: .pressure)
        case 2:
            usDefMDataDisplay.save("kPa", key: .pressure)
        case 3:
            usDefMDataDisplay.save("mm", key: .pressure)
        default:
            break
        }
    }
    
    func selectedValuePrecipitation(target: UISegmentedControl) {
        
    }
    
    func selectedValueDistance(target: UISegmentedControl) {
        
    }
}
