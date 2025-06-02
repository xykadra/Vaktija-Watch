import Foundation
import UserNotifications
import Combine

class VakatViewModel: ObservableObject {
    @Published var vakatTime: VakatTime?
    @Published var currentDate = Date()
    
    private let service = VakatAPIService()
    private var timer: AnyCancellable?
    
    private let settings: SettingsManager
    
    init(settings: SettingsManager){
        self.settings = settings
    }
    
    
    func loadVakat(for cityIndex: Int) {
        service.fetchVakat(for: cityIndex) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let vakat):
                    self?.vakatTime = vakat
                    self?.scheduleNotifications(for: vakat)
                    self?.startTimer()

                    // === Save data for Complication ===
                    let now = Date()
                    let formatter = Self.formatter // assumed: "HH:mm"
                    let calendar = Calendar.current

                    // Find next vakat time by converting string to Date
                    let nextIndex = vakat.vakats.firstIndex { vakatString in
                        guard let vakatDate = formatter.date(from: vakatString) else { return false }

                        // Combine today's date with vakat time
                        let fullVakatDate = calendar.date(
                            bySettingHour: calendar.component(.hour, from: vakatDate),
                            minute: calendar.component(.minute, from: vakatDate),
                            second: 0,
                            of: now
                        )

                        return fullVakatDate != nil && fullVakatDate! >= now
                    } ?? vakat.vakats.count - 1 // fallback to last vakat

                    let prayerNames = ["Zora", "Izlazak", "Podne", "Ikindija", "Akšam", "Jacija"]

                    let time = vakat.vakats[nextIndex]
                    let prayer = prayerNames[nextIndex]
                    print("Setting time: ", time)
                    print("Setting prayer: ", prayer)
                    print("Setting location: ", vakat.location)
                    SharedDefaults.saveNextVakat(
                        time: time,
                        prayer: prayer,
                        location: vakat.location
                    )

                case .failure(let error):
                    print("Error fetching vakat: \(error)")
                }
            }
        }
    }

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] now in
                self?.currentDate = now
            }
    }
    
    func timeRemaining(for timeString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        guard let vakatTime = formatter.date(from: timeString) else { return nil }
        
        let calendar = Calendar.current
        let now = currentDate
        let nowComponents = calendar.dateComponents([.year, .month, .day], from: now)
        let vakatComponents = calendar.dateComponents([.hour, .minute], from: vakatTime)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = nowComponents.year
        combinedComponents.month = nowComponents.month
        combinedComponents.day = nowComponents.day
        combinedComponents.hour = vakatComponents.hour
        combinedComponents.minute = vakatComponents.minute
        
        guard let fullDate = calendar.date(from: combinedComponents) else { return nil }
        
        let remaining = fullDate.timeIntervalSince(now)
        
        if remaining < 0 { return nil }
        
        let hours = Int(remaining) / 3600
        let minutes = (Int(remaining) % 3600) / 60
        let seconds = Int(remaining) % 60
        
        return String(format: "za %02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func currentVakatIndex(vakats: [String]) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let calendar = Calendar.current
        let now = Date()
        let today = calendar.startOfDay(for: now)
        
        var vakatDates: [Date] = []
        
        for timeString in vakats {
            if let time = formatter.date(from: timeString) {
                let components = calendar.dateComponents([.hour, .minute], from: time)
                if let date = calendar.date(bySettingHour: components.hour ?? 0, minute: components.minute ?? 0, second: 0, of: today) {
                    vakatDates.append(date)
                }
            }
        }
        
        // Find the last vakat time that is before or equal to now
        for (index, vakatDate) in vakatDates.enumerated().reversed() {
            if now >= vakatDate {
                return index
            }
        }
        
        // If current time is before the first vakat, return the last vakat (from previous day)
        return vakatDates.indices.last
    }
    
    
    private func scheduleNotifications(for vakat: VakatTime) {
        
        guard settings.notificationsEnabled else{
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            return
        }
        
        let minutesBefore = settings.minutesBeforeNotification
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else { return }
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            for time in vakat.vakats {
                let components = time.split(separator: ":")
                guard let hour = Int(components[0]),
                      let minute = Int(components[1]) else { continue }
                
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                dateComponents.hour = hour
                dateComponents.minute = minute - minutesBefore
                
                // Handle underflow
                if dateComponents.minute! < 0 {
                    dateComponents.minute! += 60
                    dateComponents.hour! -= 1
                }
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
                let content = UNMutableNotificationContent()
                content.title = "Vaktija Reminder"
                content.body = "Prayer time is in \(minutesBefore) minutes."
                content.sound = UNNotificationSound.defaultCritical
                
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                
                UNUserNotificationCenter.current().add(request)
            }
        }}
    
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "H:mm"
        return f
    }()
}

