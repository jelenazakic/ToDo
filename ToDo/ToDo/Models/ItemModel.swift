//
//  ItemModel.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//
import Foundation
import GRDB
import Combine


struct ItemModel: Codable, FetchableRecord, PersistableRecord, Identifiable {
    var id: UUID
    var title: String
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }

    static var databaseTableName: String {
        return "task"
    }
}


class DatabaseManager: ObservableObject {
    static let shared = DatabaseManager()
    var dbQueue: DatabaseQueue!
    @Published var items: [ItemModel] = []

    init() {
        
        setupDatabase()
        createTaskTable()
        loadTask()
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
   
    
    func createTaskTable() {
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
        let task = ItemModel(id: UUID(), title: title, isCompleted: false)
        do {
            try dbQueue.write { db in
                try task.insert(db)
                print("Task inserted: \(task.title)")
                loadTask()
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
    
    func loadTask(){
            items = fetchAllTasks()
            print("Items loaded: \(items.count)")
        }
    
    
    func updateTask(task: ItemModel) {
        do {
            try dbQueue.write { db in
                try task.update(db)
                print("Task updated: \(task.title)")
            }
            loadTask()
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
            loadTask()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
    
    func markTaskAsCompleted(task: ItemModel) {
          var updatedTask = task
          updatedTask.isCompleted.toggle()
          updateTask(task: updatedTask)
      }
}
