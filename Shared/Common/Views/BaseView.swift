//
//  BaseView.swift
//  NoteApp (iOS)
//
//  Created by Eloo on 26/09/2022.
//

import SwiftUI
// Developing
struct BaseView<Content: View>: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    
    private var ishowTabbar: Bool
    @ViewBuilder var content: Content
    
    init(ishowTabbar: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.ishowTabbar = ishowTabbar
        self.content = content()
        
    }
    
    var body: some View {
        ZStack {
            content
                .frame(width: Constant.sizeWidth)
                .offset(x: 0, y: ishowTabbar ? (safeAreaInsets.top + 56) : 0)
                
            if ishowTabbar {
                VStack(spacing: 0.0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: Constant.sizeWidth, height: safeAreaInsets.top)
                        .padding(0)
                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(16)
                        
                        Text("Title App")
                            .font(.title)
                        Spacer()
                    }
                    .background(.cyan)
                    .frame(width: Constant.sizeWidth, height: 56)
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView {
            Text("ssss")
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
