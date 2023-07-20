//
//  MapInfoView.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 12/07/2023.
//


import UIKit
import MapKit
import FirebaseFirestoreSwift
import Firebase
import Foundation
import Contacts

class MapInfoView: UIView, MKMapViewDelegate {

    
    lazy var fullScreenButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        btn.backgroundColor = .darkGray
        return btn
    }()
    
    lazy var itineraryButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "point.filled.topleft.down.curvedto.point.bottomright.up"), for: .normal)
        btn.backgroundColor = .darkGray
        return btn
    }()
    
    
    let map: MKMapView = MKMapView()
    //let recognizer: UIGestureRecognizer = UIGestureRecognizer()
    
    var locationName: String?
    var location: CLLocationCoordinate2D?
    
    private var _isFullScreen = false
    
    public var isFullScreen: Bool {
        get { return _isFullScreen }
    }
    var fullScreenCompletion: () -> () = {}
    
    
    init() {
        super.init(frame: .zero)
        
        map.delegate = self
        
        addSubview(map)
        map.fillSuperview()
        
        let stack = map.stack(.vertical, views: fullScreenButton, itineraryButton, spacing: 1)
        
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 7
        stack.backgroundColor = .lightGray
        
        stack.anchor(
            top: map.safeAreaLayoutGuide.topAnchor,
            leading: map.safeAreaLayoutGuide.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .allSides(side: 10),
            size: .init(width: 30, height: 65))
        
        fullScreenButton.withHeight(height: 30)
        
        
        
        itineraryButton.addTarget(self, action: #selector(intineraryTarget), for: .touchUpInside)
        fullScreenButton.addTarget(self, action: #selector(fullScreenTarget), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func centerToLocation(_ location: GeoPoint, name: String, regionRadius: CLLocationDistance = 150)
    {
        let coord = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        self.location = coord
        self.locationName = name
        let coordinateRegion = MKCoordinateRegion(
            center: coord,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
        // Show artwork on map
        let artwork = Artwork(
          title: name,
          locationName: "",
          service: "",
          coordinate: coord)
        map.addAnnotation(artwork)
    }
    
    @objc func intineraryTarget(sender: Any?)
    {
        
        var mapItem: MKMapItem? {
            guard let location = locationName else {
                return nil
            }

            let addressDict = [CNPostalAddressStreetKey: location]
            let placemark = MKPlacemark(
                coordinate: self.location!,
                addressDictionary: addressDict)
            
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = self.locationName
            return mapItem
        }

        let launchOptions = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault,
        ]
        mapItem!.openInMaps(launchOptions: launchOptions)
    }
    
    @objc func fullScreenTarget(sender: Any?)
    {
        if _isFullScreen
        {
            fullScreenButton.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        }
        else
        {
            fullScreenButton.setImage(UIImage(systemName: "arrow.down.right.and.arrow.up.left"), for: .normal)
        }
        fullScreenCompletion()
        _isFullScreen = !_isFullScreen
    }
    
}

