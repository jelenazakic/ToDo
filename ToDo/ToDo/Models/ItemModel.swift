//
//  ItemModel.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//
import Foundation
import GRDB
import Combine


struct ItemModel: Codable,Identifiable, FetchableRecord, PersistableRecord {
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



