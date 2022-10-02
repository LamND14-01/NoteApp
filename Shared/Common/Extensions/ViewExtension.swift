//
//  ViewExtension.swift
//  NoteApp
//
//  Created by Eloo on 12/09/2022.
//

import SwiftUI

extension View {
    func alignLeading() -> some View {
        return self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func alignTrailing() -> some View {
        return self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func alignCenter() -> some View {
        return self.frame(maxWidth: .infinity, alignment: .center)
    }
}
