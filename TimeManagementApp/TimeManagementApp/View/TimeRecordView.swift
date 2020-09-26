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
    
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.eventTitle)
                Spacer()
                Text(timeFomatter(iHour: viewModel.elapsedHour,
                                  iMinute: viewModel.elapsedMinute,
                                  iSeconds: viewModel.elapsedSecond))
                .onReceive(timer) { _ in
                    if((viewModel.moveToView != true) && (checkTheEnd != true)){
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
                
                NavigationLink(
                    destination: TimePauseView(),
                    isActive: $viewModel.moveToView,
                    label: {
                        Image(systemName: "pause.circle.fill")
                            .foregroundColor(Color.black)
                            .font(.system(size: 90))
                            .onTapGesture {
                                viewModel.moveToView.toggle()
                                // 終了日時を記録
                                let eventEndTime = EventDay.singleton
                                eventEndTime.EndDay = dateFormatStr()
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
                                                                    presentationMode.wrappedValue.dismiss()
                                                                 }),
                                                    .cancel(Text("キャンセル"))
                                                ])
                    }
                    })
            }
            .padding(70)
            .onAppear {
                if(viewModel.deleteView){
                    presentationMode.wrappedValue.dismiss()
                    viewModel.memoEditor = .init()
                    viewModel.moveToView = .init()
                    viewModel.deleteView = .init()
                }
            }
        }
        .navigationBarHidden(true)
        .onDisappear {
            viewModel.eventTitle = .init()
            viewModel.elapsedHour = .init()
            viewModel.elapsedMinute = .init()
            viewModel.elapsedSecond = .init()
        }
    }
}



struct TimeRecordView_Previews: PreviewProvider {
    static var previews: some View {
        TimeRecordView()
            .environmentObject(RecordViewModel())
    }
}
