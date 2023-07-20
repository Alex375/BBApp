//
//  FindMapViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 10/07/2023.
//

import UIKit
import MapKit
import CoreLocation
import GeoFireUtils
import FirebaseAuth

class FindMapViewController: UIViewController {

    lazy var map: MKMapView = MKMapView()
    lazy var tableView: UITableView = UITableView()
    var mapButtons: FindMapButtons = FindMapButtons()
    
    let locationManager = CLLocationManager()
    private var sessions:[SessionEntity] = []
    private var currentLocation: CLLocationCoordinate2D?
    private var mapConstrains: AnchoredConstraints?
    private var user: UserEntity?
    
    private var isFullScreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "find.title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchCritria))
        
        view.backgroundColor = UIColor(named: "VCBackground")
        
        
        tableView.register(SlotTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 85
        
        
        setUpLocationMAnager()
        
        map.showsUserLocation = true
        map.delegate = self
        
        view.addSubview(map)
        mapConstrains = map.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        map.layer.cornerRadius = 15
        mapConstrains?.height = map.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        mapConstrains?.height!.isActive = true
        mapConstrains?.bottom = map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        map.addSubview(mapButtons)
        mapButtons.anchor(top: map.topAnchor, leading: map.leadingAnchor, bottom: nil, trailing: nil, padding: .allSides(side: 10), size: .init(width: 30, height: 65))
        mapButtons.fullScreenCompletion = presentFullScreen
        mapButtons.locationCompletion = centerToUser
        
        
        view.addSubview(tableView)
        tableView.anchor(top: map.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        getUser()
    }
    

    func presentFullScreen()
    {
        if isFullScreen
        {
            UIView.animate(withDuration: 0.5) { [self] in
                mapConstrains?.leading?.constant = 20
                mapConstrains?.trailing?.constant = -20
                mapConstrains?.top?.constant = 20
                mapConstrains?.height?.isActive = true
                mapConstrains?.bottom?.isActive = false
                mapButtons.fullScreenButton.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
                map.layer.cornerRadius = 15
                view.layoutIfNeeded()
            }
        }
        else
        {
            UIView.animate(withDuration: 0.5) { [self] in
                mapConstrains?.leading?.constant = 0
                mapConstrains?.trailing?.constant = 0
                mapConstrains?.top?.constant = 0
                mapConstrains?.height?.isActive = false
                mapConstrains?.bottom?.isActive = true
                mapButtons.fullScreenButton.setImage(UIImage(systemName: "arrow.down.right.and.arrow.up.left"), for: .normal)
                map.layer.cornerRadius = 0
                view.layoutIfNeeded()
            }
        }
        isFullScreen = !isFullScreen
    }


}


extension FindMapViewController: CLLocationManagerDelegate
{
    func centerToUser()
    {
        map.setCenter(map.userLocation.coordinate, animated: true)
    }
    
    func setUpLocationMAnager()
    {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        navigationItem.title = "find.title".localized
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        }
//        else
//        {
//            let alert = UIAlertController(title: "Error", message: "Location not enabled.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location?.coordinate else {
            let alert = UIAlertController(title: "Error", message: "Failed to get location.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.map.setCenter(locValue, animated: true)
        self.constraintsRange(location: locValue)
        self.centerToLocation(locValue)
        getNearSessions(center: locValue, radius: 10000, sport: 0) { sessions, error in
            if let error = error {
                let alert = UIAlertController(title: "Error getting near session", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
            self.sessions = self.sessionPrefilter(session: sessions)
            self.markUpSessions()
            self.locationManager.stopUpdatingLocation()
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.currentLocation = locValue
            self.tableView.reloadData()
        }
    }
    
    func sessionPrefilter(session: [SessionEntity]) -> [SessionEntity]
    {
        guard let user = user else {
            getUser()
            return session
        }
        let filteredSession = session.filter { session in
            return session.startTime.dateValue() > Date.now
        }
        return filteredSession
    }
    
    func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 3000)
    {
        let coordinateRegion = MKCoordinateRegion(
            center: location,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func topCenterCoordinate() -> CLLocationCoordinate2D {
        return map.convert(CGPoint(x: map.frame.size.width / 2.0, y: 0), toCoordinateFrom: map)
    }

    func currentRadius() -> Double {
        let centerLocation = CLLocation(latitude: map.centerCoordinate.latitude, longitude: map.centerCoordinate.longitude)
        let topCenterCoordinate = self.topCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        return centerLocation.distance(from: topCenterLocation)
    }
    
    @objc func refresh(sender: Any?)
    {
//        if CLLocationManager.locationServicesEnabled()
//        {
        navigationItem.leftBarButtonItem?.isEnabled = false
        locationManager.startUpdatingLocation()
//        }
    }
    
    func getUser()
    {
        if Auth.auth().currentUser == nil
        {
//            let vc = LoginViewController()
//            vc.isModalInPresentation = true
//            self.present(
//                LoginNavVCViewController(rootViewController: vc),
//                animated: true,
//                completion: nil)
            return
        }
        getUserEntity { user, error in
            if let err = error {
                presentBasicAlert(on: self, title: "Error", message: err.localizedDescription)
                self.locationManager.stopUpdatingLocation()
                return
            }
            self.user = user ?? nil
            self.locationManager.startUpdatingLocation()
        }
    }
}

extension FindMapViewController: MKMapViewDelegate
{
    func markUpSessions()
    {
        for annot in map.annotations
        {
            map.removeAnnotation(annot)
        }
        for session in sessions
        {
            let annotation = SessionAnotation(session: session)
            map.addAnnotation(annotation)
        }
    }
    
    
    func constraintsRange(location: CLLocationCoordinate2D)
    {
        let region = MKCoordinateRegion(
              center: location,
              latitudinalMeters: 50000,
              longitudinalMeters: 60000)
        
        map.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        map.setCameraZoomRange(zoomRange, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SessionAnotation else {
            return nil
        }
        
        let id = "id"
        let view: MKMarkerAnnotationView
        
        if let dequeuView = map.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView
        {
            dequeuView.annotation = annotation
            view = dequeuView
        }
        else
        {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: -5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? SessionAnotation else {
            return
        }
        let vc = FindDetailTableViewController()
        vc.user = self.user
        vc.session = annotation.session
        present(UINavigationController(rootViewController: vc), animated: true)
        return
    }
    
    
}


extension FindMapViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SlotTableViewCell
        
        let session = sessions[indexPath.row]
        let sessionLocation = session.location.geoPoint
        
        
        var distance: String? = nil
        if let currentLocation = currentLocation
        {
            let dist = GFUtils.distance(from: CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude), to: CLLocation(latitude: sessionLocation.latitude, longitude: sessionLocation.longitude))
            
            let distanceFormater = MKDistanceFormatter()
            
            distance = distanceFormater.string(fromDistance: dist)
        }
        
        
        let title = (distance ?? "")
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE, dd MMM HH:mm"
        let date = session.startTime.dateValue()
        let dateFormated = dateFormatter.string(from: date)
        cell.slotView.dateLabel.text = dateFormated
        
        cell.slotView.nameLabel.text = title
        
        cell.slotView.donationImage.imageView.image = UIImage(named: "AppIcon")
        cell.slotView.donationImage.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FindDetailTableViewController()
        vc.user = self.user
        vc.session = sessions[indexPath.row]
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
