//
//  SessionAnnotation.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 11/07/2023.
//

import Foundation
import MapKit

class SessionAnotation: NSObject, MKAnnotation
{
    let session: SessionEntity
    
    init(session: SessionEntity) {
        self.session = session
        
        super.init()
    }
    
    var subtitle: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE, dd MMM HH:mm"
        let dateFormated = dateFormatter.string(from: session.startTime.dateValue())
        return dateFormated
    }
    
    var title: String? {
        return "Donation"
    }
    
    var coordinate: CLLocationCoordinate2D
    {
        return session.location.toCoordinate()
    }
    
    
}
