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
    static let shared = TaskRespository()
    private let store = Firestore.firestore()
    private let path = "tasks"
    @Published var tasks: [Task] = []
    
    init() {
      get()
    }
    
    func get() {
      store.collection(path)
        .addSnapshotListener { querySnapshot, _ in
          self.tasks = querySnapshot?.documents.compactMap({ document in
            try? document.data(as: Task.self)
          }) ?? []
        }
    }
    
    func add(_ task: Task) {
        do {
            _ = try store.collection(path).addDocument(from: task)
        } catch {
            print("Unable to add task: \(error.localizedDescription)")
        }
    }
    
    func update(_ task: Task) {
        guard let taskID = task.id else {
            return
        }
        
        do {
            _ = try store.collection(path).document(taskID).setData(from: task)
        } catch {
            print("Unable to update task: \(error.localizedDescription)")
        }
    }
    
    func delete(_ task: Task) {
        guard let taskID = task.id else {
            return
        }
        store.collection(path).document(taskID).delete { error in
            if let error = error {
                print("Unable to update task: \(error.localizedDescription)")
            }
        }
    }
    
}
