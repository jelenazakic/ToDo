//
//  ItemModel.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//
import Foundation
import GRDB
import Combine


struct TaskModel: Codable,Identifiable, FetchableRecord, PersistableRecord {
    
    //  MARK: - Properties
    
    static let databaseTableName = "tasks"
    
    var id: UUID
    var title: String
    var isCompleted: Bool
    var listId: UUID

    //  MARK: - Lifecycle
    
    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool,
        listId: UUID
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.listId = listId
    }

}



