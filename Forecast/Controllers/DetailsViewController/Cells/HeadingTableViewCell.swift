import UIKit

final class HeadingTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        //        label.font = UIFont.systemFont(ofSize: 35)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 33)
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(tempLabel)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 70).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 30).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -30).isActive = true
        
        iconImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        tempLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor,constant: 10).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        tempLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 30).isActive = true
        tempLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -30).isActive = true
    }
    
}

