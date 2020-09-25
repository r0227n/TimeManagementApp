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
    
    @Environment(\.presentationMode) var presentationMode
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var floatKeybord = false
    
    var body: some View {
        VStack() {
            Group {
                ZStack {
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(height: SGConvenience.deviceHeight*0.35)
                    Text(timeFomatter(iHour: viewModel.elapsedHour,
                                      iMinute: viewModel.elapsedMinute,
                                      iSeconds: viewModel.elapsedSecond))
                }.background(Color.yellow).edgesIgnoringSafeArea(.all)
                TextField("イベント名を入力してください", text: $viewModel.eventTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(25)
                    .keyboardType(.default)
            }.onTapGesture(perform: {
                UIApplication.shared.closeKeyboard()
            })
            Divider()
            TextEditor(text: $viewModel.memoEditor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("HelveticaNeue", size: 13))
                .lineSpacing(5)
            
            Divider()
            Spacer()
            if(floatKeybord != true){
                HStack {
                    Button(action: {
                        viewModel.deleteView.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "stop.circle.fill")
                            .font(.system(size: 90))
                            .foregroundColor(Color.black)
                    })
                    Spacer()
                    Button(action: {
                        viewModel.moveToView.toggle()
                        presentationMode.wrappedValue.dismiss()
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
                }.padding(70).navigationBarHidden(true)
            }
        }
        // キーボードを開いた
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            floatKeybord = true
        }
        // キーボードを閉じた
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            floatKeybord = false
        }
        .onAppear(perform: {
            let eventEndTime = EventEndTime.singleton
            // 終了日時を記録
            eventEndTime.eMonth = Calendar.current.component(.month, from: Date())
            eventEndTime.eDay = Calendar.current.component(.day, from: Date())
            eventEndTime.eHour = Calendar.current.component(.hour, from: Date())
            eventEndTime.eMinute = Calendar.current.component(.minute, from: Date())
            eventEndTime.eSecond = Calendar.current.component(.second, from: Date())
        })
    }
}



struct TimePauseView_Previews: PreviewProvider {
    static var previews: some View {
        TimePauseView()
            .environmentObject(RecordViewModel())
    }
}
