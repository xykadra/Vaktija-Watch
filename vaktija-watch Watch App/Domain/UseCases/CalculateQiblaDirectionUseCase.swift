//
//  CalculateQiblaDirectionUseCase.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 2. 6. 2025..
//

import Foundation
import CoreLocation

struct CalculateQiblaDirectionUseCase {
    private let qiblaLatitude = 21.4225
    private let qiblaLongitude = 39.8262

    func execute(from userLocation: CLLocation) -> Double {
        let userLat = degreesToRadians(userLocation.coordinate.latitude)
        let userLon = degreesToRadians(userLocation.coordinate.longitude)
        let qiblaLat = degreesToRadians(qiblaLatitude)
        let qiblaLon = degreesToRadians(qiblaLongitude)

        let deltaLon = qiblaLon - userLon

        let y = sin(deltaLon)
        let x = cos(userLat) * tan(qiblaLat) - sin(userLat) * cos(deltaLon)
        let bearing = atan2(y, x)
        let bearingDegrees = radiansToDegrees(bearing)
        return fmod((bearingDegrees + 360.0), 360.0)
    }
}
