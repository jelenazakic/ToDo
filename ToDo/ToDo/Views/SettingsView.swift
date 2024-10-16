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
    @AppStorage("appTheme") private var appTheme: String = "none"
    
    //  MARK: - Lifecycle
    
    var body: some View {
        NavigationView {
            
            VStack {
                themeLabel
                Spacer()
            }
            .navigationTitle("Settings")
            .onAppear{
                updateCurrentTheme()
            }
        }
        .preferredColorScheme(appTheme == "dark" ? .dark : (appTheme == "light" ? .light : nil))
    }
    
    private func updateCurrentTheme() {
        currentTheme = appTheme == "none" ? "System" : appTheme.capitalized
    }
    //  MARK: - Views
    
    var themeLabel: some View {
        Menu() {
            
            Button {
                currentTheme = "System"
                appTheme = "none"
                updateCurrentTheme()
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
                updateCurrentTheme()
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
                updateCurrentTheme()
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




