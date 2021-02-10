
import UIKit


class DetailsTableViewCell: UITableViewCell {
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 35)
        label.numberOfLines = 2
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(cityNameLabel)
        self.contentView.addSubview(weatherIconImageView)
        self.contentView.addSubview(temperatureLabel)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        
        cityNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 70).isActive = true
        cityNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 30).isActive = true
        cityNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -30).isActive = true
        
        weatherIconImageView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor,constant: 10).isActive = true
        weatherIconImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        weatherIconImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        weatherIconImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor,constant: 10).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        temperatureLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 30).isActive = true
        temperatureLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -30).isActive = true
    }

}
