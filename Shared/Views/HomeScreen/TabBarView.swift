//
//  TabBarView.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @Binding var selectedTab: PageTag
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(image: PageTag.currentTask, selectedTab: $selectedTab)
            TabBarButton(image: PageTag.calendar, selectedTab: $selectedTab)
            TabBarButton(image: PageTag.setting, selectedTab: $selectedTab)
        }
        .padding(.bottom, safeAreaInsets.bottom)
        .background(Color(Constant.colorBlack))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.calendar))
            .previewLayout(.sizeThatFits)
            .background(.red)
    }
}

struct TabBarButton: View {
    var image: PageTag
    @Binding var selectedTab: PageTag
    
    var body: some View {
        GeometryReader { reader in
            Button(action: {
                withAnimation {
                    selectedTab = image
                }
            }) {
                if selectedTab == image {
                    LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                        .mask(Image(systemName: image.rawValue)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color(Constant.colorGray)))
                } else {
                    Image(systemName: image.rawValue)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(Constant.colorGray))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 60)
        
    }
}
