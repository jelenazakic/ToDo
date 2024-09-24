//
//  AddThemeView.swift
//  ToDo
//
//  Created by Jelena Zakic on 24.9.24..
//
import SwiftUI

struct SettingsView: View {
    @State private var shouldShowMenu = true
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ThemeView()) {
                    HStack{
                        Text("Theme")
                            .foregroundColor(Color.black)
                            
                        Spacer()
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.black)
                    }
            
                    .padding()
                    .frame(width: 390)
                    
                }
            }
            .navigationTitle("Settings")
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
