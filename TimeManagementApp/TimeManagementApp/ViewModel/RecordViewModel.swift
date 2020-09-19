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
    
    @Published var startMonth = Calendar.current.component(.month, from: Date())
    @Published var startDay = Calendar.current.component(.day, from: Date())
    @Published var startHour = Calendar.current.component(.hour, from: Date())
    @Published var startMinute = Calendar.current.component(.minute, from: Date())
    @Published var startSecond = Calendar.current.component(.second, from: Date())
    
    @Published var endMonth = Calendar.current.component(.month, from: Date())
    @Published var endDay = Calendar.current.component(.day, from: Date())
    @Published var endHour = Calendar.current.component(.hour, from: Date())
    @Published var endMinute = Calendar.current.component(.minute, from: Date())
    @Published var endSecond = Calendar.current.component(.second, from: Date())
}
