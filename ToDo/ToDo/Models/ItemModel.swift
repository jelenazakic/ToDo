//
//  ItemModel.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//

import Foundation
import GRDB

struct ItemModel: Identifiable, Codable, FetchableRecord, PersistableRecord {
    
    //  MARK: - Properties
    
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    //  MARK: - Lifecycle
    
    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
}
