//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Muckerman on 5/17/22.
//

import SwiftUI

struct WeekdayView: View {
    var day: String
    
    var body: some View {
        ZStack {
            Text(day.uppercased())
                .font(.caption2)
                .foregroundColor(.gray)
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.red.opacity(0.0))
                .frame(width:40, height: 40)
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 120)
    }
}

struct WeekdayView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayView(day: "sun")
    }
}
