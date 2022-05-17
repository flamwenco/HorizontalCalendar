import Combine
import Foundation

public class HorizontalCalendarController: ObservableObject {
    @Published public var week: CalendarWeek
    @Published public var weekArray: [CalendarWeek]
    
    public init(_ week: CalendarWeek = .current) {
        self.week = week
        
        self.weekArray = []
        self.weekArray.append(self.week.getPreviousWeek())
        self.weekArray.append(self.week)
        self.weekArray.append(self.week.getNextWeek())
        
        NotificationCenter.default.addObserver(self, selector: #selector(jumpToToday), name: Notification.Name("JumpToToday"), object: nil)
    }
    
    public func previousWeek() {
        self.weekArray.insert(self.weekArray[0].getPreviousWeek(), at: 0)
        self.weekArray.remove(at: 3)
    }
    
    public func nextWeek() {
        self.weekArray.append(self.weekArray[2].getNextWeek())
        self.weekArray.remove(at: 0)
    }
    
    @objc public func jumpToToday() {
        self.weekArray = []
        self.weekArray.append(self.week.getPreviousWeek())
        self.weekArray.append(self.week)
        self.weekArray.append(self.week.getNextWeek())
    }
}
