//
//  TaskRepositories.swift
//  NoteApp (iOS)
//
//  Created by Eloo on 14/09/2022.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class TaskRespository: ObservableObject {
    private let store = Firestore.firestore()
    private let path = "tasks"
    @Published var tasks: [Task] = []
    
    init() {
      get()
    }
    
    func get() {
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          self.tasks = querySnapshot?.documents.compactMap({ document in
            try? document.data(as: Task.self)
          }) ?? []
        }
    }
     
}
