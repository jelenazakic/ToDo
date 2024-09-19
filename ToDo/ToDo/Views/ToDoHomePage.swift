//
//  ToDoHomePage.swift
//  ToDo
//
//  Created by Jelena Zakic on 10.9.24..
//

// commit od strahinja - obrisati kasnije
import SwiftUI

struct ToDoHomePage: View {
    
    //  MARK: - Properties
    
    @State private var searchTerm = ""
    @State private var showCreateNewListSheet: Bool = false
    @State var checkListCountValue: Int = 0
    
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
                    ItemModel(title: "Pay rent", isCompleted: true),
                    ItemModel(title: "Pay utilities", isCompleted: true)
                  ]
                 )
    ]
    
    var filterList: [ListModel] {
        guard !searchTerm.isEmpty else {
            return lists
        }
        
        return lists.filter{
            $0.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    //  MARK: - Properties
    
    var body: some View {
        NavigationStack{
            List(filterList) { list in
                NavigationLink {
                    MainListView(
                        items: list.tasks,
                        navigationTitle: list.name
                    )
                }
                label: {
                    Image(systemName: "checklist")
                    Text(list.name)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                    Text(String(checkedCount(items: list.tasks)))
                        .frame(maxWidth: .infinity,
                               alignment: .trailing)
                        .font(.callout)
                        .fontWeight(.light)
                    
                }
                .padding(.vertical)
            }
            .sheet(
                isPresented: $showCreateNewListSheet,
                content: {
                    AddNewListView(
                        lists: [
                            ListModel(
                                name: "New name",
                                tasks: [
                                    ItemModel(title: "Buy milk", isCompleted: false),
                                    ItemModel(title: "Get vegetables", isCompleted: false),
                                    ItemModel(title: "Pick up bread", isCompleted: true)
                                ]
                            )
                        ],
                        showView: $showCreateNewListSheet
                    )
                })
            .navigationBarItems(
                trailing:
                    Button(
                        " ",
                        systemImage: "plus",
                        action: {
                            showCreateNewListSheet = true
                        }
                    )
                    .font(.system(size: 15,weight: .bold, design: .default))
            )
            .listRowBackground(Color.blushPlum)
            .listStyle(PlainListStyle())
            .padding(.bottom)
            .navigationTitle("My Lists")
            .searchable(text: $searchTerm, prompt: "Search List")
        }
    }
    
    func checkedCount(items: [ItemModel]) -> Int {
        return items.filter { !$0.isCompleted }.count
    }
    
}


//Vasilijev prvi komit

#Preview {
    ToDoHomePage(checkListCountValue: 0)
}