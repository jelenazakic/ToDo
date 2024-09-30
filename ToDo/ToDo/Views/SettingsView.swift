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
    @AppStorage("appTheme") private var appTheme: String = "light"
    
    // @EnvironmentObject var themeManager: ThemeManager
    
    //  MARK: - Lifecycle
    
    var body: some View {
        NavigationView {
            VStack {
                themeLabel
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
       // .preferredColorScheme(appTheme == "dark" ? .dark : .light)
        .preferredColorScheme(appTheme == "dark" ? .dark : (appTheme == "light" ? .light : .none))
    }
    
    //  MARK: - Views
    
    var themeLabel: some View {
        Menu() {
            
            Button {
                currentTheme = "System"
                appTheme = "none"
                // themeManager.switchTheme(to: .system)
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
                
                appTheme = "light"
                // themeManager.switchTheme(to: .light)
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
                appTheme = "dark"
                
                // themeManager.switchTheme(to: .dark)
            } label: {
                
                HStack{
                    if( currentTheme == "Dark"){
                        Image(systemName: "checkmark")
                    }
                    Text("Dark")
                    Spacer()
                }
            }
        }
        
        label: {
            HStack {
                Text("Theme")
                //.foregroundStyle(Color.black)
                Spacer()
                Text("\(currentTheme)")
                // .foregroundStyle(Color.black)
                    .fontWeight(.light)
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .menuStyle(DefaultMenuStyle())
        
    }
}
#Preview {
    SettingsView()
    
}




