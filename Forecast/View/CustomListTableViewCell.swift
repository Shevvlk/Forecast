
import UIKit


class CustomListTableViewCell: UITableViewCell {
    
    /// Метка ячейки
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Заголовок
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro", size: 23)
        label.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro", size: 23)
        label.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
        constraints ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func constraints () {
        weatherImageView.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant: 10).isActive = true
        weatherImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,constant: 10).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        weatherImageView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        
        cityNameLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        cityNameLabel.leadingAnchor.constraint(equalTo:self.weatherImageView.trailingAnchor, constant: 10).isActive = true
        cityNameLabel.trailingAnchor.constraint(equalTo:self.temperatureLabel.leadingAnchor, constant: -5).isActive = true
        cityNameLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
        
    }
}
