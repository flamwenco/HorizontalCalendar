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
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 7) // columnCount
    @ObservedObject private var controller: HorizontalCalendarController
    @StateObject var page: Page = .withIndex(1)
    
    public init(
        _ controller: HorizontalCalendarController =        HorizontalCalendarController()
    ) {
        self.controller = controller
    }
    
    public var body: some View {
        Pager(page: page,
              data: controller.weekArray,
              id: \.self,
              content: { index in
            // create a page based on the data passed
            VStack {
                LazyVGrid(columns: gridItem, alignment: .center) {
                    ForEach(index.getWholeWeek()) { day in
                        DayView(day: day)
                            .frame(height: 80)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: 100)
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
}

struct HorizontalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCalendarView(HorizontalCalendarController())
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
