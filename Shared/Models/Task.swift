//
//  Task.swift
//  NoteApp
//
//  Created by Eloo on 12/09/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var startDate: String
    var endDate: String
}

struct TaskValue: Identifiable, Codable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var startDate: Date?
    var endDate: Date?
    init(task: Task) {
        self.title = task.title
        self.description = task.description
        self.startDate = task.startDate.getDate()
        self.endDate = task.endDate.getDate()
    }
}
