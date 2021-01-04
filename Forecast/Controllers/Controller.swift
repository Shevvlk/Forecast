//
//import UIKit
//
//
//class NewPlaceViewController: UITableViewController {
//    
//
//    var imageIsChanged = false
//    /Users/alexandr/Desktop/Мои приложения/Forecast/Forecast/Controllers/Controller.swift
//    let photoImageCell: NewPlaceImageTabelViewCell = NewPlaceImageTabelViewCell()
//    
//    let placeNameCell: NewPlaceInputTabelViewCell = {
//        let placeName = NewPlaceInputTabelViewCell()
//        placeName.labelDescription.text = "Name"
//        placeName.textFieldDescription.placeholder = "Place name"
//        return placeName
//    }()
//    
//    let placeLocationCell: NewPlaceInputTabelViewCell = {
//        let placeLocation = NewPlaceInputTabelViewCell()
//        placeLocation.labelDescription.text = "Location"
//        placeLocation.textFieldDescription.placeholder = "Place location"
//        return placeLocation
//    }()
//    
//    let placeTypeCell: NewPlaceInputTabelViewCell = {
//        let placeType = NewPlaceInputTabelViewCell()
//        placeType.labelDescription.text = "Type"
//        placeType.textFieldDescription.placeholder = "Place type"
//        return placeType
//    }()
//    
//    let labelTitle: UILabel = {
//        let label = UILabel()
//        label.text = "New places"
//        label.textColor = UIColor.black
//        label.font = UIFont(name: "Snell Roundhand", size: 32)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        photoImageCell.delegate = self
//        
//        self.view.backgroundColor = #colorLiteral(red: 0.9843270183, green: 0.9525683522, blue: 0.9402120709, alpha: 1)
//        
//        tableView.tableFooterView = UIView()
//        tableView.separatorInset.right = 15
//        tableView.showsVerticalScrollIndicator = false
//        
//        setupEditScreen()
//        
//        setUpNavigation()
//        
//        registerForTextFieldNotification()
//        
//        do {
//            realm = try Realm()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        removeForTextFieldNotification()
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        switch indexPath.row{
//        case 0:
//            return photoImageCell
//        case 1:
//            return placeNameCell
//        case 2:
//            return placeLocationCell
//        case 3:
//            return placeTypeCell
//        default:
//            fatalError("Unknown number of sections")
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 320
//        default:
//            return 75
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            callAlert()
//        }
//    }
//    
//    private func setupEditScreen() {
//        
//        if currentPlace != nil {
//            
//            imageIsChanged = true
//            
//            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
//            
//            photoImageCell.placeImageView.image = image
//            photoImageCell.placeImageView.contentMode = .scaleAspectFill
//            photoImageCell.placeImageView.clipsToBounds = true
//            placeNameCell.textFieldDescription.text = currentPlace?.name
//            placeLocationCell.textFieldDescription.text = currentPlace?.location
//            placeTypeCell.textFieldDescription.text = currentPlace?.type
//        }
//    }
//    
//    private func setUpNavigation () {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(returnMainViewController))
//        navigationController?.navigationBar.tintColor = .black
//        
//        if let _ = currentPlace {
//            labelTitle.text = placeNameCell.textFieldDescription.text
//            self.navigationItem.titleView = labelTitle
//            self.navigationItem.rightBarButtonItem?.isEnabled = true
//            
//        }
//        else {
//            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9843270183, green: 0.9525683522, blue: 0.9402120709, alpha: 1)
//            self.navigationItem.titleView = labelTitle
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(handleCansel))
//            self.navigationItem.rightBarButtonItem?.isEnabled = false
//        }
//    }
//    
//    func registerForTextFieldNotification() {
//        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification,
//                                               object:  placeNameCell.textFieldDescription, queue: nil)
//        { _ in
//            let textCount = self.placeNameCell.textFieldDescription.text?.count ?? 0
//            let textIsNotEmpty = textCount > 0
//            self.navigationItem.rightBarButtonItem?.isEnabled = textIsNotEmpty
//        }
//    }
//    
//    func removeForTextFieldNotification() {
//        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: placeNameCell.textFieldDescription)
//        
//    }
//    
//    @objc func returnMainViewController()  {
//        saveNewPlace()
//        if let _ = currentPlace {
//            navigationController?.popViewController(animated: true)
//        } else {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//    
//    @objc func handleCansel() {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    private func saveNewPlace() {
//        
//        var image: UIImage?
//        
//        if imageIsChanged {
//            image =  photoImageCell.placeImageView.image
//        } else {
//            image = #imageLiteral(resourceName: "camera")
//        }
//        
//        let imageData = image?.pngData()
//        let newPlace = Place(name: placeNameCell.textFieldDescription.text!,
//                             location: placeLocationCell.textFieldDescription.text,
//                             type: placeTypeCell.textFieldDescription.text,
//                             imageData: imageData)
//        
//        if let currentPlace = currentPlace {
//            storageManager.overstore(currentPlace, newPlace)
//            
//        } else {
//            storageManager.save(newPlace)
//        }
//    }
//}
