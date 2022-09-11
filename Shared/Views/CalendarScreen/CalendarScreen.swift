//
//  CalendarScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct CalendarScreen: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @State var currentDate: Date = Date()
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Rectangle().frame(width: 0, height: safeAreaInsets.top + 24)
            CalendarView(currentDate: $currentDate)
            Rectangle().frame(width: 0, height: 24)
            ScrollView {
                LazyVGrid(columns: columns,spacing: 0) {
                    ForEach(0...30,id: \.self) { int in
                        HStack(spacing: 8) {
                            Rectangle()
                                .frame(width: 3, height: 40)
                                .foregroundColor(Color.red)
                            Image(systemName: "calendar.badge.exclamationmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color(Constant.colorGray))
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                                .font(.callout)
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Spacer()
                            Text("18:00")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.trailing, 6.0)
                        }
                        .padding(0)
                        .background(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.horizontal, 8)
        .background(Color(Constant.colorBlack))
        .ignoresSafeArea()
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}
