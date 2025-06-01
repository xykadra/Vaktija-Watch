import SwiftUI

struct NotificationSettingsView: View {
    @State private var notificationsEnabled = true
    @State private var selectedMinutesBefore = 10

    let minutesOptions = [5, 10, 15, 20, 30, 60]

    var body: some View {
        Form {
            // Toggle section
            Section {
                Toggle(isOn: $notificationsEnabled) {
                    Text("Notifikacije")
                }
            }

            // Time-before section
            if notificationsEnabled {
                Section(header: Text("Vrijeme")) {
                    Picker("", selection: $selectedMinutesBefore) {
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

