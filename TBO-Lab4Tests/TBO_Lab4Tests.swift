//
//  TBO_Lab4Tests.swift
//  TBO-Lab4Tests
//
//  Testy jednostkowe dla aplikacji TBO
//

import XCTest
@testable import TBO_Lab4

final class TBO_Lab4Tests: XCTestCase {
    
    var taskManager: TaskManager!
    
    override func setUpWithError() throws {
        taskManager = TaskManager()
        taskManager.tasks = []
    }
    
    override func tearDownWithError() throws {
        taskManager = nil
    }
    
    func testAddTask() throws {
        // Given
        let initialCount = taskManager.tasks.count
        
        // When
        taskManager.addTask(title: "Test Task")
        
        // Then
        XCTAssertEqual(taskManager.tasks.count, initialCount + 1)
        XCTAssertEqual(taskManager.tasks.last?.title, "Test Task")
        XCTAssertFalse(taskManager.tasks.last?.isCompleted ?? true)
    }
    
    func testToggleTask() throws {
        // Given
        taskManager.addTask(title: "Test Task")
        let task = taskManager.tasks.first!
        let initialState = task.isCompleted
        
        // When
        taskManager.toggleTask(task)
        
        // Then
        XCTAssertNotEqual(taskManager.tasks.first?.isCompleted, initialState)
    }
    
    func testDeleteTask() throws {
        // Given
        taskManager.addTask(title: "Task 1")
        taskManager.addTask(title: "Task 2")
        taskManager.addTask(title: "Task 3")
        let initialCount = taskManager.tasks.count
        
        // When
        taskManager.deleteTask(at: IndexSet(integer: 1))
        
        // Then
        XCTAssertEqual(taskManager.tasks.count, initialCount - 1)
        XCTAssertEqual(taskManager.tasks.count, 2)
    }
    
    func testTaskModel() throws {
        // Given
        let task = Task(title: "Test Task")
        
        // Then
        XCTAssertNotNil(task.id)
        XCTAssertEqual(task.title, "Test Task")
        XCTAssertFalse(task.isCompleted)
        XCTAssertNotNil(task.createdAt)
    }
    
    func testTaskCodable() throws {
        // Given
        let task = Task(title: "Codable Test")
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(task)
        let decoder = JSONDecoder()
        let decodedTask = try decoder.decode(Task.self, from: data)
        
        // Then
        XCTAssertEqual(task.id, decodedTask.id)
        XCTAssertEqual(task.title, decodedTask.title)
        XCTAssertEqual(task.isCompleted, decodedTask.isCompleted)
    }
}