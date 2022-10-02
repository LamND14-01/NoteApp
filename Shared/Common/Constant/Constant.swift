//
//  Constant.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

struct Constant {
    static let sizeWidth = UIApplication.shared.keyWindow?.frame.size.width
    static let sizeHeight = UIApplication.shared.keyWindow?.frame.size.height
    static let colorBlack: String = "black"
    static let colorPurple: String = "purple"
    static let colorGreen: String = "green"
    static let colorGray: String = "gray"
    static let colorRed: String = "red"
    static let colorDarkGray: String = "darkGray"
    static let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss"
}
