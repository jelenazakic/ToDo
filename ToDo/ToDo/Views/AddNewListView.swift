//
//  AddNewListView.swift
//  ToDo
//
//  Created by Jelena Zakic on 17.9.24..
//

import SwiftUI

struct AddNewListView: View {
    @Binding var newNameList: String
    @State var lists: [ListModel] = []
    @State  var isPre: Bool
    
    var body: some View {
        
        VStack{
            
            TextField("Enter New List", text: $newNameList)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(20)
            
            Button("Save"){
                lists.append(ListModel(name: newNameList, tasks: [] ))
                newNameList = " "
                isPre = true
                
            }
            .frame(width: 100, height: 20)
            .padding(5)
            .font(.system(size: 15,weight: .bold, design: .default))
            .cornerRadius(20)
        }
    }
    
}
#Preview {
    AddNewListView(newNameList: .constant(""),
                   lists:
                    [
                    ListModel(name: "Sample List",
                              tasks:
                               [
                               ItemModel(title: "Sample Task 1", isCompleted: false),
                            ItemModel(title: "Sample Task 2", isCompleted: true)
                                    ]
                                 )
                    ],
                   isPre: false)
                         
    
}

