//
//  ListModel.swift
//  ToDo
//
//  Created by Jelena Zakic on 11.9.24..
//

import Foundation

struct ListModel:Identifiable{
   
    let id: String = UUID().uuidString
    var name:String
    var tasks: [ItemModel]

}

