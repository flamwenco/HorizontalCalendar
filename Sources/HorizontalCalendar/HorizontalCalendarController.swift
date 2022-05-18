import Combine
import Foundation

public class HorizontalCalendarController: ObservableObject {
    @Published public var week: CalendarWeek
    @Published public var weekArray: [CalendarWeek]
    @Published public var selectedDay: Day
    
    public init(_ week: CalendarWeek = .current) {
        self.week = week
        
        self.selectedDay = Day()
        
        self.weekArray = []
        self.weekArray.append(self.week.getPreviousWeek())
        self.weekArray.append(self.week)
        self.weekArray.append(self.week.getNextWeek())
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectDay), name: Notification.Name("SelectDay"), object: nil)
    }
    
    public func previousWeek() {
        self.weekArray.insert(self.weekArray[0].getPreviousWeek(), at: 0)
        self.weekArray.remove(at: 3)
        self.week = weekArray[1]
    }
    
    public func nextWeek() {
        self.weekArray.append(self.weekArray[2].getNextWeek())
        self.weekArray.remove(at: 0)
        self.week = weekArray[1]
    }
    
    public func isCurrentWeek() -> Bool {
        return self.week.isSameWeek(week2: CalendarWeek.current)
    }
    
    public func isLaterWeek() -> Bool {
         return self.week.isLaterWeek(week2: CalendarWeek.current)
    }
    
    public func isEarlierWeek() -> Bool {
         return self.week.isEarlierWeek(week2: CalendarWeek.current)
    }
    
    public func jumpToToday() {
        self.week = CalendarWeek.current
        
        self.weekArray.removeAll()
        self.weekArray.append(self.week.getPreviousWeek())
        self.weekArray.append(self.week)
        self.weekArray.append(self.week.getNextWeek())
        
        self.selectedDay = Day()
    }
    
    @objc public func selectDay(_ notification: Notification) {
        self.selectedDay = notification.userInfo?["day"] as! Day
    }
    
    public func getMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
        return formatter.string(from: self.week.getWholeWeek()[0].day)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("SelectDay"), object: nil)
    }
}
