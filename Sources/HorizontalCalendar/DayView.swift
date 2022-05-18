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
    var selectedDay: Day
    
    public var body: some View {
        if day.isToday() {
            VStack(spacing: 5) {
                Text(day.getDayOfWeekString().uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                ZStack {
                    if day.isSameDay(day2: selectedDay) {
                    Circle()
                        .fill(.red.opacity(0.2))
                        .frame(height: 40)
                    } else {
                        Circle()
                            .fill(.red.opacity(0.0))
                            .frame(height: 40)
                    }
                    Text(String(day.getDayOfMonth()))
                        .font(.title)
                        .foregroundColor(Color.red)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 120)
        } else {
            VStack(spacing: 5) {
                Text(day.getDayOfWeekString().uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                ZStack {
                    if day.isSameDay(day2: selectedDay) {
                    Circle()
                            .fill(Color(UIColor.secondarySystemFill).opacity(0.8))
                        .frame(height: 40)
                    } else {
                        Circle()
                            .fill(.white.opacity(0.0))
                            .frame(height: 40)
                    }
                    Text(String(day.getDayOfMonth()))
                        .font(.title)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 120)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: Day(), selectedDay: Day())
            .preferredColorScheme(.light)
    }
}
