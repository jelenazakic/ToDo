//
//  addNewItem.swift
//  ToDo
//
//  Created by Jelena Zakic on 8.9.24..
//

import SwiftUI

struct AddNewItemView: View {
    
    
    @Binding var isPresented:Bool
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
                    isPresented = false
            }
            .disabled(newItem.trimmingCharacters(in: .whitespaces).isEmpty)
            .frame(width: 80, height: 20)
            .padding(5)
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(20)
            .buttonStyle(GrowingButton())
        }
    }
}

#Preview {
    AddNewItemView(isPresented: .constant(false),
                   newItem: .constant(""),
                   items: .constant([ItemModel(
                    title: "Sample 1",
                    isCompleted: false)]))
}
