//
//  ToDoApp.swift
//  ToDo
//
//  Created by Jelena Zakic on 4.9.24..
//

import SwiftUI

@main
struct ToDoApp: App {
    
    @StateObject  var themeManger = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ToDoHomePage()
                    .environmentObject(themeManger)
            }
        }
    }
}
