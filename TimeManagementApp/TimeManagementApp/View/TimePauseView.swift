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
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var moveToTimeStartView = false
    
    @State var test: CGFloat?
    var body: some View {
        VStack() {
            PauseHeaderLayer(header: viewModel)
            TextField("ブレースホルダーを入力してください", text: $viewModel.eventTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.red)
                .padding(25)
            Spacer()
            
            IndicationRecords(resultTime: viewModel)
            Spacer()
            HStack {
                NavigationLink(destination: TimeStartView(),isActive: $moveToTimeStartView) {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 90))
                        .foregroundColor(Color.black)
                }
            
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                Spacer()
            
                Button(action: {
                    mode.wrappedValue.dismiss()
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
            Text(String(format: "%02d", header.elapsedHour) + ":" +
                String(format: "%02d", header.elapsedMinute) + ":" +
                String(format: "%02d", header.elapsedSecond))
        }
        .background(Color.yellow)
    }
}

struct IndicationRecords: View {
    var resultTime: RecordViewModel
    
    @State var brakeHour = 0
    @State var brakeMinute = 0
    @State var brakeSecond = 0
    
    
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
                Text(timeFomatter(iHour: brakeHour,
                                  iMinute: brakeMinute,
                                  iSeconds: brakeSecond))
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
            brakeSecond += 1
            // 秒→分
            if(brakeSecond > 59){
                brakeSecond = 0
                brakeMinute += 1
            }
            // 分→時
            if(brakeMinute > 59){
                brakeMinute = 0
                brakeHour += 1
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
