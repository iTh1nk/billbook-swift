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
    let entry = SimpleEntry(date: Date(), notification: "Snapshot")
    completion(entry)
  }
  
  func getTimeline(for configuration: CycleCategoriesIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    //    var entries: [SimpleEntry] = []
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//    let currentDate = Date()
    //    for hourOffset in 0 ..< 5 {
    //      let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
    //      let entry = SimpleEntry(date: entryDate, configuration: configuration)
    //      entries.append(entry)
    //    }
    
    getCycleForWidget() { cycles in
      if let cycle = cycles.first {
        let entry = SimpleEntry(date: Date(), notification: "Latest Cycle:\n \(cycle.date)")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
      } else {
        let entry = SimpleEntry(date: Date(), notification: "Ah")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
      }
    }
    
//    let timeline = Timeline(entries: entries, policy: .atEnd)
//    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
//  let configuration: ConfigurationIntent
  let notification: String
}

struct BillBook_WidgetEntryView : View {
  
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
//      Text(entry.date, style: .time)
      Color(red: 215/255, green: 63/255, blue: 12/255)
      Text(entry.notification)
        .bold()
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
    .description("Choose a cycle to show content")
  }
}

struct BillBook_Widget_Previews: PreviewProvider {
  static var previews: some View {
    BillBook_WidgetEntryView(entry: SimpleEntry(date: Date(), notification: "Preview"))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
