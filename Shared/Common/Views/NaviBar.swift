//
//  NaviBar.swift
//  NoteApp
//
//  Created by Eloo on 27/09/2022.
//

import SwiftUI

struct NaviBar<Content: View, Label: View>: View {
    
    @ViewBuilder var leftView: Content
    @ViewBuilder var centerView: Label
    
    init(@ViewBuilder leftView: @escaping () -> Content, @ViewBuilder centerView: @escaping () -> Label) {
        self.leftView = leftView()
        self.centerView = centerView()
        
    }
    
    var body: some View {
        ZStack {
            HStack {
                leftView
                Spacer()
            }
            centerView
        }
        .frame(height: 48)
        
    }
}

struct NaviBar_Previews: PreviewProvider {
    static var previews: some View {
        NaviBar {
            Image(systemName: "calendar.badge.exclamationmark")
        } centerView: {
            Text("tesst")
        }

    }
}
