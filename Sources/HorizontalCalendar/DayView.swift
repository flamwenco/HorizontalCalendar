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
            ZStack {
                if day.isSameDay(day2: selectedDay) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.thickMaterial)
                        .frame(width:40, height: 40)
                    Text(String(day.getDayOfMonth()))
                        .font(.title2)
                        .foregroundColor(.red)
                } else {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.red.opacity(0.0))
                        .frame(width:40, height: 40)
                    Text(String(day.getDayOfMonth()))
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 120)
        } else {
            ZStack {
                if day.isSameDay(day2: selectedDay) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        //.fill(Color(UIColor.secondarySystemFill).opacity(0.8))
                        .fill(.thinMaterial)
                        .frame(width: 40, height: 40)
                } else {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(UIColor.secondarySystemFill).opacity(0.0))
                        .frame(width: 40, height: 40)
                }
                Text(String(day.getDayOfMonth()))
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 120)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: Day(), selectedDay: Day())
            .background(.red)
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
            .previewInterfaceOrientation(.portrait)
    }
}
