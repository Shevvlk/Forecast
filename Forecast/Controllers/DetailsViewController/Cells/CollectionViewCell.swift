

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var timeLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 35)
        label.text = "time"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 33)
        label.text = "temperatureLabel"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(tempLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        timeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 4).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 3).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -3).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        iconImageView.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor,constant: 8).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: self.tempLabel.topAnchor,constant: -8).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 3).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -3).isActive = true
        
        tempLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 3).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 3).isActive = true
        tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -4).isActive = true
    }

}
    
    

