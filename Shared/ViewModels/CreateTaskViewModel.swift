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
        @Published var title: String
        @Published var description: String
        @Published var startDate: Date = Date()
        @Published var endDate: Date = Date()
        @Published var typeScreen: Screen
        
        init(typeScreen: Screen) {
            title = ""
            description = ""
            self.typeScreen = typeScreen
        }
        
        func add() {
            var task = Task(title: title,
                            description: description,
                            startDate: startDate.getStringDate(),
                            endDate: endDate.getStringDate())
            task.isImportant = typeScreen == .important ? true : false
            guard task.title != "" else { return }
            TaskRespository.shared.add(task)
        }
    }
}
