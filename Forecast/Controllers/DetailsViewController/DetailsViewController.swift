
import UIKit

class DetailsViewController: UITableViewController {
    
    private var userDefaultsManager: UserDefaultsManagerProtocol
    private let queryService:        QueryServiceProtocol
    private let coreDataService:     CoreDataServiceProtocol
    
    private let headingTableViewCell = HeadingTableViewCell()
    private let collectionTableViewCell = СollectionTableViewCell()
    
    private var cellModels: [TableViewCellModel] = [] {
        willSet(newValue) {
            tableView.reloadData()
        }
    }
    
    var selectedСityWeatherCopy: СityWeatherCopy? {
        willSet(newValue) {
            if newValue == nil {
                userDefaultsManager.remove(key: .coordinates)
            }
        }
    }
    
    init(queryService: QueryServiceProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol,
         coreDataService: CoreDataServiceProtocol) {
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
            cellModels = createCellModels()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cellModels = createCellModels()
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
                    guard let strongSelf = self else { return }
                    strongSelf.cellModels = strongSelf.createCellModels()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedСityWeatherCopy == nil {
            tableView.backgroundView = BackgroundView()
            return 0
        } else {
            tableView.backgroundView = nil
            return cellModels.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellType.reuseId,
                                                 for: indexPath)
        guard let configurableCell = cell as? (UITableViewCell & ConfigurableWithAny) else {
            return cell
        }
        
        configurableCell.confugire(with: cellModel)
        
        return cell
    }
    
    private func createCellModels() -> [TableViewCellModel] {
        
        let temp: String? = userDefaultsManager.get(key: .temperature)
        let speed: String? = userDefaultsManager.get(key: .speed)
        let pressure: String? = userDefaultsManager.get(key: .pressure)
        
        let headingModel = HeadingModel(cityName: selectedСityWeatherCopy?.cityName,
                                        description: selectedСityWeatherCopy?.description,
                                        temp: selectedСityWeatherCopy?.getTemperature(unit: temp),
                                        icon: UIImage(systemName: selectedСityWeatherCopy?.systemIconNameString ?? "nosign"))
        
        let сollectionTableModel = CollectionTableModel(temperature: temp, models: selectedСityWeatherCopy?.cityWeatherHourlyСopies)
        
        let defaultModelFeelsLike = DefaultModel(title: "По ощущениям", subtitle: selectedСityWeatherCopy?.getFeelsLike(unit: temp))
        
        let defaultModelSpeed = DefaultModel(title: "Ветер", subtitle: selectedСityWeatherCopy?.getSpeed(unit: speed))
        
        let defaultModelPressure = DefaultModel(title: "Давление", subtitle: selectedСityWeatherCopy?.getPressure(unit: pressure))
        
        let defaultModelHumidity = DefaultModel(title: "Влажность", subtitle: selectedСityWeatherCopy?.humidityString)
        
        let defaultModelAll = DefaultModel(title: "Облачность", subtitle: selectedСityWeatherCopy?.allString)
        
        
        let cellModel: [TableViewCellModel] = [headingModel,
                                               сollectionTableModel,
                                               defaultModelFeelsLike,
                                               defaultModelSpeed,
                                               defaultModelPressure,
                                               defaultModelHumidity,
                                               defaultModelAll]
        
        cellModel.forEach({ model in
            tableView.register(model.cellType, forCellReuseIdentifier: model.cellType.reuseId)
        })
        
        return cellModel
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellModels[indexPath.row].cellHeight
    }
    
}
