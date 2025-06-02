//
//  HeadingService.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 2. 6. 2025..
//

import Foundation
import CoreLocation

class HeadingService: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var heading: CLHeading?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
    }
}
