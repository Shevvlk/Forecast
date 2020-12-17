
import UIKit

class ViewController: UIViewController {
    
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
    
    let searchButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "magnifyingglass.circle")?.withTintColor(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        view.addSubview(cityLabel)
        view.addSubview(weatherIconImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(searchButton)
        exposingConstraint ()
     
        searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        
        networkWeatherManager.onCompletion = {  [unowned self] currentWeather in
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        networkWeatherManager.fetchCurrentWeatherManager(forCity: "Moscow")
    }
    
    func updateInterfaceWith (weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        }
    }
    
    @objc func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeatherManager(forCity: city)
        }
    }
    
    //  Выставление констрейнтов
    func exposingConstraint () {
        
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 50).isActive = true
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
        
        
        searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        searchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
}

