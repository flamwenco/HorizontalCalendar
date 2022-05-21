//
//  File.swift
//  
//
//  Created by Daniel Muckerman on 5/16/22.
//

import Foundation

public enum Week: Int, CaseIterable, Identifiable {
    case sun = 0
    case mon = 1
    case tue = 2
    case wed = 3
    case thu = 4
    case fri = 5
    case sat = 6
    
    public var id : String { UUID().uuidString }
    
    public var shortString: String {
        get {
            return DateFormatter().shortWeekdaySymbols[self.rawValue]
        }
    }
    
    public func shortString(locale: Locale) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        return formatter.shortWeekdaySymbols[self.rawValue]
    }
}

public struct Day: Identifiable {
    public var id = UUID()
    public let day: Date
    
    public init() {
        self.day = Calendar.current.startOfDay(for: Date())
    }
    
    public init(day: Date) {
        self.day = day
    }
    
    public func getMonthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: day)
    }
    
    public func getMonth() -> Int {
        return Calendar.current.component(.month, from: day)
    }
    
    public func getDayOfWeekString() -> String {
        return Week.allCases[Calendar.current.component(.weekday, from: day) - 1].shortString
    }
    
    public func getDayOfWeek() -> Int {
        return Calendar.current.component(.weekday, from: day)
    }
    
    public func getDayOfMonth() -> Int {
        return Calendar.current.component(.day, from: day)
    }
    
    public func isToday() -> Bool {
        return Calendar.current.isDateInToday(self.day)
    }
    
    public func isSameDay(day2: Day) -> Bool {
        // Replace the hour (time) of both dates with 00:00
        let date1 = Calendar.current.startOfDay(for: self.day)
        let date2 = Calendar.current.startOfDay(for: day2.day)

        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
}

public struct CalendarWeek: Equatable, Hashable, Identifiable {
    public let date: Date
    public var id : String { UUID().uuidString }
    
    public init() {
        self.date = Date()
    }
    
    public init(date: Date) {
        self.date = date
    }
    
    public static var current: CalendarWeek {
        get {
            return CalendarWeek(date: Date())
        }
    }
    
    public func getPreviousWeek() -> CalendarWeek {
        return CalendarWeek(date: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self.date)!)
    }
    
    public func getNextWeek() -> CalendarWeek {
        return CalendarWeek(date: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self.date)!)
    }
    
    public func getWholeWeek() -> [Day] {
        return getWholeWeek(startingDay: self.date)
    }
    
    public func getWholeWeek(startingDay: Date) -> [Day] {
        let weekday = Calendar.current.component(.weekday, from: startingDay)
        let weekdays = Calendar.current.range(of: .weekday, in: .weekOfYear, for: startingDay)!
        
        return (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { Calendar.current.date(byAdding: .day, value: $0 - weekday, to: startingDay) }
            .compactMap { day in Day(day: day) }
    }
    
    public func getFirstWeekDay() -> Day {
        let weekday = Calendar.current.component(.weekday, from: date)
        
        return Day(day: Calendar.current.date(byAdding: .day, value: 1 - weekday, to: self.date)!)
    }
      
    private func compareWeek(week2: CalendarWeek) -> Int {
        // Replace the hour (time) of both dates with 00:00
        let date1 = Calendar.current.startOfDay(for: self.date)
        let date2 = Calendar.current.startOfDay(for: week2.date)

        let diff = Calendar.current.dateComponents([.weekOfYear], from: date1, to: date2)
        return diff.weekOfYear!
    }
    
    public func isLaterWeek(week2: CalendarWeek) -> Bool {
        return compareWeek(week2: week2) < 0
    }
    
    public func isEarlierWeek(week2: CalendarWeek) -> Bool {
        return compareWeek(week2: week2) > 0
    }
    
    public func isSameWeek(week2: CalendarWeek) -> Bool {
        return compareWeek(week2: week2) == 0
    }
}
