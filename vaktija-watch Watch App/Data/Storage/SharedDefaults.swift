//
//  SharedDefaults.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 2. 6. 2025..
//

// Data/Storage/SharedDefaults.swift

import Foundation

struct SharedDefaults {
    static let suiteName = "group.ba.vaktija.shared"

    static var shared: UserDefaults? {
        return UserDefaults(suiteName: suiteName)
    }

    static func saveNextVakat(time: String, prayer: String, location: String) {
        print("Setting time - SAVE: ", time)
        print("Setting prayer: -- SAVE", prayer)
        print("Setting location: --SAVE", location)
        shared?.set(time, forKey: "nextVakatTime")
        shared?.set(prayer, forKey: "nextPrayerName")
        shared?.set(location, forKey: "selectedCityName")
    }

    static func loadNextVakat() -> (time: String, prayer: String, location: String) {
        let time = shared?.string(forKey: "nextVakatTime") ?? "--:--"
        let prayer = shared?.string(forKey: "nextPrayerName") ?? "N/A"
        let location = shared?.string(forKey: "selectedCityName") ?? "N/A"
        return (time, prayer, location)
    }
}
