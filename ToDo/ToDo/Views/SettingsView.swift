//
//  AddThemeView.swift
//  ToDo
//
//  Created by Jelena Zakic on 24.9.24..
//
import SwiftUI

struct SettingsView: View {
    
    //  MARK: - Properties
    @State private var shouldShowMenu = true
    @State private var currentTheme = "System"
    @EnvironmentObject var themeManager: ThemeManager
    
    //  MARK: - Lifecycle
    
    var body: some View {
        NavigationView {
            VStack {
                themeLabel
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
    
    //  MARK: - Views
    
    var themeLabel: some View {
        Menu() {
            Button {
                currentTheme = "System"
                themeManager.switchTheme(to: .system)
            } label: {
                HStack{
                    if( currentTheme == "System"){
                        Image(systemName: "checkmark")
                    }
                    Text("System")
                    Spacer()
                }
            }
            
            Button {
                currentTheme = "Light"
                themeManager.switchTheme(to: .light)
            } label: {
                HStack{
                    if( currentTheme == "Light"){
                        Image(systemName: "checkmark")
                    }
                    Text("Light")
                    Spacer()
                }
            }
            
            Button {
                currentTheme = "Dark"
                themeManager.switchTheme(to: .dark)
            } label: {
                HStack{
                    if( currentTheme == "Dark"){
                        Image(systemName: "checkmark")
                            .background(themeManager.currentTheme.textColor)
                    }
                    Text("Dark")
                    Spacer()
                }
            }
        }
        
        label: {
            HStack {
                Text("Theme")
                    .foregroundStyle(themeManager.currentTheme.textColor)
                Spacer()
                Text("\(currentTheme)")
                    .foregroundStyle(themeManager.currentTheme.textColor)
                    .fontWeight(.light)
                Image(systemName: "chevron.right")
                    .foregroundColor(themeManager.currentTheme.textColor)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .menuStyle(DefaultMenuStyle())
    }
}
#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
