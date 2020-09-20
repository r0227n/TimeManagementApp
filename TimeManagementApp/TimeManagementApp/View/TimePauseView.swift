//
//  TimePauseView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/13.
//  Copyright © 2020 RyoNishimura. All rights reserved.
//

import SwiftUI


struct TimePauseView: View {
    @EnvironmentObject var viewModel: RecordViewModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack() {
            PauseHeaderLayer(header: viewModel)
            TextField("イベント名を入力してください", text: $viewModel.eventTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.gray)
                .padding(25)
            Spacer()
            IndicationRecords(resultTime: viewModel)
            Spacer()
            HStack {
                Button(action: {
                    viewModel.eventTitle = ""
                    viewModel.elapsedHour = 0
                    viewModel.elapsedMinute = 0
                    viewModel.elapsedSecond = 0
                    viewModel.brakeHour = 0
                    viewModel.brakeMinute = 0
                    viewModel.brakeSeconds = 0
                    viewModel.switchViewController = true
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 90))
                        .foregroundColor(Color.black)
                })
                Spacer()
                Button(action: {
                    viewModel.switchViewController.toggle()
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.yellow)
                            .frame(width: 90, height: 90)
                        Image(systemName: "play.fill")
                            .foregroundColor(Color.black)
                            .font(.system(size: 45))
                    } 
                }
            }.padding(70)
        }.edgesIgnoringSafeArea(.top)
    }
}

struct PauseHeaderLayer: View {
    var header: RecordViewModel
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.yellow)
                .frame(height: SGConvenience.deviceHeight*0.35)
            Text(timeFomatter(iHour: header.elapsedHour,
                              iMinute: header.elapsedMinute,
                              iSeconds: header.elapsedSecond))
        }
        .background(Color.yellow)
    }
}

struct IndicationRecords: View {
    var resultTime: RecordViewModel
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("開始時間")
                Text(timeFomatter(iHour: resultTime.startHour,
                                  iMinute: resultTime.startMinute,
                                  iSeconds: resultTime.startSecond))
            }
            Spacer()
            VStack {
                Text("休憩時間")
                Text(timeFomatter(iHour: resultTime.brakeHour,
                                  iMinute: resultTime.brakeMinute,
                                  iSeconds: resultTime.brakeSeconds))
            }
            Spacer()
            VStack {
                Text("終了時間")
                Text(timeFomatter(iHour: resultTime.endHour,
                                  iMinute: resultTime.endMinute,
                                  iSeconds: resultTime.endSecond))
            }
            Spacer()
        }
             
        .onReceive(timer) { _ in
            resultTime.brakeSeconds += 1
            // 秒→分
            if(resultTime.brakeSeconds > 59){
                resultTime.brakeSeconds = 0
                resultTime.brakeMinute += 1
            }
            // 分→時
            if(resultTime.brakeMinute > 59){
                resultTime.brakeMinute = 0
                resultTime.brakeHour += 1
            }
        }
    }
}

struct TimePauseView_Previews: PreviewProvider {
    static var previews: some View {
        TimePauseView()
            .environmentObject(RecordViewModel())
    }
}
