//
//  addNewItem.swift
//  ToDo
//
//  Created by Jelena Zakic on 8.9.24..
//

import SwiftUI

struct AddNewItemView: View {
  //  @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var isPresented:Bool
    @Binding var newItem: String
    @Binding var items: [ItemModel]
    
    var body: some View {
       
            VStack{
                TextField("Enter new task", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(20)
                 //   .background(themeManager.currentTheme.backgroundColor)
                   // .foregroundStyle(themeManager.currentTheme.textColor)
                    
                    
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
               // .foregroundStyle(themeManager.currentTheme.accentColor)
            }
           
        
           // .background(themeManager.currentTheme.backgroundColor)
        }

}

#Preview {
    AddNewItemView(isPresented: .constant(false),
                   newItem: .constant(""),
                   items: .constant([ItemModel(title: "Sample 1", isCompleted: false)]))
   // .environmentObject(ThemeManager())
    
}
