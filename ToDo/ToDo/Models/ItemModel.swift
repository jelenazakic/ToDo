//
//  ItemModel.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//

import Foundation
struct ItemModel: Identifiable{
    
    let id: String = UUID().uuidString
    let title: String
    var isCompleted: Bool
}
