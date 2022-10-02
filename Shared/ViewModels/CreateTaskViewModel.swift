//
//  CreateTaskViewModel.swift
//  NoteApp
//
//  Created by Eloo on 23/09/2022.
//

import SwiftUI
import Combine
 
extension CreateTaskScreen {
    final class Model: ObservableObject {
        @Published var currentDate: Date = Date()
        @Published var selectedDate: Date = Date()
        @Published var newTask: TaskValue?
        @Published var title: String
        @Published var description: String
        @Published var startDate: Date = Date()
        @Published var endDate: Date = Date()
        
        init() {
            newTask = TaskValue()
            title = ""
            description = ""
        }
        
        func add() {
            let task = Task(title: title,
                            description: description,
                            startDate: startDate.getStringDate(),
                            endDate: endDate.getStringDate())
            TaskRespository.shared.add(task)
        }
    }
}
