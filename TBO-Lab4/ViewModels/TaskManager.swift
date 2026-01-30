//
//  TaskManager.swift
//  TBO-Lab4
//
//  ViewModel zarządzający zadaniami - bezpieczna implementacja
//

import Foundation
import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    
    private let tasksKey = "saved_tasks"
    
    init() {
        loadTasks()
    }
    
    func addTask(title: String) {
        let task = Task(title: title)
        tasks.append(task)
        saveTasks()
    }
    
    func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    // BEZPIECZNE przechowywanie - używamy Codable i UserDefaults tylko dla niekrytycznych danych
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        }
    }
}