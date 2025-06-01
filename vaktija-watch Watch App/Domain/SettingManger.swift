//
//  SettingManger.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 1. 6. 2025..
//

import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    
    static let shared = SettingsManager()
    
    @Published var city: City?
    
    @Published var selectedCityIndex: Int {
        didSet {
            UserDefaults.standard.set(selectedCityIndex, forKey: "selectedCityIndex")
        }
    }

    @Published var selectedCityName: String {
        didSet {
            UserDefaults.standard.set(selectedCityName, forKey: "selectedCityName")
        }
    }

    @Published var notificationsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
        }
    }

    @Published var minutesBeforeNotification: Int {
        didSet {
            UserDefaults.standard.set(minutesBeforeNotification, forKey: "minutesBeforeNotification")
        }
    }

    init() {
        // Load from UserDefaults or use defaults
        self.selectedCityIndex = UserDefaults.standard.integer(forKey: "selectedCityIndex")
        self.selectedCityName = UserDefaults.standard.string(forKey: "selectedCityName") ?? "Sarajevo"
        self.notificationsEnabled = UserDefaults.standard.object(forKey: "notificationsEnabled") as? Bool ?? true
        self.minutesBeforeNotification = UserDefaults.standard.integer(forKey: "minutesBeforeNotification")
        if self.minutesBeforeNotification == 0 {
            self.minutesBeforeNotification = 10
        }
    }
}

