
import UIKit

class СollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var cityWeatherHourly: [СityWeatherHourly]?
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.contentView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityWeatherHourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        
        let temp = cityWeatherHourly?[indexPath.row].temperature
        if let temp = temp, let icon = cityWeatherHourly?[indexPath.row].systemIconNameString, let dt = cityWeatherHourly?[indexPath.row].dtString {
        cell.tempLabel.text =  "\(Int(temp - 273))"
            cell.iconImageView.image = UIImage(systemName: icon)
            cell.timeLabel.text = dt
        }
//        cell.timeLabel = cityWeatherHourly?[indexPath.row].dtString
        cell.tempLabel.textAlignment = .center
        
        return cell
    }
    
    func settingParameters(cityWeatherHourly: [СityWeatherHourly]?) {
        self.cityWeatherHourly = cityWeatherHourly
        self.collectionView.reloadData()
    }
}

extension СollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 60, height: 90)
    }
}
