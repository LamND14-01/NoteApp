//
//  CalendarScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct CalendarScreen: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @ObservedObject var model = Model()
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle().frame(width: 0, height: safeAreaInsets.top + 24)
                CalendarView(currentDate: $model.currentDate, selectedDate: $model.selectedDate)
                Rectangle().frame(width: 0, height: 24)
                ScrollView {
                    LazyVGrid(columns: columns,spacing: 0) {
                        ForEach(model.filteredTask()) { task in
                            taskView(task: task)
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 8)
                }
            }
            .padding(.horizontal, 8)
            .background(Color(Constant.colorBlack))
            .ignoresSafeArea()
            VStack(alignment: .trailing) {
                Spacer()
                Button {
                    print("do something")
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 60, weight: .medium, design: .default))
                        .foregroundColor(Color(Constant.colorRed))
                }.alignTrailing()
                    .offset(CGSize(width: -10, height: -60))
            }
        }
    }
    
    @ViewBuilder
    func taskView(task: TaskValue) ->some View {
        HStack(spacing: 8) {
            Rectangle()
                .frame(width: 3, height: 40)
                .foregroundColor(Color(Constant.colorRed))
            Image(systemName: "calendar.badge.exclamationmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .foregroundColor(Color(Constant.colorGray))
            Text("\(task.title)")
                .font(.callout)
                .foregroundColor(.white)
                .lineLimit(1)
            Spacer()
            Text(task.startDate?.getHour() ?? "")
                .font(.caption.bold())
                .foregroundColor(.white)
                .lineLimit(1)
                .padding(.trailing, 6.0)
        }
        .padding(0)
        .background(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}
