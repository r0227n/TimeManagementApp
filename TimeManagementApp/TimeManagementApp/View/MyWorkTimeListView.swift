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
                    Text("\(item.eventTitle!)")
                })
        }
    }
}
