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
        @Published var taskRepositories = TaskRespository()
        @Published var currentDate: Date = Date()
        @Published var selectedDate: Date = Date()
        
        init() {
            taskRepositories.$tasks.map({ tasks in
                tasks.map({ task in
                    TaskValue(task: task)
                })
            })
            .assign(to: &$storedTasks)
        }
        
        func filteredTask() -> [TaskValue] {
            print("=======\(selectedDate)")
            return storedTasks
        }
    }
}
