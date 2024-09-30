//
//  ToDoApp.swift
//  ToDo
//
//  Created by Jelena Zakic on 4.9.24..
//

import SwiftUI

@main
struct ToDoApp: App {
   
    @AppStorage("appTheme") private var appTheme: String = "light"

  //  @StateObject  var themeManger = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ToDoHomePage()
                    .preferredColorScheme(colorScheme)
            }
        }
    }
          private var colorScheme: ColorScheme?{
            appTheme == "dark" ? .dark : .light
        }
    
}
