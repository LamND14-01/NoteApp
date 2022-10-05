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
        @Published var typeScreen: Screen?
        @Published var selectedTask: TaskValue = TaskValue()
        
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
            var filteredTask = storedTasks.filter({task in
                guard let typeScreen = typeScreen else { return false }
                switch typeScreen {
                case .currentTask:
                    if let date = task.startDate {
                        return range.contains(date) && !task.isSuccess
                    } else {
                        return false
                    }
                case .important:
                    return task.isImportant
                case .completed:
                    return task.isSuccess
                }
            })
            
            filteredTask.sort {
                if let date1 = $0.startDate, let date2 = $1.startDate {
                    return date1 < date2
                } else {
                    return false
                }
            }
            return filteredTask
        }
        
        func filteredCompletedTask() -> [TaskValue] {
            let range = selectedDate.startOfDay()...selectedDate.endOfDay()
            var filteredTask = storedTasks.filter({task in
                if let date = task.startDate {
                    return range.contains(date) && task.isSuccess
                } else {
                    return false
                }
            })
            
            filteredTask.sort {
                if let date1 = $0.startDate, let date2 = $1.startDate {
                    return date1 < date2
                } else {
                    return false
                }
            }
            return filteredTask
        }
        
        func isExpired(_ date: Date?) -> Bool {
            guard let date = date else { return false }
            return date < Date()
        }
        
        func completeTask(_ task: TaskValue) {
            var task = Task(task: task)
            task.isSuccess.toggle()
            TaskRespository.shared.update(task)
        }
        
        func importantChange(_ task: TaskValue) {
            var task = Task(task: task)
            task.isImportant.toggle()
            TaskRespository.shared.update(task)
        }
        
        func deleteTask(_ task: TaskValue) {
            let task = Task(task: task)
            TaskRespository.shared.delete(task)
        }
    }
}
