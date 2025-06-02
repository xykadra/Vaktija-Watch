//
//  QiblaViewModel.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 2. 6. 2025..
//

import Foundation
import CoreLocation
import Combine
import WatchKit

class QiblaViewModel: ObservableObject {
    private let locationService = LocationService()
    private let headingService = HeadingService()
    private let qiblaUseCase = CalculateQiblaDirectionUseCase()
    
    @Published var qiblaDirection: Double = 0.0
    @Published var heading: Double = 0.0 {
        didSet {
            handleFeedback()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var hasPlayedSuccess = false

    init() {
        locationService.$currentLocation
            .compactMap { $0 }
            .sink { [weak self] location in
                guard let self = self else { return }
                self.qiblaDirection = self.qiblaUseCase.execute(from: location)
            }
            .store(in: &cancellables)

        headingService.$heading
            .compactMap { $0 }
            .sink { [weak self] heading in
                self?.heading = heading.trueHeading
            }
            .store(in: &cancellables)
    }

    var rotationAngle: Double {
        let angle = qiblaDirection - heading
        return angle < -180 ? angle + 360 : (angle > 180 ? angle - 360 : angle)
    }

    private func handleFeedback() {
        let angle = abs(rotationAngle)
        let isAligned = angle < 10

        if isAligned && !hasPlayedSuccess {
            WKInterfaceDevice.current().play(.success) // Bing sound + haptic
            hasPlayedSuccess = true
        } else if !isAligned {
            WKInterfaceDevice.current().play(.directionUp) // Subtle haptic feedback
            hasPlayedSuccess = false
        }
    }
}

