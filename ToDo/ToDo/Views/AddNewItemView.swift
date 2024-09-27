//
//  addNewItem.swift
//  ToDo
//
//  Created by Jelena Zakic on 8.9.24..
//

import SwiftUI

struct AddNewItemView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isPresented:Bool
    @Binding var newItem: String
    @Binding var items: [ItemModel]
    
    var body: some View {
        
        VStack{
            
            TextField("Enter new task", text: $newItem)
                .padding(20)
                .foregroundColor(themeManager.currentTheme.textColor)
                .background(themeManager.currentTheme.backgroundColor)
                .accentColor(themeManager.currentTheme.textColor)
                .cornerRadius(10)
            Button("Save"){
                items.append(
                    ItemModel(title: newItem,
                              isCompleted: false))
                isPresented = true
            }
            
            .frame(width: 100, height: 20)
            .padding(5)
            .font(.system(size: 15,weight: .bold,
                          design: .default))
            .cornerRadius(20)
            .foregroundStyle(themeManager.currentTheme.accentColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.currentTheme.backgroundColor)
    }
}

#Preview {
    AddNewItemView(isPresented: .constant(false),
                   newItem: .constant(""),
                   items: .constant([ItemModel(title: "Sample 1", isCompleted: false)]))
    .environmentObject(ThemeManager())
    
}
