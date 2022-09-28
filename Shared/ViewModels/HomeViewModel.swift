//
//  HomeViewModel.swift
//  NoteApp
//
//  Created by Eloo on 27/09/2022.
//

import Foundation

import SwiftUI
import Combine
 
extension HomeScreen {
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
            return storedTasks
        }
    }
}
