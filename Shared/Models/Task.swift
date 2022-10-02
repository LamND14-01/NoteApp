//
//  Task.swift
//  NoteApp
//
//  Created by Eloo on 12/09/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var startDate: String
    var endDate: String
    var isImportant: Bool = false
    var isSuccess: Bool = false
    
    init(task: TaskValue) {
        self.id = task.id
        self.title = task.title
        self.description = task.description
        self.startDate = task.startDate?.getStringDate() ?? ""
        self.endDate = task.endDate?.getStringDate() ?? ""
        self.isImportant = task.isImportant
        self.isSuccess = task.isSuccess
    }
    
    init(title: String,
         description: String,
         startDate: String,
         endDate: String) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}

struct TaskValue: Identifiable, Codable {
    var id: String?
    var title: String
    var description: String
    var startDate: Date?
    var endDate: Date?
    var isImportant: Bool
    var isSuccess: Bool
    
    init(task: Task) {
        self.id = task.id
        self.title = task.title
        self.description = task.description
        self.startDate = task.startDate.getDate()
        self.endDate = task.endDate.getDate()
        self.isImportant = task.isImportant
        self.isSuccess = task.isSuccess
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.startDate = Date()
        self.endDate = Date()
        self.isImportant = false
        self.isSuccess = false
    }
}
