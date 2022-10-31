//
//  Partner.swift
//  Partner
//
//  Created by Saamer Mansoor on 2/16/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct PartnerEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        switch family {
        case .systemMedium:
            MediumWidgetView()
        case .systemSmall:
            SmallWidgetView()
        case .systemLarge:
            MediumWidgetView()
        case .systemExtraLarge:
            MediumWidgetView()
        case .accessoryCircular:
            AccessoryCircleView()
        case .accessoryRectangular:
            AccessoryRectangularView()
        case .accessoryInline:
            InlineWidgetView()
        @unknown default:
            EmptyView()
        }        
    }
}

@main
struct Partner: Widget {
    let kind: String = "Partner"
    let supportedFamilies:[WidgetFamily] = {
        if #available(iOSApplicationExtension 16.0, *) {
            return [.systemMedium, .systemSmall, .accessoryInline, .accessoryCircular, .accessoryRectangular]
        } else {
            return [.systemMedium]
        }
    }()

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            PartnerEntryView(entry: entry)
        }
        .configurationDisplayName("BeAware Widget")
        .supportedFamilies(supportedFamilies)
        .description("This widget displays the current status of the noise alert and speech transcription")
    }
}

struct Partner_Previews: PreviewProvider {
    static var previews: some View {
        PartnerEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
