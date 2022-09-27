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
    
    func getStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.dateFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
    func getHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
    func startOfDay() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        return calendar.date(bySettingHour: 00, minute: 00, second: 00, of: self)!
    }
    
    func endOfDay() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
}
