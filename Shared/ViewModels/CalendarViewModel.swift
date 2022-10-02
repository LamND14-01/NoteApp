//
//  CalendarViewModel.swift
//  NoteApp
//
//  Created by Eloo on 12/09/2022.
//

import SwiftUI
import Combine
 
extension CalendarScreen {
    final class Model: ObservableObject {
        @Published var storedTasks: [TaskValue] = []
        @Published var currentDate: Date = Date()
        @Published var selectedDate: Date = Date()
        @Published var newTask: TaskValue?
        
        init() {
            TaskRespository.shared.$tasks.map({ tasks in
                tasks.map({ task in
                    TaskValue(task: task)
                })
            })
            .assign(to: &$storedTasks)
        }
        
        func filteredTask() -> [TaskValue] {
            let range = selectedDate.startOfDay()...selectedDate.endOfDay()
            let filteredTask = storedTasks.filter({task in
                if let date = task.startDate {
                    return range.contains(date)
                } else {
                    return false
                }
            })
            return filteredTask
        }
        
        func completeTask(_ task: TaskValue) {
            var task = Task(task: task)
            task.isSuccess = true
            TaskRespository.shared.update(task)
        }
        
        func deleteTask(_ task: TaskValue) {
            var task = Task(task: task)
            TaskRespository.shared.delete(task)
        }
    }
}
