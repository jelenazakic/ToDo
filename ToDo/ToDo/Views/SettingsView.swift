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
        Menu {
            Button {
                
            } label: {
                Text("System")
            }
            
            Button {
                
            } label: {
                Text("Light")
            }
            
            Button {
                
            } label: {
                Text("Dark")
            }
        } label: {
            HStack {
                Text("Theme")
                    .foregroundStyle(Color.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
}

struct ThemeView: View {
    var body: some View {
        VStack {
            Button(action: {}){
                Text("System")
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

#Preview {
    SettingsView()
}
