

import UIKit

class DetailsViewController: UITableViewController {
    
    private var usDefMDataDisplay: UserDefaultsManager<String>
    private var usDefMСoordinates: UserDefaultsManager<[String:Double]>
    private let queryService: QueryService
    private let coreDataService: CoreDataService
    
    private let headingTableViewCell = HeadingTableViewCell()
    private let collectionTableViewCell = СollectionTableViewCell()
    
    var selectedСityWeatherCopy: СityWeatherCopy? {
        willSet(newValue) {
            if newValue == nil {
                usDefMСoordinates.remove(key: .coordinates)
            }
        }
    }
    
    init(queryService: QueryService,
         usDefMDataDisplay: UserDefaultsManager<String>,
         usDefMСoordinates: UserDefaultsManager<[String:Double]>,
         coreDataService: CoreDataService) {
        
        self.queryService = queryService
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
        tableView.separatorInset.left = 8
        tableView.separatorInset.right = 8
        tableView.separatorColor = #colorLiteral(red: 1, green: 0.9514930844, blue: 0.9390899539, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let coordinates = usDefMСoordinates.get(key: .coordinates)
        if let coordinates = coordinates, let latitude = coordinates["lat"], let longitude = coordinates["lon"] {
            selectedСityWeatherCopy = coreDataService.getСityWeatherCopy(coordinates: (latitude,longitude))
            tableView.reloadData()
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
            usDefMСoordinates.save(coordinates, key: .coordinates)
        }
    }
    
    func requestAndUpdate(coordinate: (Double, Double)) {
        requestСityWeatherCopy(coordinate: coordinate) { [weak self] cityWeatherCopy, error  in
            
            guard let cityWeatherCopy = cityWeatherCopy else {
                DispatchQueue.main.async {
                    self?.presentErrorAlert()
                }
                return
            }
            
            self?.selectedСityWeatherCopy = cityWeatherCopy
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func requestСityWeatherCopy(coordinate: (Double,Double), completionHandler: @escaping (СityWeatherCopy?, Error?) -> Void) {
        queryService.fetchСityWeatherCopy(coordinate: coordinate) {cityWeatherCopy, error  in
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
        
        let defaultTableViewCell: UITableViewCell = {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.detailTextLabel?.textColor = #colorLiteral(red: 0.9097684026, green: 0.9043604732, blue: 0.9139258265, alpha: 1)
            cell.selectionStyle = .none
            return cell
        }()
        
        switch indexPath.row{
        case 0:
            if let cityName = selectedСityWeatherCopy?.cityName, let description = selectedСityWeatherCopy?.description {
                headingTableViewCell.nameLabel.text = cityName + "\n" + description
            }
            headingTableViewCell.iconImageView.image = UIImage(systemName: selectedСityWeatherCopy?.systemIconNameString ?? "")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            let temperature = usDefMDataDisplay.get(key: .temperature)
            headingTableViewCell.tempLabel.text = selectedСityWeatherCopy?.getTemperature(unit: temperature)
            return headingTableViewCell
        case 1:
            collectionTableViewCell.settingParameters(cityWeatherHourly: selectedСityWeatherCopy?.cityWeatherHourlyArray ?? nil)
            return collectionTableViewCell
        case 2:
            let temperature = usDefMDataDisplay.get(key: .temperature)
            defaultTableViewCell.textLabel?.text = "По ощущениям"
            defaultTableViewCell.detailTextLabel?.text = selectedСityWeatherCopy?.getFeelsLike(unit: temperature)
            return defaultTableViewCell
        case 3:
            let speed = usDefMDataDisplay.get(key: .speed)
            defaultTableViewCell.textLabel?.text = "Ветер"
            defaultTableViewCell.detailTextLabel?.text = selectedСityWeatherCopy?.getSpeed(unit: speed)
            return defaultTableViewCell
        case 4:
            let pressure = usDefMDataDisplay.get(key: .pressure)
            defaultTableViewCell.textLabel?.text = "Давление"
            defaultTableViewCell.detailTextLabel?.text = selectedСityWeatherCopy?.getPressure(unit: pressure)
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
