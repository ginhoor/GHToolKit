//
//  DateExtension.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/7/21.
//

import Foundation

public extension Date {
    var gh: GHDateExtension { return GHDateExtension(self) }
    static var Gh: GHDateExtension.Type { return GHDateExtension.self }
}

public struct GHDateExtension {
    internal let date: Date
    internal init(_ date: Date) { self.date = date }
}

public extension GHDateExtension {
    func timeString(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self.date)
    }
}

public enum GHTimeUnit: Int {
    case second = 0
    case minute
    case hour
    case day
    case week
    case month
}

public extension GHDateExtension {

    static var minuteSeconds: Int { return 60 }
    static var hourSeconds: Int { return 60 * minuteSeconds }
    static var daySeconds: Int { return 24 * hourSeconds }
    static var weekSeconds: Int { return 7 * daySeconds }
    static var monthSeconds: Int { return 30 * daySeconds }

    private var myCalendar: Calendar { return Calendar.current }
    private var myComponents: Set<Calendar.Component> {
        return [.year, .month, .day, .hour, .minute, .second, .weekOfYear, .weekday, .weekdayOrdinal]
    }
}

public extension GHDateExtension {

    var weekday: Int { return myCalendar.component(.weekday, from: date) }

    var milliseconds: Int64 { return Int64(date.timeIntervalSince1970 * 1000) }

    var startOfDay: Date {
        var components = myCalendar.dateComponents(myComponents, from: date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return myCalendar.date(from: components) ?? date
    }

    var endOfDay: Date {
        var components = myCalendar.dateComponents(myComponents, from: date)
        components.hour = 23
        components.minute = 59
        components.second = 59
        return myCalendar.date(from: components) ?? date
    }

    var startOfWeek: Date {
        let components = myCalendar.dateComponents(myComponents, from: date)
        guard let weekIndex = components.weekday else { return date }
        return startOfDay.gh.addTime(unit: .day, count: TimeInterval(-weekIndex + 1))
    }

    var endOfWeek: Date {
        let components = myCalendar.dateComponents(myComponents, from: date)
        guard let weekIndex = components.weekday else { return date }
        return endOfDay.gh.addTime(unit: .day, count: TimeInterval(7 - weekIndex))
    }

    var startOfMonth: Date {
        var components = myCalendar.dateComponents(myComponents, from: startOfDay)
        components.day = 1
        return myCalendar.date(from: components) ?? date
    }

    var endOfMonth: Date {
        var components = myCalendar.dateComponents(myComponents, from: endOfDay)
        components.day = daysOfMonth()
        return myCalendar.date(from: components) ?? date
    }

    func addTime(unit: GHTimeUnit, count: TimeInterval) -> Date {
        var interval = date.timeIntervalSinceReferenceDate
        switch unit {
        case .second:
            interval += count * Double(1)
        case .minute:
            interval += count * Double(Self.minuteSeconds)
        case .hour:
            interval += count * Double(Self.hourSeconds)
        case .day:
            interval += count * Double(Self.daySeconds)
        case .week:
            interval += count * Double(Self.weekSeconds)
        case .month:
            interval += count * Double(Self.monthSeconds)
        }

        return Date(timeIntervalSinceReferenceDate: interval)
    }

    func isSameDay(with date: Date) -> Bool { return abs(date.timeIntervalSince(date)) <= 86400 }

    func isSameWeek(as date: Date) -> Bool {
        let weekStart = startOfWeek
        let weekEnd = endOfWeek
        if date.compare(weekStart) != .orderedAscending,
           date.compare(weekEnd) != .orderedDescending {
            return true
        }
        return false
    }

    func isSameMonth(as date: Date) -> Bool {
        let monthStart = startOfMonth
        let monthEnd = endOfMonth
        if date.compare(monthStart) != .orderedAscending,
           date.compare(monthEnd) != .orderedDescending {
            return true
        }
        return false
    }

    func daysOfMonth() -> Int {
        let range = myCalendar.range(of: .day, in: .month, for: date)
        return range?.count ?? 28
    }

}
