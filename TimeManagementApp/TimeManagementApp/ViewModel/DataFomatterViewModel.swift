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

func dateFormatStr() -> (date: String, time: String) {
    let formatter = DateFormatter()
    // フォーマット設定
    formatter.dateFormat = "yyyyMMdd/HH:mm"
    //dateFormatter.dateFormat = "yyyyMMddHHmmssSSS" // ミリ秒込み
    // ロケール設定（端末の暦設定に引きづられないようにする）
    formatter.locale = Locale(identifier: "en_US_POSIX")
    // タイムゾーン設定（端末設定によらず固定にしたい場合）
    formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
    let strDateTime = formatter.string(from: Date()).split(separator: "/")
    return (String(strDateTime[0]), String(strDateTime[1]))
}


class EventDay {
    var StartDay = ""
    var StartTime = ""
    var EndTime = ""
    static let singleton = EventDay() //staticキーワードでsingle()をsingletonに代入
    private init(){}
}

func timeFomatter(iHour:Int,iMinute:Int,iSeconds:Int) -> String {
    return String(format: "%02d", iHour) + ":" + String(format: "%02d", iMinute) + ":" + String(format: "%02d", iSeconds)
}



func selectFormatDay(daySet:Date) -> String {
    let formatter = DateFormatter()
    // フォーマット設定
    formatter.dateFormat = "yyyMMdd"
    return formatter.string(from: daySet)
}


func makeFetchRequest(choseDays:Date) -> FetchRequest<TimeRecord> {
    let predicate: NSPredicate?
    let textPredicate = NSPredicate(format: "strDay == %@", selectFormatDay(daySet: choseDays))
    var predicates: [NSPredicate] = []
    predicates.append(textPredicate)
    predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    return FetchRequest<TimeRecord>(
                entity: TimeRecord.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \TimeRecord.strDay, ascending: false)],
                predicate: predicate
            )
}
