//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Muckerman on 5/16/22.
//

import SwiftUI
import Combine

@available(iOS 15, *)
public struct HorizontalCalendarView: View {
    @ObservedObject private var controller: HorizontalCalendarController
    @State private var tabSelection = 1
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
                        
                        jumpToToday()
                    }
                Spacer()
            }
            HStack {
                ForEach(Week.allCases) { value in
                    WeekdayView(day: value.shortString)
                        .frame(height: 20)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: 20)
            .padding(.horizontal, 3.0)
            GeometryReader { proxy in
                ScrollView {
                    LazyHStack {
                        TabView(selection: $tabSelection) {
                            HStack {
                                ForEach(controller.weekArray[0].getWholeWeek()) { day in
                                    DayView(day: day, selectedDay: controller.selectedDay)
                                        .frame(height: 60)
                                        .onTapGesture {
                                            selectDay(day)
                                        }
                                }
                            }
                            .tag(0)
                            HStack {
                                ForEach(controller.weekArray[1].getWholeWeek()) { day in
                                    DayView(day: day, selectedDay: controller.selectedDay)
                                        .frame(height: 60)
                                        .onTapGesture {
                                            selectDay(day)
                                        }
                                }
                            }
                            .tag(1)
                            HStack {
                                ForEach(controller.weekArray[2].getWholeWeek()) { day in
                                    DayView(day: day, selectedDay: controller.selectedDay)
                                        .frame(height: 60)
                                        .onTapGesture {
                                            selectDay(day)
                                        }
                                }
                            }
                            .tag(2)
                        }
                        .frame(width: proxy.size.width, height: 60)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onChange(of: tabSelection) { pageIndex in
                            if pageIndex == 0 {
                                controller.previousWeek()
                                tabSelection = 1
                            }
                            if pageIndex == 2 {
                                controller.nextWeek()
                                tabSelection = 1
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity,
                       minHeight: 150, maxHeight: .infinity)
            }
        }
        .frame(minHeight:0, maxHeight: 120)
    }
    
    func selectDay(_ day: Day) {
        NotificationCenter.default.post(
            name: Notification.Name("SelectDay"),
            object: nil,
            userInfo: ["day": day])
    }
    
    func jumpToToday() {
        if !controller.isCurrentWeek() {
            withAnimation {
                controller.jumpToToday()
            }
        } else {
            if !controller.isTodaySelected() {
                withAnimation {
                    controller.selectToday()
                }
            }
        }
    }
}

struct HorizontalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCalendarView(HorizontalCalendarController())
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
            .previewInterfaceOrientation(.portrait)
    }
}
