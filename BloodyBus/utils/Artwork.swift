//
//  Artwork.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 12/07/2023.
//


import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let service: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    service: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.service = service
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}

