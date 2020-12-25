

import UIKit

class ListViewController: UITableViewController {
    
    var currentWeatherArray: [CurrentWeather] = []
    
    let coreDataService = CoreDataService()
    
    let networkWeatherManager = NetworkWeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "City"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchPressed))
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        tableView.register(CustomListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        networkWeatherManager.onCompletion = {  [unowned self] currentWeather in
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        updateInterfaceWith(weather: nil)
 
    }
    
    @objc func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeatherManager(forCity: city)
        }
    }
    
    func updateInterfaceWith (weather: CurrentWeather?) {
        if let weather = weather {
            coreDataService.saveCity(currentWeather: weather)
            currentWeatherArray.append(weather)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            self.currentWeatherArray = self.coreDataService.getCity()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentWeatherArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomListTableViewCell else { fatalError("Unable to Dequeue Image Table View Cell") }
        cell.cityNameLabel.text = currentWeatherArray[indexPath.row].cityName
        cell.weatherImageView.image = UIImage(systemName: currentWeatherArray[indexPath.row].systemIconNameString)
        cell.temperatureLabel.text = currentWeatherArray[indexPath.row].temperatureString
        cell.dateLabel.text = currentWeatherArray[indexPath.row].dtString
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabBarController?.selectedIndex = 0
        let viewControllersFirst = tabBarController?.viewControllers?.first as? DetailsViewController
        viewControllersFirst?.cityLabel.text = currentWeatherArray[indexPath.row].cityName
        viewControllersFirst?.temperatureLabel.text = currentWeatherArray[indexPath.row].temperatureString
        viewControllersFirst?.weatherIconImageView.image = UIImage(systemName: currentWeatherArray[indexPath.row].systemIconNameString)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        
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
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            tf.placeholder = "Enter city"
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
}
