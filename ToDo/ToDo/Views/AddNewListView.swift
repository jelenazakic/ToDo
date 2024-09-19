//
//  AddNewListView.swift
//  ToDo
//
//  Created by Jelena Zakic on 17.9.24..
//

import SwiftUI

struct AddNewListView: View {
    
    //  MARK: - Properties
    
    @State var newNameList: String = ""
    @State var lists: [ListModel] = []
    @Binding var showView: Bool
    
    //  MARK: - Lifecycle
    
    var body: some View {
        VStack {
            newListTextField
            saveNewListButton
        }
    }
    
    //  MARK: - Views
    
    private var newListTextField: some View {
        TextField("Enter New List", text: $newNameList)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(20)
    }
    
    private var saveNewListButton: some View {
        Button {
            onSaveNewListButtonTap()
        } label: {
            Text("Save")
        }
        .frame(width: 100, height: 20)
        .padding(5)
        .font(.system(size: 15,weight: .bold, design: .default))
        .cornerRadius(20)
    }
    
    //  MARK: - Utility
    
    private func onSaveNewListButtonTap() {
        let newList = ListModel(name: newNameList, tasks: [] )
        lists.append(newList)
        newNameList.removeAll()
        
        showView = false
    }
}
#Preview {
    AddNewListView(
        lists: [
            ListModel(
                name: "Sample List",
                tasks: [
                    ItemModel(title: "Sample Task 1", isCompleted: false),
                    ItemModel(title: "Sample Task 2", isCompleted: true)
                ]
            )
        ],
        showView: .constant(false)
    )
}

