//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Muckerman on 5/16/22.
//

import SwiftUI
import Combine
import SwiftUIPager

@available(iOS 15, *)
public struct HorizontalCalendarView: View {
    @ObservedObject private var controller: HorizontalCalendarController
    @StateObject var page: Page = .withIndex(1)
    @State private var scaleValue = CGFloat(1)
    
    public init(
        _ controller: HorizontalCalendarController =        HorizontalCalendarController()
    ) {
        self.controller = controller
    }
    
    public var body: some View {
        VStack(spacing: 0.0) {
            HStack() {
                Text(controller.getMonthYear())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 5.0)
                    .scaleEffect(scaleValue)
                    .onTapGesture {
                        withAnimation {
                            self.scaleValue = 0.9
                        }

                        withAnimation(Animation.linear.delay(0.1)) {
                            self.scaleValue = 1.0
                        }
                        if !controller.isCurrentWeek() {
                            if controller.isEarlierWeek() {
                                controller.jumpToToday()
                                withAnimation {
                                    page.update(.moveToFirst)
                                    page.update(.new(index: 1))
                                }
                            } else {
                                controller.jumpToToday()
                                withAnimation {
                                    page.update(.moveToLast)
                                    page.update(.new(index: 1))
                                }
                            }
                        }
                    }
                Spacer()
            }
            Pager(page: page,
                  data: controller.weekArray,
                  id: \.self,
                  content: { index in
                // create a page based on the data passed
                HStack {
                    ForEach(index.getWholeWeek()) { day in
                        DayView(day: day, selectedDay: controller.selectedDay)
                            .frame(height: 60)
                            .onTapGesture {
                                selectDay(day)
                            }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: .infinity)
             })
            .onPageChanged({ pageIndex in
                if pageIndex == 0 {
                    controller.previousWeek()
                    page.index = 1
                }
                if pageIndex == 2 {
                    controller.nextWeek()
                    page.index = 1
                }
            })
            .bounces(false)
        }
        .frame(minHeight:0, maxHeight: 110)
    }
    
    func selectDay(_ day: Day) {
        NotificationCenter.default.post(
            name: Notification.Name("SelectDay"),
            object: nil,
            userInfo: ["day": day])
        
    }
 
    func jumpToToday() {
        NotificationCenter.default.post(
            name: Notification.Name("JumpToToday"),
            object: nil)
        
    }
}

struct HorizontalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCalendarView(HorizontalCalendarController())
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
