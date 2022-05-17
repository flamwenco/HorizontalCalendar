//
//  File.swift
//  
//
//  Created by Daniel Muckerman on 5/16/22.
//

import Foundation

public enum Week: Int, CaseIterable {
    case sun = 0
    case mon = 1
    case tue = 2
    case wed = 3
    case thu = 4
    case fri = 5
    case sat = 6
    
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
        self.day = Date()
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
}

public struct CalendarWeek: Equatable, Hashable {
    public let date: Date
    
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
}
