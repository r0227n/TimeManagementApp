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
    
    @State var memoEditor:String = "初期値"
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack() {
            ZStack {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(height: SGConvenience.deviceHeight*0.35)
                Text(timeFomatter(iHour: viewModel.elapsedHour,
                                  iMinute: viewModel.elapsedMinute,
                                  iSeconds: viewModel.elapsedSecond))
            }
            .background(Color.yellow)
            TextField("イベント名を入力してください", text: $viewModel.eventTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(25)
            Spacer()
            Divider()
            TextEditor(text: $memoEditor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("HelveticaNeue", size: 13))
                .lineSpacing(5)
            Divider()
            Spacer()
            HStack {
                Button(action: {
                    memoEditor = "初期値"
                    viewModel.eventTitle = ""
                    viewModel.elapsedHour = 0
                    viewModel.elapsedMinute = 0
                    viewModel.elapsedSecond = 0
                    viewModel.timeViewSwitch = 1
                }, label: {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 90))
                        .foregroundColor(Color.black)
                })
                Spacer()
                Button(action: {
                    viewModel.timeViewSwitch = 2
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
        }.edgesIgnoringSafeArea(.top).navigationBarHidden(true)
    }
}



struct TimePauseView_Previews: PreviewProvider {
    static var previews: some View {
        TimePauseView()
            .environmentObject(RecordViewModel())
    }
}
