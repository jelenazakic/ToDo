//
//  Untitled.swift
//  ToDo
//
//  Created by Jelena Zakic on 26.9.24..
//
import Foundation
import SwiftUI

struct Theme {
    
    var backgroundColor: Color
    var textColor: Color
    var accentColor: Color
    var font: Font
}

class ThemeManager: ObservableObject {
    //  MARK: - Properties
    @Published var currentTheme: Theme
    
    init(){
        self.currentTheme = Theme (
            
            backgroundColor: Color.white,
            textColor: Color.black,
            accentColor: Color.blue,
            font: .body
        )
    }
    
    //  MARK: - Lifecycle
    func switchTheme ( to theme: Theme){
        currentTheme = theme
    }
}
extension Theme {
    static let system = Theme (
        backgroundColor: .white,
        textColor: .black,
        accentColor: .blue,
        font: .body)
}

extension Theme {
    static let light = Theme (
        backgroundColor: .white,
        textColor: .black,
        accentColor: .green,
        font: .body)
}

extension Theme {
    static let dark = Theme(
        backgroundColor: Color.black,
        textColor: .black,
        accentColor: .orange,
        font: .body)
}

