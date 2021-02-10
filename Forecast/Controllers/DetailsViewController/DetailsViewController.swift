

import UIKit

class DetailsViewController: UITableViewController {
    
    let copyTableViewCell = DetailsTableViewCell()
    
    private var usDefMDataDisplay: UserDefaultsManager<String>
    private var usDefMСoordinates: UserDefaultsManager<[String:Double]>
    private let receivingManager: ReceivingManagerProtocol
    private let coreDataService: CoreDataService
    
    var selectedСityWeatherCopy: СityWeatherCopy? {
        willSet(newValue) {
            if newValue == nil {
                usDefMСoordinates.remove(key: .coordinates)
            }
        }
    }
    
    init(queryService: ReceivingManagerProtocol,
         usDefMDataDisplay: UserDefaultsManager<String>,
         usDefMСoordinates: UserDefaultsManager<[String:Double]>,
         coreDataService: CoreDataService) {
        
        self.receivingManager = queryService
        self.usDefMDataDisplay = usDefMDataDisplay
        self.usDefMСoordinates = usDefMСoordinates
        self.coreDataService = coreDataService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        let coordinates = usDefMСoordinates.get(key: .coordinates)
        if let coordinates = coordinates, let latitude = coordinates["latitude"], let longitude = coordinates["longitude"] {
            selectedСityWeatherCopy = coreDataService.getСityWeatherCopy(coordinates: (latitude,longitude))
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedСityWeatherCopy = selectedСityWeatherCopy  {
            requestAndUpdate(coordinate: (selectedСityWeatherCopy.latitude,selectedСityWeatherCopy.longitude))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let cityWeatherCopy = selectedСityWeatherCopy {
            let coordinates = ["latitude": cityWeatherCopy.latitude, "longitude": cityWeatherCopy.longitude]
            usDefMСoordinates.save(coordinates, key: .coordinates)
        }
        
    }
    
    func requestAndUpdate(coordinate: (Double, Double)) {
        requestСityWeatherCopy(coordinate: coordinate) { [weak self] cityWeatherCopy, error  in
           
            guard let cityWeatherCopy = cityWeatherCopy else {
                DispatchQueue.main.async {
                    self?.presentNetworkFailureAlert()
                }
                print(error as! NetworkManagerError)
                return
            }
            
            self?.selectedСityWeatherCopy = cityWeatherCopy
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func requestСityWeatherCopy(coordinate: (Double,Double), completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void) {
        receivingManager.fetchСityWeatherCopy(coordinate: coordinate) {cityWeatherCopy, error  in
            completionHandler(cityWeatherCopy, error)
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        switch indexPath.row{
        case 0:
            
            if let cityName = selectedСityWeatherCopy?.cityName, let description = selectedСityWeatherCopy?.description {
                copyTableViewCell.cityNameLabel.text = cityName + "\n" + description
            }
            
            copyTableViewCell.weatherIconImageView.image = UIImage(systemName: selectedСityWeatherCopy?.systemIconNameString ?? "")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            
            let temperature = usDefMDataDisplay.get(key: .temperature)
            
            switch temperature {
            
            case "F":
                copyTableViewCell.temperatureLabel.text = selectedСityWeatherCopy?.temperatureFahrenheit
            case "K":
                copyTableViewCell.temperatureLabel.text = selectedСityWeatherCopy?.temperatureKelvin
            default:
                copyTableViewCell.temperatureLabel.text = selectedСityWeatherCopy?.temperatureСelsius
            }
            return copyTableViewCell
            
        case 1:
            let temperature = usDefMDataDisplay.get(key: .temperature)
            cell.textLabel?.text = "По ощущениям"
            switch temperature {
            case "F":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.feelsLikeTemperatureFahrenheit
            case "K":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.feelsLikeTemperatureKelvin
            default:
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.feelsLikeTemperatureСelsius
            }
            
            return cell
            
        case 2:
            let speed = usDefMDataDisplay.get(key: .speed)
            cell.textLabel?.text = "Ветер"
            switch speed {
            case "km":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.speedKM
            case "milie":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.speedMilie
            case "kn":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.speedKn
            default:
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.speedM
            }
            return cell
            
        case 3:
            let pressure = usDefMDataDisplay.get(key: .pressure)
            cell.textLabel?.text = "Давление"
            switch pressure {
            case "kPa":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.pressurekPa
            case "mm":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.pressureMM
            case "inch":
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.pressureInch
            default:
                cell.detailTextLabel?.text = selectedСityWeatherCopy?.pressurehPa
            }
            return cell
            
        case 4:
            cell.textLabel?.text = "Влажность"
            cell.detailTextLabel?.text = selectedСityWeatherCopy?.humidityString
            return cell
        case 5:
            cell.textLabel?.text = "Облачность"
            cell.detailTextLabel?.text  = selectedСityWeatherCopy?.allString
            return cell
        default:
            return cell
        }
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 400
        default:
            return 55
        }
    }
    
}


extension DetailsViewController {
    
    func presentNetworkFailureAlert() {
        let alertController = UIAlertController(title:"Sing cellular data transfer", message: "Check your cellular or Wi-Fi data connection to access data", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        let settings = UIAlertAction(title: "Settings", style: .default) { action in
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


