//
//  BillBook_Widget.swift
//  BillBook-Widget
//
//  Created by Chao Feng on 2/2/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  
  typealias Entry = SimpleEntry
  typealias Intent = CycleCategoriesIntent
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), notification: "Placeholder")
  }
  
  func getSnapshot(for configuration: CycleCategoriesIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), notification: "2021-01-09")
    completion(entry)
  }
  
  func getTimeline(for configuration: CycleCategoriesIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    
    getCycleForWidget() { cycles in
      if let cycle = cycles.first {
        let entry = SimpleEntry(date: Date(), notification: "\(DateFormatter(for: configuration, date: cycle.date) )")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
      } else {
        let entry = SimpleEntry(date: Date(), notification: "Ah")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
      }
    }
    
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let notification: String
}

struct BillBook_WidgetEntryView : View {
  
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var family
  
  var body: some View {
    
    switch family {
    case .systemLarge:
      LargeView(entry: entry)
    case .systemMedium:
      MediumView(entry: entry)
    default:
      SmallView(entry: entry)
        .widgetURL(URL(string: "m0bb://tab=3"))
    }
  }
}

@main
struct BillBook_Widget: Widget {
  let kind: String = "BillBook_Widget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: CycleCategoriesIntent.self, provider: Provider()) { entry in
      BillBook_WidgetEntryView(entry: entry)
    }
    .configurationDisplayName("BillBook")
    .description("Choose a format that you prefer:")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
  }
}

struct BillBook_Widget_Previews: PreviewProvider {
  static var previews: some View {
    BillBook_WidgetEntryView(entry: SimpleEntry(date: Date(), notification: "2021-01-09"))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
