//
//  EnviroamerWidget.swift
//  EnviroamerWidget
//
//  Created by M Yogi Satriawan on 25/07/23.
//


import WidgetKit
import SwiftUI
import CoreData
import Enviroamer



struct EnviroamerWidgetData: TimelineEntry {
    let date: Date
    let totalCarbon: Double
    let startingDate: Date
}

struct EnviroamerWidget: Widget {
    private let kind: String = "EnviroamerWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EnviroamerWidgetView(entry: entry)
        }
        .configurationDisplayName("Enviroamer Widget")
        .description("Widget to display total carbon and starting date.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct EnviroamerWidgetView: View {
    var entry: EnviroamerWidgetData

    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Carbon: \(entry.totalCarbon, specifier: "%.2f") kg")
                .font(.headline)
            Text("Starting Date: \(entry.startingDate, style: .date)")
                .font(.subheadline)
        }
        .padding()
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> EnviroamerWidgetData {
        EnviroamerWidgetData(date: Date(), totalCarbon: 0, startingDate: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (EnviroamerWidgetData) -> Void) {
        let entry = EnviroamerWidgetData(date: Date(), totalCarbon: 10.5, startingDate: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<EnviroamerWidgetData>) -> Void) {
        // Fetch data and update the timeline with new data
        // For this example, we will use a placeholder data
        let entry = EnviroamerWidgetData(date: Date(), totalCarbon: 10.5, startingDate: Date())
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

//@main
//struct EnviroamerWidgetBundle: WidgetBundle {
//    var body: some Widget {
//        EnviroamerWidget()
//    }
//}


//struct EnviroamerWidgetData: TimelineEntry {
//    let date: Date
//    let totalCarbon: Double
//    let startingDate: Date
//    let provinceName: String
//}
//
//struct EnviroamerWidget: Widget {
//    private let kind: String = "EnviroamerWidget"
//
//    public var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            EnviroamerWidgetView(entry: entry)
//        }
//        .configurationDisplayName("Enviroamer Widget")
//        .description("Widget to display total carbon and starting date.")
//        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
//    }
//}
//
//struct EnviroamerWidgetView: View {
//    var entry: EnviroamerWidgetData
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Province: \(entry.provinceName)")
//                .font(.headline)
//            Text("Total Carbon: \(entry.totalCarbon, specifier: "%.2f") kg")
//                .font(.subheadline)
//            Text("Starting Date: \(entry.startingDate, style: .date)")
//                .font(.subheadline)
//        }
//        .padding()
//    }
//}
//
//struct Provider: TimelineProvider {
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Trip.startDate, ascending: true)],
//        animation: .default)
//    private var trips: FetchedResults<Trip>
//
//    func placeholder(in context: Context) -> EnviroamerWidgetData {
//        let firstTrip = trips.first
//        return EnviroamerWidgetData(date: Date(), totalCarbon: firstTrip?.totalCarbonEmissions ?? 0, startingDate: firstTrip?.startDate ?? Date(), provinceName: firstTrip?.provinceName ?? "")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (EnviroamerWidgetData) -> Void) {
//        let firstTrip = trips.first
//        let entry = EnviroamerWidgetData(date: Date(), totalCarbon: firstTrip?.totalCarbonEmissions ?? 0, startingDate: firstTrip?.startDate ?? Date(), provinceName: firstTrip?.provinceName ?? "")
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<EnviroamerWidgetData>) -> Void) {
//        // Fetch data and update the timeline with new data
//        // For this example, we will use a placeholder data
//        let firstTrip = trips.first
//        let entry = EnviroamerWidgetData(date: Date(), totalCarbon: firstTrip?.totalCarbonEmissions ?? 0, startingDate: firstTrip?.startDate ?? Date(), provinceName: firstTrip?.provinceName ?? "")
//        let timeline = Timeline(entries: [entry], policy: .atEnd)
//        completion(timeline)
//    }
//}
//
