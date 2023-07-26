//
//  EnviroamerWidget.swift
//  EnviroamerWidget
//
//  Created by M Yogi Satriawan on 25/07/23.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

import WidgetKit
import SwiftUI
import CoreData

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
    typealias Entry = EnviroamerWidgetData

    func placeholder(in context: Context) -> EnviroamerWidgetData {
        EnviroamerWidgetData(date: Date(), totalCarbon: 0, startingDate: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (EnviroamerWidgetData) -> ()) {
        let entry = EnviroamerWidgetData(date: Date(), totalCarbon: 2.0, startingDate: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<EnviroamerWidgetData>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!

        // Fetch data from Core Data here and create the entry
        let trips = try? getData()
        let totalCarbon = trips?.reduce(0, { $0 + ($1.totalCarbonEmissions ) }) ?? 0.0

        let entry = EnviroamerWidgetData(date: currentDate, totalCarbon: totalCarbon, startingDate: trips?.first?.startDate ?? currentDate)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
    
    private func getData() -> [Trip] {
        let context = PersistenceController.shared.container.viewContext
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        do {
            let result = try context.fetch(request)
            print("Fetched Trips: \(result)")
            let totalCarbon = result.reduce(0, { $0 + ($1.totalCarbonEmissions ?? 0.0) })
            print("Total Carbon: \(totalCarbon)")
            return result
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

}

@main
struct EnviroamerWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        EnviroamerWidget()
    }
}
