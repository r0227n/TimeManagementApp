//
//  TimerHolderModel.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/16.
//  Copyright © 2020 RyoNishimura. All rights reserved.
//

import SwiftUI
import Combine

class TimerHolderModel : ObservableObject {
    @Published var timer : Timer!
    @Published var count = 0

   func start() {
       self.timer?.invalidate()
       self.count = 0
       self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
           _ in
           self.count += 1
       }
   }
}
