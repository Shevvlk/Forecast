
import UIKit

class DetailsViewController: UIViewController {
    
    private let customizationOfDataDisplay: CustomizationOfDataDisplay
    private let receivingManager: ReceivingManagerProtocol
    private let coreDataService: CoreDataService
    
    private let detailsView = DetailsView()
    
    var selectedСity: Сity? {
        willSet(newValue) {
            if newValue == nil {
                customizationOfDataDisplay.key = .cityName
                customizationOfDataDisplay.remove()
            }
        }
    }
    
    init(receivingManager: ReceivingManagerProtocol,
         customizationOfDataDisplay: CustomizationOfDataDisplay,
         coreDataService: CoreDataService) {
        
        self.receivingManager = receivingManager
        self.customizationOfDataDisplay = customizationOfDataDisplay
        self.coreDataService = coreDataService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizationOfDataDisplay.key = .cityName
        if let currentСityWeather = selectedСity?.cityName {
            request(currentСityWeather)
        } else if let lastOpenCityName = customizationOfDataDisplay.get() {
            request(lastOpenCityName)
        }        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let city = selectedСity {
            customizationOfDataDisplay.key = .cityName
            customizationOfDataDisplay.save(element: city.cityName)
        }
    }
    
    func updateInterfaceWith () {
        
        customizationOfDataDisplay.key = .temperature
        let temperature = customizationOfDataDisplay.get()
        
        switch temperature {
        case "F":
            detailsView.temperatureLabel.text = selectedСity?.temperatureFahrenheit
            detailsView.feelsLikeTemperature.text = selectedСity?.feelsLikeTemperatureFahrenheit
        case "K":
            detailsView.temperatureLabel.text = selectedСity?.temperatureKelvin
            detailsView.feelsLikeTemperature.text = selectedСity?.feelsLikeTemperatureKelvin
        default:
            detailsView.temperatureLabel.text = selectedСity?.temperatureСelsius
            detailsView.feelsLikeTemperature.text = selectedСity?.feelsLikeTemperatureСelsius
        }
        
        customizationOfDataDisplay.key = .speed
        let speed = customizationOfDataDisplay.get()
        
        switch speed {
        case "km":
            detailsView.speed.text = selectedСity?.speedKM
        case "milie":
            detailsView.speed.text = selectedСity?.speedMilie
        case "kn":
            detailsView.speed.text = selectedСity?.speedKn
        default:
            detailsView.speed.text = selectedСity?.speedM
        }
        
        customizationOfDataDisplay.key = .pressure
        let pressure = customizationOfDataDisplay.get()
        
        switch pressure {
        case "kPa":
            detailsView.pressure.text = selectedСity?.pressurekPa
        case "mm":
            detailsView.pressure.text = selectedСity?.pressureMM
        case "inch":
            detailsView.pressure.text = selectedСity?.pressureInch
        default:
            detailsView.pressure.text = selectedСity?.pressurehPa
        }
        
        detailsView.humidity.text = selectedСity?.humidityString
        
        detailsView.all.text = selectedСity?.allString
        
        
        detailsView.cityNameLabel.text = selectedСity?.cityName
        
        detailsView.weatherIconImageView.image = UIImage(systemName: selectedСity?.systemIconNameString ?? "")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }
    
    func request(_ city: String) {
        receivingManager.fetchCurrentСityWeather(forCity: city) {[weak self] currentWeather, error  in
            self?.selectedСity = currentWeather
            DispatchQueue.main.async {
                self?.updateInterfaceWith()
            }
        }
    }
    

}

