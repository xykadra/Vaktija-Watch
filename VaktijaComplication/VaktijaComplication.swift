// Complications/VakatijaComplication.swift

import WidgetKit
import SwiftUI

    
struct VakatEntry: TimelineEntry {
    let date: Date
    let vakatTime: String
    let prayerName: String
    let location: String
}

struct VakatProvider: TimelineProvider {
    func placeholder(in context: Context) -> VakatEntry {
        VakatEntry(date: Date(), vakatTime: "13:00", prayerName: "Podne", location: "Sarajevo")
    }

    func getSnapshot(in context: Context, completion: @escaping (VakatEntry) -> Void) {
        let data = SharedDefaults.loadNextVakat()
        let entry = VakatEntry(date: Date(), vakatTime: data.time, prayerName: data.prayer, location: data.location)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VakatEntry>) -> Void) {
        let data = SharedDefaults.loadNextVakat()
        let entry = VakatEntry(date: Date(), vakatTime: data.time, prayerName: data.prayer, location: data.location)
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!

        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct VakatEntryView: View {
    var entry: VakatEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.orange)
                    
                    Text(entry.prayerName)
                        .font(.headline)
                        .lineLimit(1)
                }
                
                Text(entry.vakatTime)
                    .font(.title2)
                    .bold()
            }
        }
        .padding(8) // Inner padding on the container
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(8) // Optional: rounded corners for container
        
    }
    
    @main
    struct VaktijaComplication: Widget {
        let kind: String = "VaktijaComplication"
        
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: VakatProvider()) { entry in
                VakatEntryView(entry: entry)
            }
            .configurationDisplayName("Sljedeći Vakat")
            .description("Vrijeme, naziv i lokacija sljedećeg vakta.")
            .supportedFamilies([.accessoryRectangular])
        }
    }
    
}
