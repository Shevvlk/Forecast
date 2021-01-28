
import UIKit

class DetailsView: UIView {
    
    let cityNameLabel: UILabel = {
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
    
    let container: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.systemBlue.cgColor
        container.layer.shadowOpacity = 6
        container.layer.shadowOffset = CGSize.zero
        container.layer.shadowRadius = 5
        container.backgroundColor = #colorLiteral(red: 0.5403655171, green: 0.8377107978, blue: 0.9760398269, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let feelsLikeTemperatureName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Feels like"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let feelsLikeTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pressureName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Pressure"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pressure: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidityName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Humidity"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidity: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let allName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "All"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let all: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let speedName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Wind speed"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let speed: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]

        self.layer.addSublayer(gradient)
        
        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        container.addSubview(feelsLikeTemperatureName)
        container.addSubview(feelsLikeTemperature)
        container.addSubview(pressureName)
        container.addSubview(pressure)
        container.addSubview(humidityName)
        container.addSubview(humidity)
        container.addSubview(allName)
        container.addSubview(all)
        container.addSubview(speedName)
        container.addSubview(speed)
        
        self.addSubview(cityNameLabel)
        self.addSubview(weatherIconImageView)
        self.addSubview(temperatureLabel)
        self.addSubview(container)
        
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupConstraints() {
        
        cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 70).isActive = true
        cityNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 30).isActive = true
        cityNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -30).isActive = true
        
        weatherIconImageView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor,constant: 10).isActive = true
        weatherIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weatherIconImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        weatherIconImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor,constant: 10).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        temperatureLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 30).isActive = true
        temperatureLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -30).isActive = true
        
        feelsLikeTemperatureName.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
        feelsLikeTemperatureName.leftAnchor.constraint(equalTo: container.leftAnchor,constant: 10).isActive = true
        feelsLikeTemperatureName.rightAnchor.constraint(equalTo: feelsLikeTemperature.rightAnchor,constant: -5).isActive = true
        feelsLikeTemperatureName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        feelsLikeTemperature.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
        feelsLikeTemperature.rightAnchor.constraint(equalTo: container.rightAnchor,constant: -10).isActive = true
        feelsLikeTemperature.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pressureName.topAnchor.constraint(equalTo: feelsLikeTemperatureName.bottomAnchor, constant: 10).isActive = true
        pressureName.leftAnchor.constraint(equalTo: container.leftAnchor,constant: 10).isActive = true
        pressureName.rightAnchor.constraint(equalTo: pressure.rightAnchor,constant: -5).isActive = true
        pressureName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pressure.topAnchor.constraint(equalTo:  feelsLikeTemperature.bottomAnchor, constant: 10).isActive = true
        pressure.rightAnchor.constraint(equalTo: container.rightAnchor,constant: -10).isActive = true
        pressure.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        humidityName.topAnchor.constraint(equalTo: pressureName.bottomAnchor, constant: 10).isActive = true
        humidityName.leftAnchor.constraint(equalTo: container.leftAnchor,constant: 10).isActive = true
        humidityName.rightAnchor.constraint(equalTo: pressure.rightAnchor,constant: -5).isActive = true
        humidityName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        humidity.topAnchor.constraint(equalTo:  pressure.bottomAnchor, constant: 10).isActive = true
        humidity.rightAnchor.constraint(equalTo: container.rightAnchor,constant: -10).isActive = true
        humidity.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        allName.topAnchor.constraint(equalTo: humidityName.bottomAnchor, constant: 10).isActive = true
        allName.leftAnchor.constraint(equalTo: container.leftAnchor,constant: 10).isActive = true
        allName.rightAnchor.constraint(equalTo: pressure.rightAnchor,constant: -5).isActive = true
        allName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        all.topAnchor.constraint(equalTo:  humidity.bottomAnchor, constant: 10).isActive = true
        all.rightAnchor.constraint(equalTo: container.rightAnchor,constant: -10).isActive = true
        all.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        speedName.topAnchor.constraint(equalTo: allName.bottomAnchor, constant: 10).isActive = true
        speedName.leftAnchor.constraint(equalTo: container.leftAnchor,constant: 10).isActive = true
        speedName.rightAnchor.constraint(equalTo: pressure.rightAnchor,constant: -5).isActive = true
        speedName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        speed.topAnchor.constraint(equalTo:  all.bottomAnchor, constant: 10).isActive = true
        speed.rightAnchor.constraint(equalTo: container.rightAnchor,constant: -10).isActive = true
        speed.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        let const = container.topAnchor.constraint(equalTo:  temperatureLabel.bottomAnchor, constant: 30)
        container.topAnchor.constraint(lessThanOrEqualTo: temperatureLabel.bottomAnchor, constant: 300).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100).isActive = true
        container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7).isActive = true
        container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7).isActive = true
        container.heightAnchor.constraint(equalToConstant:200).isActive = true
        
        speedName.topAnchor.constraint(equalTo: allName.bottomAnchor, constant: 10).isActive = true
        speedName.leftAnchor.constraint(equalTo: container.leftAnchor,constant: 10).isActive = true
        speedName.rightAnchor.constraint(equalTo: pressure.rightAnchor,constant: -5).isActive = true
        speedName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
}


extension UIView {
   
    func gradientOfView(withColours: UIColor...) {

        var cgColours = [CGColor]()

        for colour in withColours {
            cgColours.append(colour.cgColor)
        }
        
        let grad = CAGradientLayer()
        grad.frame = self.bounds
        grad.colors = cgColours
        self.layer.insertSublayer(grad, at: 0)
    }
    
}

