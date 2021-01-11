

import UIKit
import CoreData

class ListViewController: UITableViewController {
    
    private let coreDataService:            CoreDataService
    private weak var detailsViewController: DetailsViewController?
    private let customizationOfDataDisplay: UserDefaultsProtocol
    private let receivingManager:           ReceivingManagerProtocol
    private var cityWeatherCopyArray:   [СityWeatherCopy] = []
    
    
    init(receivingManager: ReceivingManagerProtocol,
         customizationOfDataDisplay: UserDefaultsProtocol,
         coreDataService: CoreDataService,
         viewControllerFirst: DetailsViewController) {
        
        self.receivingManager = receivingManager
        self.customizationOfDataDisplay = customizationOfDataDisplay
        self.coreDataService = coreDataService
        self.detailsViewController = viewControllerFirst
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset.left = 60
        tableView.tableFooterView = UIView()
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setupNavigationBar ()
        getСities ()
    }
    
    @objc func requestByCityName () {
        
        self.presentSearchAlertController(withTitle: "Enter city cityName", message: nil, style: .alert) { [weak self] city in
            
            self?.receivingManager.fetchСityWeatherCopy(cityName: city) { [weak self] currentWeatherCopy, error  in
                
                if let currentWeatherCopy = currentWeatherCopy{
                    DispatchQueue.main.async {
                        self?.addingNewCityWeatherCopy(cityWeatherCopy: currentWeatherCopy)
                    }
                } else {
                    /// Получение информации об ошибке
                    let errorr = error!
                    print(errorr)
                }
            }
        }
        
    }
    
    func addingNewCityWeatherCopy (cityWeatherCopy: СityWeatherCopy) {
        coreDataService.saveСityWeather(cityWeatherCopy: cityWeatherCopy)
        cityWeatherCopyArray.append(cityWeatherCopy)
        
        tableView.reloadData()
        
        detailsViewController?.selectedСityWeatherCopy = cityWeatherCopy
        detailsViewController?.updateInterfaceWith()
    }
    
    
    func getСities () {
        self.cityWeatherCopyArray = self.coreDataService.getСitiesWeatherCopy()
    }
    
    
    func setupNavigationBar () {
        ///     Большой заголовок
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "City"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(requestByCityName))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        receivingManager.fetchСitiesWeatherCopy(сityWeatherCopyArray: cityWeatherCopyArray) { [weak self] currentCityWeatherCopyArray   in
            self?.cityWeatherCopyArray = currentCityWeatherCopyArray
            self?.tableView.reloadData()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coreDataService.rewritingСitiesWeather(cityWeatherCopyArray: cityWeatherCopyArray)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeatherCopyArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            coreDataService.deleteСityWeather(cityWeatherCopy: cityWeatherCopyArray[indexPath.row])
            cityWeatherCopyArray.remove(at: indexPath.row)
            
            if (indexPath.row - 1) < 0 {
                detailsViewController?.selectedСityWeatherCopy = cityWeatherCopyArray.first
            } else {
                detailsViewController?.selectedСityWeatherCopy = cityWeatherCopyArray[indexPath.row - 1]
            }
            
            detailsViewController?.updateInterfaceWith()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTableViewCell else { fatalError("Unable to Dequeue Image Table View Cell") }
        
        let customization = customizationOfDataDisplay as! CustomizationOfDataDisplay
        
        customization.key = .temperature
        
        let temperatureParametr  = customization.get()
        
        switch temperatureParametr {
        case "C":
            cell.temperatureLabel.text = cityWeatherCopyArray[indexPath.row].temperatureСelsius
        case "F":
            cell.temperatureLabel.text = cityWeatherCopyArray[indexPath.row].temperatureFahrenheit
        case "K":
            cell.temperatureLabel.text = cityWeatherCopyArray[indexPath.row].temperatureKelvin
        default:
            cell.temperatureLabel.text = cityWeatherCopyArray[indexPath.row].temperatureСelsius
        }
        
        cell.cityNameLabel.text = cityWeatherCopyArray[indexPath.row].cityName
        cell.weatherImageView.image = UIImage(systemName: cityWeatherCopyArray[indexPath.row].systemIconNameString)
        cell.dateLabel.text = cityWeatherCopyArray[indexPath.row].dtString
        
        return cell
    }
    
    /// Переход на DetailsViewController  отображение детальных данных погоды выбранного города)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsViewController?.selectedСityWeatherCopy = cityWeatherCopyArray[indexPath.row]
        detailsViewController?.updateInterfaceWith()
        tabBarController?.selectedIndex = 0
    }
    
}
