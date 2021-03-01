import UIKit

class DetailsViewController: UITableViewController {
    
    private var userDefaultsManager: UserDefaultsManagerProtocol
    private let queryService: QueryService
    private let coreDataService: CoreDataService
    
    private let headingTableViewCell = HeadingTableViewCell()
    private let collectionTableViewCell = СollectionTableViewCell()
    
    var selectedСityWeatherCopy: СityWeatherCopy? {
        willSet(newValue) {
            tableView.reloadData()
            if newValue == nil {
                userDefaultsManager.remove(key: .coordinates)
            }
        }
    }
    
    init(queryService: QueryService,
         userDefaultsManager: UserDefaultsManagerProtocol,
         coreDataService: CoreDataService) {
        
        self.queryService = queryService
        self.userDefaultsManager = userDefaultsManager
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
        tableView.separatorInset.left = 8
        tableView.separatorInset.right = 8
        tableView.separatorColor = #colorLiteral(red: 1, green: 0.9514930844, blue: 0.9390899539, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let coordinates: [String:Double]? = userDefaultsManager.get(key: .coordinates)
        if let coordinates = coordinates, let latitude = coordinates["lat"], let longitude = coordinates["lon"] {
            selectedСityWeatherCopy = coreDataService.getСityWeatherCopy(coordinates: (latitude,longitude))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if let selectedСityWeatherCopy = selectedСityWeatherCopy  {
            requestAndUpdate(coordinate: (selectedСityWeatherCopy.latitude,selectedСityWeatherCopy.longitude))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let cityWeatherCopy = selectedСityWeatherCopy {
            let coordinates = ["lat": cityWeatherCopy.latitude, "lon": cityWeatherCopy.longitude]
            userDefaultsManager.save(coordinates, key: .coordinates)
        }
    }
    
    func requestAndUpdate(coordinate: (Double, Double)) {
        requestСityWeatherCopy(coordinate: coordinate) { [weak self] result  in
            
            do {
                let cityWeatherCopy = try result.get()
                DispatchQueue.main.async {
                    self?.selectedСityWeatherCopy = cityWeatherCopy
                }
            } catch  {
                    DispatchQueue.main.async {
                        self?.presentErrorAlert(error: error)
                }
            }
        }
    }
    
    
    func requestСityWeatherCopy(coordinate: (Double,Double), completionHandler: @escaping (Result<СityWeatherCopy, Error>) -> Void) {
        queryService.fetchСityWeatherCopy(coordinate: coordinate) { result  in
            completionHandler(result)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedСityWeatherCopy == nil {
            tableView.backgroundView = BackgroundView()
            return 0
        } else {
            tableView.backgroundView = nil
            return 6
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultTableViewCell: UITableViewCell = {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.detailTextLabel?.textColor = #colorLiteral(red: 0.9097684026, green: 0.9043604732, blue: 0.9139258265, alpha: 1)
            cell.selectionStyle = .none
            return cell
        }()
        
        let temperature: String? = userDefaultsManager.get(key: .temperature)
        
        switch indexPath.row{
        case 0:
            if let cityName = selectedСityWeatherCopy?.cityName, let description = selectedСityWeatherCopy?.description {
                headingTableViewCell.nameLabel.text = cityName + "\n" + description
            }
            headingTableViewCell.iconImageView.image = UIImage(systemName: selectedСityWeatherCopy?.systemIconNameString ?? "")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            //            headingTableViewCell.tempLabel.text = selectedСityWeatherCopy?.getTemperature(unit: temperature)
            return headingTableViewCell
        case 1:
            //            collectionTableViewCell.settingParameters(cityWeatherHourly: selectedСityWeatherCopy?.cityWeatherHourlyСopies ?? [], temperature: temperature)
            return collectionTableViewCell
        case 2:
            defaultTableViewCell.textLabel?.text = "По ощущениям"
            defaultTableViewCell.detailTextLabel?.text = selectedСityWeatherCopy?.getFeelsLike(unit: temperature)
            return defaultTableViewCell
        case 3:
            //            guard let speed: String = userDefaultsManager.get(key: .speed) else {return}
            defaultTableViewCell.textLabel?.text = "Ветер"
            //            defaultTableViewCell.detailTextLabel?.text = selectedСityWeatherCopy?.getSpeed(unit: speed)
            return defaultTableViewCell
        case 4:
            //            guard let pressure: String = userDefaultsManager.get(key: .pressure) else {return}
            defaultTableViewCell.textLabel?.text = "Давление"
            //            defaultTableViewCell.detailTextLabel?.text = selectedСityWeatherCopy?.getPressure(unit: pressure)
            return defaultTableViewCell
        case 5:
            defaultTableViewCell.textLabel?.text = "Влажность"
            defaultTableViewCell.detailTextLabel?.text = selectedСityWeatherCopy?.humidityString
            return defaultTableViewCell
        case 6:
            defaultTableViewCell.textLabel?.text = "Облачность"
            defaultTableViewCell.detailTextLabel?.text  = selectedСityWeatherCopy?.allString
            return defaultTableViewCell
        default:
            return defaultTableViewCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 400
        case 1:
            return 100
        default:
            return 55
        }
    }
}
