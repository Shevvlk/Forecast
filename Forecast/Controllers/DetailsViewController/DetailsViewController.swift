
import UIKit

class DetailsViewController: UIViewController {
    
    private let customizationOfDataDisplay: CustomizationOfDataDisplay
    private let receivingManager: ReceivingManagerProtocol
    private let coreDataService: CoreDataService
    
    private let detailsView = DetailsView()
    
    var selectedСityWeatherCopy: СityWeatherCopy? {
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
        
        if let cityName = selectedСityWeatherCopy?.cityName {
            request(cityWeatherCopy: cityName)
        } else if let lastOpenCityName = customizationOfDataDisplay.get() {
            request(cityWeatherCopy: lastOpenCityName)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let cityWeatherCopy  = selectedСityWeatherCopy {
            customizationOfDataDisplay.key = .cityName
            customizationOfDataDisplay.save(element: cityWeatherCopy .cityName)
        }
    }
    
    func request(cityWeatherCopy: String) {
        receivingManager.fetchСityWeatherCopy(cityName: cityWeatherCopy) {[weak self] cityWeatherCopy, error  in
            self?.selectedСityWeatherCopy = cityWeatherCopy
            DispatchQueue.main.async {
                self?.updateInterfaceWith()
            }
        }
    }
    
    func updateInterfaceWith () {
        
        detailsView.cityNameLabel.text = selectedСityWeatherCopy?.cityName
        
        detailsView.weatherIconImageView.image = UIImage(systemName: selectedСityWeatherCopy?.systemIconNameString ?? "")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        
        customizationOfDataDisplay.key = .temperature
        let temperature = customizationOfDataDisplay.get()
        
        switch temperature {
        case "F":
            detailsView.temperatureLabel.text = selectedСityWeatherCopy?.temperatureFahrenheit
            detailsView.feelsLikeTemperature.text = selectedСityWeatherCopy?.feelsLikeTemperatureFahrenheit
        case "K":
            detailsView.temperatureLabel.text = selectedСityWeatherCopy?.temperatureKelvin
            detailsView.feelsLikeTemperature.text = selectedСityWeatherCopy?.feelsLikeTemperatureKelvin
        default:
            detailsView.temperatureLabel.text = selectedСityWeatherCopy?.temperatureСelsius
            detailsView.feelsLikeTemperature.text = selectedСityWeatherCopy?.feelsLikeTemperatureСelsius
        }
        
        customizationOfDataDisplay.key = .speed
        let speed = customizationOfDataDisplay.get()
        
        switch speed {
        case "km":
            detailsView.speed.text = selectedСityWeatherCopy?.speedKM
        case "milie":
            detailsView.speed.text = selectedСityWeatherCopy?.speedMilie
        case "kn":
            detailsView.speed.text = selectedСityWeatherCopy?.speedKn
        default:
            detailsView.speed.text = selectedСityWeatherCopy?.speedM
        }
        
        customizationOfDataDisplay.key = .pressure
        let pressure = customizationOfDataDisplay.get()
        
        switch pressure {
        case "kPa":
            detailsView.pressure.text = selectedСityWeatherCopy?.pressurekPa
        case "mm":
            detailsView.pressure.text = selectedСityWeatherCopy?.pressureMM
        case "inch":
            detailsView.pressure.text = selectedСityWeatherCopy?.pressureInch
        default:
            detailsView.pressure.text = selectedСityWeatherCopy?.pressurehPa
        }
        
        detailsView.humidity.text = selectedСityWeatherCopy?.humidityString
        
        detailsView.all.text = selectedСityWeatherCopy?.allString
    }
    
}

