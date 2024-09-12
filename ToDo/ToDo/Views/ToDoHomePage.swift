//
//  ToDoHomePage.swift
//  ToDo
//
//  Created by Jelena Zakic on 10.9.24..
//

import SwiftUI

struct ToDoHomePage: View {
    @State private var searchTerm = ""
    
    var lists: [ListModel] = [
        ListModel(name: "Grocery Shopping", 
                  tasks:[ 
                    ItemModel(title: "Buy milk", isCompleted: false),
                    ItemModel(title: "Get vegetables", isCompleted: false),
                    ItemModel(title: "Pick up bread", isCompleted: true)
                  ]
                 ),
        ListModel(name: "Daily Task List",
                  tasks:[
                    ItemModel(title: "Check email", isCompleted: false),
                    ItemModel(title: "Attend meeting", isCompleted: true),
                    ItemModel(title: "Review project", isCompleted: false)
                  ]
                 ),
        ListModel(name: "Morning Routine",
                  tasks:[
                    ItemModel(title: "Exercise", isCompleted: false),
                    ItemModel(title: "Shower", isCompleted: false),
                    ItemModel(title: "Breakfast", isCompleted: false)
                  ]
                 ),
        ListModel(name: "Monthly Bills",
                  tasks:[ 
                    ItemModel(title: "Pay rent", isCompleted: false),
                    ItemModel(title: "Pay utilities", isCompleted: false)
                  ]
                 )
    ]
    var filterList: [ListModel]{
        guard !searchTerm.isEmpty else {
            return lists
        }
        return lists.filter{
            $0.name.localizedCaseInsensitiveContains(searchTerm)
            
        }
    }
   
    var body: some View {
        NavigationStack{
            
            List(filterList) { list in
                NavigationLink {
                   // ListView(navigationTitle: list.name )
                    ListView (items: list.tasks, navigationTitle: list.name)
                    ForEach(list.tasks) { task in
                        Text("")
                    }
                } label: {
                    HStack{
                        Image(systemName: "checklist")
                        Text(list.name) 
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
            .navigationTitle("My Lists")
            .searchable(text: $searchTerm, prompt: "Search List" )
            .searchable(text: $searchTerm,prompt: "Search List")
        }
    }
}

#Preview {
    ToDoHomePage()
}
