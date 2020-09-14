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
    var body: some View {
        VStack {
            Text("経過時間")
            
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
                .alert(isPresented: $checkTheEnd) {
                    Alert(title: Text("記録を中止しますか？"),
                          message: Text("記録していたデータが削除されますがよろしいですか？"),
                          primaryButton: .cancel(Text("No")),    // キャンセル用
                          secondaryButton: .destructive(Text("Yes"),
                                                        action: {self.mode.wrappedValue.dismiss()}))   // 破壊的変更用
                }
                
            }
                .isDetailLink(false)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .padding(70)
    }
}

struct TimeRecordView_Previews: PreviewProvider {
    static var previews: some View {
        TimeRecordView()
    }
}
