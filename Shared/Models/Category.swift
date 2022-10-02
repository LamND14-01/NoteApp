//
//  Category.swift
//  NoteApp
//
//  Created by Eloo on 27/09/2022.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    let id = UUID().uuidString
    var title: String
    var icon: String
    var color: Color
}

extension Category {
    static let data: [Category] = [
        Category(title: "Current task", icon: "sun.min.fill", color: .cyan),
        Category(title: "Important", icon: "star.fill", color: .yellow),
        Category(title: "Completed", icon: "text.badge.checkmark", color: .green)
    ]
}
