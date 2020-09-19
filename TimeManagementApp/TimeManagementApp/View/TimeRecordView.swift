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
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    @State var moveToTimePauseView = false
    @State var checkTheEnd = false
    @State var isDisplayed = true
    
    @State var brakeCount = 0
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    

    
    var body: some View {
        VStack {
            Text("休憩時間")
            Text("\(brakeCount)")
            Text(viewModel.eventTitle)
            Spacer()
            Text(timeFomatter(iHour: viewModel.elapsedHour,
                              iMinute: viewModel.elapsedMinute,
                              iSeconds: viewModel.elapsedSecond))
            .onReceive(timer) { _ in
                if(isDisplayed){
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
            NavigationLink(destination: TimePauseView(), isActive: $moveToTimePauseView){
                Image(systemName: "pause.circle.fill")
                    .foregroundColor(Color.black)
                    .font(.system(size: 90))
                    .onTapGesture {
                        moveToTimePauseView = true
                }
                    .onLongPressGesture {
                        checkTheEnd = true
                        isDisplayed = false
                }
                .actionSheet(isPresented: $checkTheEnd) {
                    ActionSheet(title: Text("記録を中止しますか？"), message: Text("記録していたデータが削除されますがよろしいですか？"), buttons:
                            [
                                .destructive(Text("記録を中断"),action: {
                                    mode.wrappedValue.dismiss()
                                }),
                                .cancel(Text("キャンセル"),action: {
                                    isDisplayed = true
                                })
                            ]
                        )
                }
            }
            //.isDetailLink(false)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .padding(70)
        .onAppear(perform: {
            isDisplayed = true
            print(viewModel.eventTitle)
            if(viewModel.eventTitle.isEmpty){
                //record.eventTitle = "未設定"
            }
        })
        .onDisappear(perform: {
            isDisplayed = false
            viewModel.endMonth = Calendar.current.component(.month, from: Date())
            viewModel.endDay = Calendar.current.component(.day, from: Date())
            viewModel.endHour = Calendar.current.component(.hour, from: Date())
            viewModel.endMinute = Calendar.current.component(.minute, from: Date())
            viewModel.endSecond = Calendar.current.component(.second, from: Date())
        })
    }
}


struct TimeRecordView_Previews: PreviewProvider {
    static var previews: some View {
        TimeRecordView()
            .environmentObject(RecordViewModel())
    }
}
