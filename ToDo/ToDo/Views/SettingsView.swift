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
            } label: {
                HStack{
                    if( currentTheme == "System"){
                        Image(systemName: "checkmark")
                    }
                    Text("System")
                        
                }
            }
        
            Button {
                currentTheme = "Light"
                
            } label: {
                
                HStack{
                    if( currentTheme == "Light"){
                        Image(systemName: "checkmark")
                    }
                    Text("Light")
                }
            }
            
            Button {
                currentTheme = "Dark"
            } label: {
                
                HStack{
                    if( currentTheme == "Dark"){
                        Image(systemName: "checkmark")
                    }
                    Text("Dark")
                }
            }
        }
        
        label: {
            HStack {
                Text("Theme")
                    .foregroundStyle(Color.black)
                Spacer()
                Text("\(currentTheme)")
                    .foregroundStyle(Color.black)
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

    /*struct ThemeView: View {
    var body: some View {
        VStack {
            Button(action: {}){
                Text("System1")
                    .foregroundColor(Color.black)
                
            }
            Button(action: {}){
                Text("Light")
                    .foregroundColor(Color.black)
                
            }
            Button(action: {}){
                Text("Dark")
                    .foregroundColor(Color.black)
                
            }
           
        }
        .navigationTitle("Theme")
        .padding()
    }
}
*/
#Preview {
    SettingsView()
}
