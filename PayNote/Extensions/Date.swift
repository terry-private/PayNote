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

extension Date {

    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .japan
        calendar.locale   = .japan
        return calendar
    }

    var year: Int {
        calendar.component(.year, from: self)
    }

    var month: Int {
        calendar.component(.month, from: self)
    }

    var day: Int {
        calendar.component(.day, from: self)
    }

    var hour: Int {
        calendar.component(.hour, from: self)
    }

    var minute: Int {
        calendar.component(.minute, from: self)
    }

    var second: Int {
        calendar.component(.second, from: self)
    }
}
