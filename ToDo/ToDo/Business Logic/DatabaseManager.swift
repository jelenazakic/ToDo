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
        createListsTable()
        createTasksTable()
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
    
    //  MARK: - Lists
    
    private func createListsTable() {
        do {
            try dbQueue?.write { db in
                try db.create(table: "lists", ifNotExists: true) { t in
                    t.column("id",.text).primaryKey().notNull()
                    t.column("name", .text).notNull()
                }
            }
            print("Lists table created successfully.")
        } catch {
            print("Failed to create lists table: \(error)")
        }
    }
    
    func insertList(title: String) -> UUID? {
        let listId =  UUID()
        let list = ListModel(id: listId, name: title)
        do {
            try dbQueue.write { db in
                try list.insert(db)
                print("List inserted: \(list.name)")
            }
            return listId
            
        } catch {
            print("Failed to insert list: \(error)")
            return nil
        }
    }
    
    func fetchAllLists() -> [ListModel] {
        var lists = [ListModel]()
        do {
            try dbQueue.read { db in
                lists = try ListModel.fetchAll(db)
            }
        } catch {
            print("Failed to fetch lists: \(error)")
            return []
            
        }
        return lists
    }
    
    func updateList(list: ListModel) {
        do {
            try dbQueue.write { db in
                try list.update(db)
                print("List updated: \(list.name)")
                
            }
        } catch {
            print("Failed to update list: \(error)")
            
        }
    }
    
    func deleteList(id: UUID) {
        do {
            try dbQueue.write { db in
                try ListModel.deleteOne(db, key: id)
                print("List deleted:")
                
            }
        } catch {
            print("Failed to delete list: \(error)")
            
        }
    }
    
    //  MARK: - Tasks
    
    func insertTask(title: String, listId: UUID) -> UUID? {
        let taskId = UUID()
        let task = TaskModel(
            id: UUID(),
            title: title,
            isCompleted: false,
            listId: listId
        )
        
        do {
            try dbQueue.write { db in
                try task.insert(db)
                print("Task inserted: \(task.title)")
            }
            return taskId
            
        } catch {
            print("Failed to insert task: \(error)")
            return nil
        }
    }
    
    func fetchAllTasks(forListId listId: UUID) -> [TaskModel]? {
        do {
            let tasks = try dbQueue.read { db in
                try TaskModel.fetchAll(
                    db,
                    sql: "SELECT * FROM tasks WHERE listId = ?",
                    arguments: [listId]
                )
            }
            return tasks
        } catch {
            print("Failed to fetch tasks: \(error)")
            return nil
        }
    }
    
    func updateTask(task: TaskModel) {
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
                try TaskModel.deleteOne(db, key: id)
                print("Task deleted:")
            }
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
    
    private func createTasksTable() {
        do {
            try dbQueue?.write { db in
                try db.create(table: "tasks", ifNotExists: true) { t in
                    t.column("id", .text)
                        .primaryKey()
                        .notNull()
                    t.column("title", .text).notNull()
                    t.column("isCompleted", .boolean)
                        .notNull()
                        .defaults(to: false)
                    t.column("listId", .text)
                        .notNull()
                        .references("lists",onDelete: .cascade)
                }
            }
            print("Tasks table created successfully.")
        } catch {
            print("Failed to create tasks table: \(error)")
        }
    }
}
