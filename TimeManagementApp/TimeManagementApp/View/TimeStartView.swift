//
//  TimeStartView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/19.
//

import SwiftUI

struct TimeStartView: View {
    @EnvironmentObject var viewModel: RecordViewModel
    var body: some View {
        NavigationView {
            VStack {
                TextField("イベント名を入力してください", text: $viewModel.eventTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(25)
                Spacer()
                NavigationLink(
                    destination: TimeRecordView(),
                    label: {
                        ZStack {
                            Circle()
                                .fill(Color.yellow)
                                .frame(width:100, height: 100)
                            Text("Start")
                                .font(.callout)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                        }.padding(50)
                    })
            }
            .onDisappear(perform: {
                let eventStartTime = EventStartTime.singleton
                // 開始日時を記録
                eventStartTime.sMonth = Calendar.current.component(.month, from: Date())
                eventStartTime.sDay = Calendar.current.component(.day, from: Date())
                eventStartTime.sHour = Calendar.current.component(.hour, from: Date())
                eventStartTime.sMinute = Calendar.current.component(.minute, from: Date())
                eventStartTime.sSecond = Calendar.current.component(.second, from: Date())
            })
        }
    }
}

struct TimeStartView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStartView()
            .environmentObject(RecordViewModel())
    }
}

