//
//  ActibityFormView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/27.
//


import SwiftUI
import CoreData

struct ActibityFormView: View {
    @FetchRequest(
        entity: TimeRecord.entity(),
        sortDescriptors: [NSSortDescriptor(key: "strDay", ascending: true)],
        animation: .default)
    var record: FetchedResults<TimeRecord>
    
    @State var selectionDate = Date()
    
    var body: some View {
        Form {
            Section(header: Text("表示項目").font(.headline)){
                DatePicker("日付を選択", selection: $selectionDate, displayedComponents: .date)
            }
            Section(header: Text("記録").font(.headline)){
                MyWorkTimeListView(fetchRequest: makeFetchRequest(choseDays: selectionDate))
            }
        }
    }
    
}

struct ActibityFormView_Previews: PreviewProvider {
    static var previews: some View {
        ActibityFormView().environment(\.managedObjectContext, TimeRecordPersistenceViewModel.preview.container.viewContext)
    }
}
