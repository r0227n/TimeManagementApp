//
//  TimeStartView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/19.
//

import SwiftUI

struct TimeStartView: View {
    @EnvironmentObject var viewModel: RecordViewModel
    
    @State var stockTypeTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("イベント名を入力してください", text: $viewModel.eventTitle)
                          
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(25)
                
                Spacer()
                NavigationLink(destination: TimeRecordView()) {
                    ZStack {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width:100, height: 100)
                        Text("Start")
                            .font(.callout)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(50)
            }
        }
        .onAppear {
            viewModel.elapsedSecond = 0
            viewModel.eventTitle = ""
            stockTypeTitle = ""
        }
        .onDisappear {
            // 開始日時を記録
            viewModel.startMonth = Calendar.current.component(.month, from: Date())
            viewModel.startDay = Calendar.current.component(.day, from: Date())
            viewModel.startHour = Calendar.current.component(.hour, from: Date())
            viewModel.startMinute = Calendar.current.component(.minute, from: Date())
            viewModel.startSecond = Calendar.current.component(.second, from: Date())
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct TimeStartView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStartView()
            .environmentObject(RecordViewModel())
    }
}
