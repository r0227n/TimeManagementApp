//
//  TimeRecordView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/13.
//  Copyright © 2020 RyoNishimura. All rights reserved.
//

import SwiftUI

struct TimeRecordView: View {
    @EnvironmentObject var viewModel: RecordViewModel
    
    @State var checkTheEnd = false
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView{
            VStack {
                Text(viewModel.eventTitle)
                Spacer()
                Text(timeFomatter(iHour: viewModel.elapsedHour,
                                  iMinute: viewModel.elapsedMinute,
                                  iSeconds: viewModel.elapsedSecond))
                .onReceive(timer) { _ in
                    if(viewModel.timeViewSwitch == 2){
                        viewModel.elapsedSecond += 1
                        // 秒→分
                        if(viewModel.elapsedSecond > 59){
                            viewModel.elapsedSecond = 0
                            viewModel.elapsedMinute += 1
                        }
                        // 分→時
                        if(viewModel.elapsedMinute > 59){
                            viewModel.elapsedMinute = 0
                            viewModel.elapsedHour += 1
                        }
                    }
                }

                Spacer()

                Image(systemName: "pause.circle.fill")
                    .foregroundColor(Color.black)
                    .font(.system(size: 90))
                    .onTapGesture {
                        viewModel.timeViewSwitch = 3
                        let eventEndTime = EventEndTime.singleton
                        eventEndTime.eMonth = Calendar.current.component(.month, from: Date())
                        eventEndTime.eDay = Calendar.current.component(.day, from: Date())
                        eventEndTime.eHour = Calendar.current.component(.hour, from: Date())
                        eventEndTime.eMinute = Calendar.current.component(.minute, from: Date())
                        eventEndTime.eSecond = Calendar.current.component(.second, from: Date())
                    }
                    .onLongPressGesture {
                        checkTheEnd = true
                    }
                    .actionSheet(isPresented: $checkTheEnd) {
                        ActionSheet(title: Text("記録を中止しますか？"), message: Text("記録していたデータが削除されますがよろしいですか？"),
                                    buttons:
                                        [
                                            .destructive(Text("記録を中断"),
                                                         action: {
                                                            viewModel.eventTitle = ""
                                                            viewModel.elapsedHour = 0
                                                            viewModel.elapsedMinute = 0
                                                            viewModel.elapsedSecond = 0
                                                            viewModel.timeViewSwitch = 1
                                                         }),
                                            .cancel(Text("キャンセル"))
                                        ])
                    }
            }
            .padding(70)
        }
        
    }
}



struct TimeRecordView_Previews: PreviewProvider {
    static var previews: some View {
        TimeRecordView()
            .environmentObject(RecordViewModel())
    }
}
