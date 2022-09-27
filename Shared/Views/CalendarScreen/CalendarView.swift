//
//  CalendarView.swift
//  NoteApp
//
//  Created by Eloo on 05/09/2022.
//

import SwiftUI

struct CalendarView: View {
    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat "]
    let collumns = Array(repeating: GridItem(.flexible()), count: 7)
    
    @Binding var currentDate: Date
    @State var currentMonth = 0
    @State var swipeable: Bool = true
    @Binding var selectedDate: Date
    
    var body: some View {
        
        ZStack(content: {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack {
                        Text("\(extractData()[1])")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        Text("\(extractData()[0])")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button {
                        currentMonth = 0
                        selectedDate = Date()
                    } label: {
                        Text("Today")
                            .font(.callout)
                            .foregroundColor(.white)
                    }
                    Rectangle().frame(width: 8, height: 0)
                    Image(systemName: "list.bullet.below.rectangle")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Rectangle().frame(width: 0, height: 24)
                HStack(spacing: 0) {
                    ForEach(days, id: \.self) {day in
                        Text(day)
                            .font(.callout)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(Constant.colorGray))
                    }
                }
                Rectangle().frame(width: 0, height: 12)
                LazyVGrid(columns: collumns, spacing: 16) {
                    ForEach(extractDate()) { value in
                        cardView(value: value)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
        })
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(Constant.colorBlack))
        )
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    guard swipeable else {
                        return
                    }
                    if gesture.translation.width < -24 {
                        currentMonth += 1
                        swipeable = false
                    } else if gesture.translation.width > 24 {
                        currentMonth -= 1
                        swipeable = false
                    }
                }
                .onEnded {_ in
                    swipeable = true
                }
        )
        .onChange(of: currentMonth) { _ in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func cardView(value: DateValue) ->some View {
        VStack(alignment: .center, spacing: 0) {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(.white)
            }
        }
        .frame(width: 36, height: 36)
        .background {
            if isSameDate(date1: value.date, date2: selectedDate), value.day != -1 {
                Circle()
                    .fill(Color(Constant.colorRed))
            }
        }
        .onTapGesture {
            selectedDate = value.date
        }
    }
    
    func isSameDate(date1: Date, date2: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        return calendar.isDate(date1.startOfDay(), inSameDayAs: date2.startOfDay())
    }
    
    func extractData() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        // from current date, update month from self.currentMonth
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            let date2 = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            return DateValue(day: day, date: date2)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<(firstWeekday - 2) {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(currentDate: .constant(Date()), selectedDate: .constant(Date()))
    }
}
