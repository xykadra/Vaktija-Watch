import SwiftUI

struct NotificationSettingsView: View {

    @EnvironmentObject var settings: SettingsManager
    

    let minutesOptions = [5, 10, 15, 20, 30, 60]

    var body: some View {
        Form {
            // Toggle section
            Section {
                Toggle(isOn: $settings.notificationsEnabled) {
                    Text("Notifikacije")
                }
            }

            // Time-before section
            if settings.notificationsEnabled {
                Section(header: Text("Vrijeme")) {
                    Picker("", selection: $settings.minutesBeforeNotification) {
                        ForEach(minutesOptions, id: \.self) { minute in
                            Text("\(minute) minuta prije")
                        }
                    }
                    .pickerStyle(.inline).labelsHidden()
                }
            }
        }
        .navigationTitle("Notifikacije")
    }
}

