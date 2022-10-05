//
//  DetailScreenViewModel.swift
//  NoteApp (iOS)
//
//  Created by Eloo on 04/10/2022.
//

import Foundation

import SwiftUI
import Combine
 
extension DetailScreen {
    final class Model: ObservableObject {
        @Published var task: TaskValue
        @Published var startDate: Date = Date()
        @Published var endDate: Date = Date()
        
        init(task: TaskValue = TaskValue()) {
            self.task = task
            self.startDate = task.startDate ?? Date()
            self.endDate = task.endDate ?? Date()
        }
        
        func updateTask() {
            task.startDate = self.startDate
            task.endDate = self.endDate
            let task = Task(task: task)
            TaskRespository.shared.update(task)
        }
    }
}
