//
//  ToDoApp.swift
//  ToDo
//
//  Created by Jelena Zakic on 4.9.24..
//

import SwiftUI
import GRDB

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
    private var colorScheme: ColorScheme? {
           switch appTheme {
           case "dark":
               return .dark
           case "light":
               return .light
           default:
               return nil 
           }
       }
    
}
