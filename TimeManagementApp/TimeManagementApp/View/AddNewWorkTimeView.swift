//
//  AddNewWorkTimeView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/28.
//

import SwiftUI

class AddEventData: ObservableObject {
    @Published var title = ""
    @Published var sTime = Date()
    @Published var eDay = Date()
    @Published var eTime = Date()
    @Published var memo = ""
}

struct AddNewWorkTimeView: View {
    @Binding var addStartDay:Date
    @ObservedObject var addEvent = AddEventData()
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
                Spacer()
                Button(action: {
                    //AddNewRecord()
                }, label: {
                    Text("追加")
                        .foregroundColor(.white)
                        .background(Color.blue)
                })
            }.padding(15)
            Form {
                Section(header: Text("イベント名").font(.headline)){
                    TextField("追加するイベントの名前を入力してください。", text: $addEvent.title)
                }
                Section(header: Text("開始日時").font(.headline)){
                    DatePicker("", selection: $addStartDay, displayedComponents: .date)
                    DatePicker("", selection: $addEvent.sTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("終了日時").font(.headline)){
                    DatePicker("", selection: $addEvent.eDay, displayedComponents: .date)
                    DatePicker("", selection: $addEvent.eTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("メモ").font(.headline)){
                    TextEditor(text: $addEvent.memo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("HelveticaNeue", size: 13))
                        .lineSpacing(5)
                }
            }.navigationBarItems(trailing: Text("test"))
        }
    }
    func AddNewRecord(dayStart:String,timeStart:String,timeEnd:String,timeWork:String,titleEvent:String,memoEvent:String) {
        let newTimeRecord = TimeRecord(context: context)
        newTimeRecord.strDay = dayStart
        newTimeRecord.strTime = timeStart
        newTimeRecord.endTime = timeEnd
        newTimeRecord.wrkTime = timeWork
        newTimeRecord.eventTitle = titleEvent
        newTimeRecord.eventMemo = memoEvent
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddNewWorkTimeView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewWorkTimeView(addStartDay: .constant(Date()))
    }
}
