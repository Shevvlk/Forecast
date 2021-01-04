
import UIKit

class SharePromptView: UIScrollView {
    
    let unitsLabel : UILabel = {
        let label = UILabel()
        label.text = "Единицы измерения"
        label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel : UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.font.withSize(18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let windSpeedLabel : UILabel = {
        let label = UILabel()
        label.text = "Скорость ветра"
        label.font.withSize(18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pressureLabel : UILabel = {
        let label = UILabel()
        label.text = "Давление"
        label.font.withSize(18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let precipitationLabel : UILabel = {
        let label = UILabel()
        label.text = "Осадки"
        label.font.withSize(18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let distanceLabel : UILabel = {
        let label = UILabel()
        label.text = "Расстояние"
        label.font.withSize(18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let temperatureSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl ( items : [ "Цельсий" , "Фаренгейт"] )
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.tintColor = UIColor.red
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let windSpeedSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl ( items : [ "км/ч", "миль/ч","м/с","Узел"] )
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.tintColor = UIColor.red
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let pressureSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl ( items : [ "гПа", "Дюймы","кПа","мм"] )
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.tintColor = UIColor.red
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let precipitationSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl ( items : [ "Миллиметры", "Дюймы"] )
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.tintColor = UIColor.red
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let distanceSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl ( items : [ "Километры", "Мили"] )
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.tintColor = UIColor.red
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    
    let frameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 6
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       

        self.backgroundColor = .white
        
        frameView.addSubview(temperatureLabel)
        frameView.addSubview(windSpeedLabel)
        frameView.addSubview(pressureLabel)
        frameView.addSubview(precipitationLabel)
        frameView.addSubview(distanceLabel)
        
        frameView.addSubview(temperatureSegmentedControl)
        frameView.addSubview(windSpeedSegmentedControl)
        frameView.addSubview(pressureSegmentedControl)
        frameView.addSubview(precipitationSegmentedControl)
        frameView.addSubview(distanceSegmentedControl)
        
        addSubview(frameView)
        createSubviews()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        
        temperatureLabel.topAnchor.constraint(equalTo: frameView.topAnchor,constant: 20).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        temperatureSegmentedControl.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor,constant: 17).isActive = true
        temperatureSegmentedControl.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        temperatureSegmentedControl.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        temperatureSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        windSpeedLabel.topAnchor.constraint(equalTo: temperatureSegmentedControl.bottomAnchor,constant: 20).isActive = true
        windSpeedLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        windSpeedLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        windSpeedLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        windSpeedSegmentedControl.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor,constant: 17).isActive = true
        windSpeedSegmentedControl.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        windSpeedSegmentedControl.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        windSpeedSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pressureLabel.topAnchor.constraint(equalTo: windSpeedSegmentedControl.bottomAnchor,constant: 20).isActive = true
        pressureLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        pressureLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        pressureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pressureSegmentedControl.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor,constant: 17).isActive = true
        pressureSegmentedControl.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        pressureSegmentedControl.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        pressureSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        precipitationLabel.topAnchor.constraint(equalTo: pressureSegmentedControl.bottomAnchor,constant: 20).isActive = true
        precipitationLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        precipitationLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        precipitationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        precipitationSegmentedControl.topAnchor.constraint(equalTo: precipitationLabel.bottomAnchor,constant: 17).isActive = true
        precipitationSegmentedControl.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        precipitationSegmentedControl.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        precipitationSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        distanceLabel.topAnchor.constraint(equalTo: precipitationSegmentedControl.bottomAnchor,constant: 20).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        distanceSegmentedControl.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor,constant: 17).isActive = true
        distanceSegmentedControl.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
        distanceSegmentedControl.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
        distanceSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        frameView.topAnchor.constraint(equalTo: self.topAnchor,constant: 20).isActive = true
        frameView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        frameView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        frameView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -30).isActive = true
        frameView.heightAnchor.constraint(equalToConstant: 480).isActive = true
        
    }
}
