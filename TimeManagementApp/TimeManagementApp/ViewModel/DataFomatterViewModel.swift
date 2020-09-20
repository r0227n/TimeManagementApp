//
//  DataFomatterViewModel.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/20.
//

import SwiftUI
// デバイスに応じてスクリーンサイズを返す
class SGConvenience{
    #if os(watchOS)
    static var deviceHeight:CGFloat = WKInterfaceDevice.current().screenBounds.size.height
    static var deviceWidth:CGFloat = WKInterfaceDevice.current().screenBounds.size.width
    #elseif os(iOS)
    static var deviceHeight:CGFloat = UIScreen.main.bounds.size.height
    static var deviceWidth:CGFloat = UIScreen.main.bounds.size.width
    #elseif os(macOS)
    static var deviceHeight:CGFloat = NSScreen.main.bounds.size.height
    static var deviceWidth:CGFloat = NSScreen.main.bounds.size.width
    #endif
}


func timeFomatter(iHour:Int,iMinute:Int,iSeconds:Int) -> String {
    return String(format: "%02d", iHour) + ":" + String(format: "%02d", iMinute) + ":" + String(format: "%02d", iSeconds)
}
