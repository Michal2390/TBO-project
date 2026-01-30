//
//  ContentView.swift
//  TBO-Lab4 - Projekt TBO
//
//  Bezpieczna aplikacja iOS do demonstracji CI/CD pipeline
//

import SwiftUI

struct ContentView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var newTaskTitle = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Nowe zadanie...", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(newTaskTitle.isEmpty)
                    .padding(.trailing)
                }
                .padding(.top)
                
                List {
                    ForEach(taskManager.tasks) { task in
                        TaskRowView(task: task) {
                            taskManager.toggleTask(task)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                
                if taskManager.tasks.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("Brak zadań")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("TBO Task Manager")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAlert = true }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .alert("O Aplikacji", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Projekt TBO - CI/CD Security Pipeline\nWersja: 1.0.0")
            }
        }
    }
    
    private func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        taskManager.addTask(title: newTaskTitle)
        newTaskTitle = ""
    }
    
    private func deleteTask(at offsets: IndexSet) {
        taskManager.deleteTask(at: offsets)
    }
}

struct TaskRowView: View {
    let task: Task
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)
            
            Spacer()
            
            Text(task.createdAt, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}