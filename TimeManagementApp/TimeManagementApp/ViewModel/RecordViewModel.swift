//
//  RecordViewModel.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/19.
//

import SwiftUI

class RecordViewModel: ObservableObject {
    @Published var eventTitle:String = ""
    @Published var elapsedHour:Int = 0
    @Published var elapsedMinute:Int = 0
    @Published var elapsedSecond:Int = 0
    
    @Published var deleteView = false
    @Published var moveToView = false
    
    @Published var memoEditor:String = "初期値"
}
