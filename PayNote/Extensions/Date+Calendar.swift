//
//  Date.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/20.
//

import Foundation

extension TimeZone {
    static let japan = TimeZone(identifier: "Asia/Tokyo")!
}

extension Locale {
    static let japan = Locale(identifier: "ja_JP")
}

private let calendar: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = .japan
    calendar.locale   = .japan
    return calendar
}()

extension Calendar {
    static var japanCalendar = calendar

    static func getYear(from date: Date) -> Int {
        calendar.component(.year, from: date)
    }

    static func getMonth(from date: Date) -> Int {
        calendar.component(.month, from: date)
    }

    static func getDay(from date: Date) -> Int {
        calendar.component(.day, from: date)
    }

    static func getHour(from date: Date) -> Int {
        calendar.component(.hour, from: date)
    }

    static func getMinute(from date: Date) -> Int {
        calendar.component(.minute, from: date)
    }

    static func getSecond(from date: Date) -> Int {
        calendar.component(.second, from: date)
    }
}

extension Date {
    func added(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date {
        var comp = DateComponents()
        comp.year   = (year   ?? 0) + calendar.component(.year,   from: self)
        comp.month  = (month  ?? 0) + calendar.component(.month,  from: self)
        comp.day    = (day    ?? 0) + calendar.component(.day,    from: self)
        comp.hour   = (hour   ?? 0) + calendar.component(.hour,   from: self)
        comp.minute = (minute ?? 0) + calendar.component(.minute, from: self)
        comp.second = (second ?? 0) + calendar.component(.second, from: self)
        return calendar.date(from: comp)!
    }
}
