

import UIKit
import CoreData

class ListViewController: UITableViewController {
    
    private var currentWeatherArray: [CurrentСityWeather] = []
    
    private let coreDataService = CoreDataService()
    
    private let networkWeatherManager = NetworkManagerCityWeather()

    private weak var viewControllerFirst: DetailsViewController? = nil
    
    private let customizationOfDataDisplay = CustomizationOfDataDisplay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerFirst = tabBarController?.viewControllers?.first as? DetailsViewController
        
        tableView.tableFooterView = UIView()
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setupNavigationBar ()
    
        updateInterfaceWith(weather: nil)
    }
    
    @objc func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self] city in
            self?.networkWeatherManager.fetchCurrentWeatherManager(forCity: city) { [weak self] currentWeather in
                self?.updateInterfaceWith(weather: currentWeather)
            }
        }
    }
    
    func updateInterfaceWith (weather: CurrentСityWeather?) {
        if let weather = weather {
            coreDataService.saveCity(currentWeather: weather)
            currentWeatherArray.append(weather)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.viewControllerFirst?.currentСityWeather = weather
                self.viewControllerFirst?.updateInterfaceWith()
            }
        } else {
            self.currentWeatherArray = self.coreDataService.getCity()
        }
    }
    
    
    func setupNavigationBar () {
///     Большой заголовок
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "City"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(searchPressed))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        let receivingManager = ReceivingManager()
        receivingManager.fetch(cityArray: currentWeatherArray) { (CurrentСityWeatherNew, error) in
            self.currentWeatherArray = CurrentСityWeatherNew
            self.tableView.reloadData()
            print("обновление")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coreDataService.rewriting(currentWeatherArray: currentWeatherArray)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return currentWeatherArray.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 70
   }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataService.deleteCity(currentWeather: currentWeatherArray[indexPath.row])
            currentWeatherArray.remove(at: indexPath.row)
            viewControllerFirst?.currentСityWeather = currentWeatherArray.first
            viewControllerFirst?.updateInterfaceWith()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTableViewCell else { fatalError("Unable to Dequeue Image Table View Cell") }
        
        customizationOfDataDisplay.key = .temperature
       
        let temperatureParametr  = customizationOfDataDisplay.get()
        
        switch temperatureParametr {
        case "C":
            cell.temperatureLabel.text = currentWeatherArray[indexPath.row].temperatureСelsius
        case "F":
            cell.temperatureLabel.text = currentWeatherArray[indexPath.row].temperatureFahrenheit
        case "K":
            cell.temperatureLabel.text = currentWeatherArray[indexPath.row].temperatureKelvin
        default:
            cell.temperatureLabel.text = currentWeatherArray[indexPath.row].temperatureСelsius
        }
        
        cell.cityNameLabel.text = currentWeatherArray[indexPath.row].cityName
        cell.weatherImageView.image = UIImage(systemName: currentWeatherArray[indexPath.row].systemIconNameString)
        cell.dateLabel.text = currentWeatherArray[indexPath.row].dtString
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewControllerFirst?.currentСityWeather = currentWeatherArray[indexPath.row]
        viewControllerFirst?.updateInterfaceWith()
        tabBarController?.selectedIndex = 0
    }

}
