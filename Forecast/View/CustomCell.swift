//
//import UIKit
//import MapKit
//
//class NewPlaceImageTabelViewCell: UITableViewCell {
//    
//    private let mapView: MKMapView = {
//        let map =  MKMapView()
//        map.translatesAutoresizingMaskIntoConstraints = false
//        return map
//    }()
//
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        self.contentView.addSubview(mapView)
//        constraints ()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupMark () {
//        
//        let geocoder = CLGeocoder()
//        
//        guard let location = location else { return }
//        
//        geocoder.geocodeAddressString(location) { [weak self] (placemaks, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            guard let placemaks = placemaks else {return}
//            
//            let placemak = placemaks.first
//            
//            let annotation = MKPointAnnotation()
//            
//            annotation.title = ""
//            
//            guard let placemarkLocation = placemak?.location else {return}
//            
//            annotation.coordinate =  CLLocationCoordinate2D (latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
//            
//            self?.mapView.showAnnotations([annotation], animated: true)
//            
//            self?.mapView.selectAnnotation(annotation, animated: true )
//        }
//    }
//    
//    private func constraints () {
//        mapView.leftAnchor.constraint(equalTo:self.contentView.leftAnchor).isActive = true
//        mapView.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
//        mapView.rightAnchor.constraint(equalTo:self.contentView.rightAnchor).isActive = true
//        mapView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
//    }
//}
