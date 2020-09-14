//
//  TimeStartView.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/13.
//  Copyright © 2020 RyoNishimura. All rights reserved.
//

import SwiftUI

struct TimeStartView: View {
    @State var eventName = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $eventName)
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
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct TimeStartView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStartView()
    }
}
