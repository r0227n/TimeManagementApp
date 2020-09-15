//
//  TimePauseView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/13.
//  Copyright © 2020 RyoNishimura. All rights reserved.
//

import SwiftUI

struct TimePauseView: View {
    @State var eventName = ""
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var moveToTimeStartView = false
    var body: some View {
        VStack{
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $eventName)
            Spacer()
            HStack(alignment: .center) {
                NavigationLink(destination: TimeStartView(),isActive: $moveToTimeStartView) {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 90))
                        .foregroundColor(Color.black)
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                Spacer()
                Button(action: {
                    self.mode.wrappedValue.dismiss()
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
            }
        }
    .padding(70)
    }
}

struct TimePauseView_Previews: PreviewProvider {
    static var previews: some View {
        TimePauseView()
    }
}
