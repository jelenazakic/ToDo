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

        // MARK: - Lifecycle
        var body: some View {
            NavigationView {
                VStack {
                    themeLabel
                    Spacer()
                }
                .navigationTitle("Settings")
                .onAppear {
                    updateCurrentTheme()
                    
                }
            }
            .preferredColorScheme(appTheme == "dark" ? .dark : (appTheme == "light" ? .light : nil))
            
        }

        // MARK: - Functions
        private func updateCurrentTheme() {
            currentTheme = appTheme == "none" ? "System" : appTheme.capitalized
            print("Updated Current Theme: \(currentTheme)") 
        }

        // MARK: - Views
        var themeLabel: some View {
            Menu {
                Button {
                    selectTheme("System", appTheme: "none")
                } label: {
                    themeMenuItem("System", isSelected: currentTheme == "System")
                }
                
                Button {
                    selectTheme("Light", appTheme: "light")
                } label: {
                    themeMenuItem("Light", isSelected: currentTheme == "Light")
                }
                
                Button {
                    selectTheme("Dark", appTheme: "dark")
                } label: {
                    themeMenuItem("Dark", isSelected: currentTheme == "Dark")
                }
            } label: {
                HStack {
                    Text("Theme")
                    Spacer()
                    Text("\(currentTheme)")
                        .fontWeight(.light)
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .menuStyle(DefaultMenuStyle())
        }
        
        // MARK: - Helper Functions
        private func selectTheme(_ theme: String, appTheme: String) {
            currentTheme = theme
            self.appTheme = appTheme
            updateCurrentTheme()
        }

        private func themeMenuItem(_ title: String, isSelected: Bool) -> some View {
            HStack {
                if isSelected {
                    Image(systemName: "checkmark")
                }
                Text(title)
                Spacer()
            }
        }
    }

    #Preview {
        SettingsView()
    }




