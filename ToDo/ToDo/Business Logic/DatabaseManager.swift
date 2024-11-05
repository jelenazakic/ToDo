//
//  DatabaseManager.swift
//  ToDo
//
//  Created by Strahinja Mihajlovic on 11/5/24.
//

import Foundation
import GRDB

class DatabaseManager {
    
    //  MARK: - Properties
    
    static let shared = DatabaseManager() // Singleton pattern
    
    private var dbQueue: DatabaseQueue!
    
    //  MARK: - Lifecycle
    
    init() {
        setupDatabase()
        createTaskTable()
    }
    
    func setupDatabase() {
        do {
            let databaseURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("tasks.sqlite")
            
            dbQueue = try DatabaseQueue(path: databaseURL.path)
            print("Database successfully set up at: \(databaseURL.path)")
        } catch {
            print("Database setup failed: \(error)")
        }
    }
    
    //  MARK: - Tasks
    
    private func createTaskTable() {
        do {
            try dbQueue?.write { db in
                try db.create(table: "task", ifNotExists: true) { t in
                    t.column("id", .text).primaryKey().notNull()
                    t.column("title", .text).notNull()
                    t.column("isCompleted", .boolean).notNull().defaults(to: false)
                }
            }
            print("Task table created successfully.")
        } catch {
            print("Failed to create task table: \(error)")
        }
    }
    
    func insertTask(title: String) {
        let task = ItemModel(
            id: UUID(),
            title: title,
            isCompleted: false
        )
        
        do {
            try dbQueue.write { db in
                try task.insert(db)
                print("Task inserted: \(task.title)")
            }
        } catch {
            print("Failed to insert task: \(error)")
        }
    }
    
    func fetchAllTasks() -> [ItemModel] {
        var tasks = [ItemModel]()
        do {
            try dbQueue.read { db in
                tasks = try ItemModel.fetchAll(db)
            }
        } catch {
            print("Failed to fetch tasks: \(error)")
        }
        return tasks
    }
    
    func updateTask(task: ItemModel) {
        do {
            try dbQueue.write { db in
                try task.update(db)
                print("Task updated: \(task.title)")
            }
        } catch {
            print("Failed to update task: \(error)")
        }
    }
    
    func deleteTask(id: UUID) {
        do {
            try dbQueue.write { db in
                try ItemModel.deleteOne(db, key: id.uuidString)
                print("Task deleted:")
            }
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
}
