//
//  addNewItem.swift
//  ToDo
//
//  Created by Jelena Zakic on 8.9.24..
//

import SwiftUI

struct AddNewItemView: View {
    
    
    @State var isPresented:Bool = false
    @Binding var newItem: String
    @Binding var items: [ItemModel]
    
    var body: some View {
        
        VStack{
            
            TextField("Enter new task", text: $newItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(20)
            
            Button("Save"){
                items.append(
                    ItemModel(title: newItem,
                              isCompleted: false))
                isPresented = true
            }
    
        
            .padding(5)
            .font(.system(size: 15,weight: .bold,
                          design: .default))
            .cornerRadius(20)
    
        }
    }
}

#Preview {
    AddNewItemView(newItem: .constant(""),
                   items: .constant([ItemModel(title: "Sample 1", isCompleted: false)]))
}
