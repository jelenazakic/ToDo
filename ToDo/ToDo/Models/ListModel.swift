//
//  ListModel.swift
//  ToDo
//
//  Created by Jelena Zakic on 11.9.24..
//

import Foundation
import GRDB

struct ListModel: Identifiable, Codable, FetchableRecord, PersistableRecord {
   
    //  MARK: - Properties
    
    let id: UUID
    let name: String
  //  var tasks: [ItemModel] = []

    //  MARK: - Lifecycle
    
    init(
        id: UUID = UUID(),
        name: String
    ) {
        self.id = id
        self.name = name
      
    }
    static var databaseTableName: String {
        return "list"
    }
}

