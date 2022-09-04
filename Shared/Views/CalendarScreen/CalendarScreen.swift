//
//  CalendarScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct CalendarScreen: View {
    var body: some View {
        Text("CalendarScreen")
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onEnded({ value in
                                    if value.translation.width < 0 {
                                        print("left")
                                    }

                                    if value.translation.width > 0 {
                                        // right
                                        print("right")
                                    }
                                    if value.translation.height < 0 {
                                        // up
                                        print("up")
                                    }

                                    if value.translation.height > 0 {
                                        // down
                                        print("down")
                                    }
                                }))
        
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}
