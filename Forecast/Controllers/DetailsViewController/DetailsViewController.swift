
import UIKit

class DetailsViewController: UIViewController {
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 33)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherIconImageView: UIImageView = {
        let myweatherIconImageView = UIImageView()
        myweatherIconImageView.contentMode = .scaleAspectFit
        myweatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return myweatherIconImageView
    }()
    
    let background: UIImageView = {
        let mybackground = UIImageView()
        let image = UIImage(named: "background")
        mybackground.image = image
        mybackground.translatesAutoresizingMaskIntoConstraints = false
        return mybackground
    }()
    
    var currentСityWeather: CurrentСityWeather? {
        willSet(newValue) {
            if newValue == nil {
                lastOpenCity.remove()
            }
        }
    }
    let networkWeatherManager = NetworkManagerCityWeather()
    let lastOpenCity = LastOpenCity()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        view.addSubview(cityLabel)
        view.addSubview(weatherIconImageView)
        view.addSubview(temperatureLabel)

        exposingConstraint ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let currentСityWeather = currentСityWeather?.cityName {
            request(currentСityWeather)
        } else if let lastOpenCityName = lastOpenCity.getLastOpenCityName() {
            request(lastOpenCityName)
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentСityWeather = currentСityWeather {
            lastOpenCity.saveLastOpenCityName(currentСityWeather: currentСityWeather)
        }
    }
    
    func updateInterfaceWith () {
        self.cityLabel.text = currentСityWeather?.cityName
        self.temperatureLabel.text = currentСityWeather?.temperatureString
        self.weatherIconImageView.image = UIImage(systemName: currentСityWeather?.systemIconNameString ?? "")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }
    
    func request(_ city: String) {
        networkWeatherManager.fetchCurrentWeatherManager(forCity: city) {[weak self] currentWeather in
            self?.currentСityWeather = currentWeather
            DispatchQueue.main.async {
                self?.updateInterfaceWith()
            }
        }
    }
    
    //  Выставление констрейнтов
    func exposingConstraint () {
        
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 80).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
        
        weatherIconImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor,constant: 10).isActive = true
        weatherIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherIconImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        weatherIconImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor,constant: 10).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        temperatureLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
        
}
    
    
}

