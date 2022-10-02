//
//  SettingScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct SettingScreen: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Rectangle().frame(height: 100)
                .foregroundColor(.pink)
            Spacer()
            TextField("asd", text: self.$text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .ignoresSafeArea(.keyboard, edges: .bottom)
            Rectangle().frame(height: 100)
                .foregroundColor(.pink)
            
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
