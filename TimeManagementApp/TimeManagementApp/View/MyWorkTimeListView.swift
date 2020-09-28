//
//  MyWorkTimeListView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/26.
//

import SwiftUI
import CoreData

struct MyWorkTimeListView: View {
    @Environment(\.managedObjectContext) var context
    var fetchRequest: FetchRequest<TimeRecord>
    var body: some View {
        ForEach(fetchRequest.wrappedValue) { item in
            NavigationLink(
                destination: Text("Destination"),
                label: {
                    WorkRecordRow(test: item)
                })
        }.onDelete(perform: deleteItems)
    }
    private func deleteItems(offsets: IndexSet) -> Void {
        withAnimation {
            offsets.map { fetchRequest.wrappedValue[$0] }.forEach(context.delete)
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct WorkRecordRow: View {
    let test:TimeRecord
    var body: some View {
        HStack {
            VStack {
                Text("\(test.strTime!)")
                Text("\(test.endTime!)")
            }
            Spacer()
            Text("\(test.eventTitle!)")
            Spacer()
        }
        
    }
}
