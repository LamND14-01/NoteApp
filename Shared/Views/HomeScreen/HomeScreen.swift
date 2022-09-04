//
//  HomeScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selection: PageTag = .calendar
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                CurrentTaskScreen()
                    .tag(PageTag.currentTask)
                CalendarScreen()
                    .tag(PageTag.calendar)
                SettingScreen()
                    .tag(PageTag.setting)
            }
            .background(.cyan)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .gesture(DragGesture())
            TabBarView(selectedTab: $selection)
                
        }
        .ignoresSafeArea()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
