//
//  addNewItem.swift
//  ToDo
//
//  Created by Jelena Zakic on 8.9.24..
//

import SwiftUI

struct AddNewItemView: View {
    
    //  MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented:Bool
    @Binding var listTasks: [TaskModel]
    @State var newItem: String = ""
    let listId: UUID
    
    //  MARK: - Lifecycle
    
    var body: some View {
        
            VStack {
                TextField("Enter new task", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(20)
                
                Button("Save") {
                    
                    hideKeyboard()
                    
                    DatabaseManager.shared.insertTask(title: newItem, listId: listId)
                    
                    if let fetchedTasks = DatabaseManager.shared.fetchAllTasks(forListId: listId) {
                        listTasks = fetchedTasks
                       
                    }
                    
                    newItem = ""
                    dismiss()

                  //  isPresented = false
                
                }
                .disabled(newItem.trimmingCharacters(in: .whitespaces).isEmpty)
                .frame(width: 80, height: 20)
                .padding(5)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                //.buttonStyle(GrowingButton())
            }
        }
    }

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

#Preview {
    AddNewItemView(
        isPresented: .constant(false),
        listTasks: .constant([
            TaskModel(
                title: "Sample 1",
                isCompleted: false,
                listId: UUID()
            ),
            TaskModel(
                title: "Sample 2",
                isCompleted: false,
                listId: UUID()
            ),
            TaskModel(
                title: "Sample 3",
                isCompleted: false,
                listId: UUID()
            ),
            TaskModel(
                title: "Sample 4",
                isCompleted: false,
                listId: UUID()
            ),
            TaskModel(
                title: "Sample 5",
                isCompleted: false,
                listId: UUID()
            ),
            TaskModel(
                title: "Sample 6",
                isCompleted: false,
                listId: UUID()
            )
        ]),
        listId: UUID()
    )
}
