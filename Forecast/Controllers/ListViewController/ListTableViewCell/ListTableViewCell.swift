
import UIKit


class ListTableViewCell: UITableViewCell {
    
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
        label.font = UIFont(name: "Geeza Pro", size: 18)
        label.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro", size: 11)
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Geeza Pro", size: 20)
        label.textColor =  #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(cityNameLabel)
        containerView.addSubview(dateLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(containerView)
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
        
        cityNameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 7).isActive = true
        cityNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        cityNameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo:self.cityNameLabel.lastBaselineAnchor,constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor, constant: -6).isActive = true
        
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.weatherImageView.trailingAnchor, constant: 10 ).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.temperatureLabel.leadingAnchor, constant: -25).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -10).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
    }
}
