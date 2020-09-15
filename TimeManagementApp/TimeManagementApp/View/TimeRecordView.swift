//
//  TimeRecordView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/13.
//  Copyright © 2020 RyoNishimura. All rights reserved.
//

import SwiftUI

struct TimeRecordView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var moveToTimePauseView = false
    @State var checkTheEnd = false
    
    @State var timeRemaining = 0
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(timeRemaining)")
            .onReceive(timer) { _ in
                if(self.moveToTimePauseView != true){
                    self.timeRemaining += 1
                }
                
            }

            
            
            Spacer()
            NavigationLink(destination: TimePauseView(), isActive: $moveToTimePauseView){
                Image(systemName: "pause.circle.fill")
                    .foregroundColor(Color.black)
                    .font(.system(size: 90))
                    .onTapGesture {
                        self.moveToTimePauseView = true
                }
                    .onLongPressGesture {
                        self.checkTheEnd = true
                        //self.mode.wrappedValue.dismiss()
                }
                .actionSheet(isPresented: $checkTheEnd) {
                        ActionSheet(title: Text("記録を中止しますか？"), message: Text("記録していたデータが削除されますがよろしいですか？"), buttons:
                            [
                                .destructive(Text("記録を中断"),action: {self.mode.wrappedValue.dismiss()}),
                                .cancel()
                            ]
                        )
                }
            }
                
                .isDetailLink(false)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .padding(70)
        .onAppear(perform: {
            self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        })
    }
}

struct TimeRecordView_Previews: PreviewProvider {
    static var previews: some View {
        TimeRecordView()
    }
}
