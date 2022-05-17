//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Muckerman on 5/16/22.
//

import SwiftUI

@available(iOS 15, *)
public struct DayView: View {
    var day: Day
    
    public var body: some View {
        if day.isToday() {
            VStack {
                Text("\(day.getDayOfWeekString())")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                Text("\(day.getDayOfMonth())")
                    .font(.largeTitle)
                Text("\(day.getMonthString())")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 120)
            .background(.quaternary)
            .overlay(VStack { Divider().foregroundColor(.secondary) }, alignment: .top)
            .overlay(VStack { Divider().foregroundColor(.secondary) }, alignment: .bottom)
            .overlay(HStack { Divider().foregroundColor(.secondary) }, alignment: .leading)
        } else {
            VStack {
                Text("\(day.getDayOfWeekString())")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                Text("\(day.getDayOfMonth())")
                    .font(.largeTitle)
                Text("\(day.getMonthString())")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 120)
            .background(.bar)
            .overlay(VStack { Divider().foregroundColor(.secondary) }, alignment: .top)
            .overlay(VStack { Divider().foregroundColor(.secondary) }, alignment: .bottom)
            .overlay(HStack { Divider().foregroundColor(.secondary) }, alignment: .leading)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: Day())
            .preferredColorScheme(.light)
    }
}
