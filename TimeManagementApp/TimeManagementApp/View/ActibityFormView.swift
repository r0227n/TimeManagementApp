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
    
    @State private var selectionDate = Date()
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("表示項目").font(.headline)){
                    DatePicker("日付を選択", selection: $selectionDate, displayedComponents: .date)
                }
                Section(header: Text("記録").font(.headline)){
                    MyWorkTimeListView(fetchRequest: makeFetchRequest(choseDays: selectionDate))
                }
            }
            .navigationTitle("記録画面")
            .navigationBarItems(trailing: EditButton())
            Button(action: {
                showingSheet.toggle()
            }, label: {
                HStack {
                    Image(systemName: "note.text.badge.plus")
                    Text("記録を追加")
                }.padding(10)
            })
            .sheet(isPresented: $showingSheet,onDismiss: {print("画面を閉じた")}) {
                AddNewWorkTimeView(addStartDay: $selectionDate)
            }
        }
    }
}

struct ActibityFormView_Previews: PreviewProvider {
    static var previews: some View {
        ActibityFormView().environment(\.managedObjectContext, TimeRecordPersistenceViewModel.preview.container.viewContext)
    }
}
