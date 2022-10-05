//
//  SettingScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI
// Developing
struct SettingScreen: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text("SettingScreen")
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
