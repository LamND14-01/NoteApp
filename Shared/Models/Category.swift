//
//  Category.swift
//  NoteApp
//
//  Created by Eloo on 27/09/2022.
//

import SwiftUI

enum Screen: String {
    case currentTask = "Current task"
    case important = "Important"
    case completed = "Completed"
}

struct Category: Identifiable, Hashable {
    let id = UUID().uuidString
    var title: Screen
    var icon: String
    var color: Color
}

extension Category {
    static let data: [Category] = [
        Category(title: Screen.currentTask, icon: "sun.min.fill", color: .cyan),
        Category(title: Screen.important, icon: "star.fill", color: .yellow),
        Category(title: Screen.completed, icon: "text.badge.checkmark", color: .green)
    ]
}
