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

struct BillBook_WidgetEntryView : View {
  
  var entry: Provider.Entry
  @State var cycles: [Cycle] = []
  @EnvironmentObject var enObj: EnObj
  
  var body: some View {
    VStack {
      Text(entry.date, style: .time)
      List(cycles) { cycle in
        HStack {
          Image(systemName: "doc.plaintext")
          Text(cycle.date)
        }
      }
      .contentShape(Rectangle())
      .listStyle(SidebarListStyle())
    }
    .onAppear{
      ApiCycle().getCycle(enObj: enObj) { (cycles) in
        self.cycles = cycles
      }
    }
  }
}

@main
struct BillBook_Widget: Widget {
  let kind: String = "BillBook_Widget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      BillBook_WidgetEntryView(entry: entry)
    }
    .configurationDisplayName("BillBook")
    .description("This is an example widget.")
  }
}

struct BillBook_Widget_Previews: PreviewProvider {
  static var previews: some View {
    BillBook_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
