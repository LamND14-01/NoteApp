//
//  DateExtension.swift
//  NoteApp
//
//  Created by Eloo on 05/09/2022.
//

import Foundation

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        return range.compactMap({ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        })
    }
}
