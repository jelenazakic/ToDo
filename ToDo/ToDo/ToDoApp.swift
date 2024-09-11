//
//  ToDoApp.swift
//  ToDo
//
//  Created by Jelena Zakic on 4.9.24..
//

import SwiftUI

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView(navigationTitle: "todo")
            }
        }
    }
}
