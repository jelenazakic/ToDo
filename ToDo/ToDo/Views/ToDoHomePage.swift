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
    @State var isPresented: Bool = false
    @State private var newList = ListModel(name: "", tasks: [])
    @State var items: [ItemModel] = []
    @State var newNameList: String = " "
    @State private var isDarkMode = false
    
    @State var lists: [ListModel] = [
        ListModel(name: "Grocery Shopping",
                  tasks:[
                    ItemModel(title: "Buy milk", isCompleted: false),
                    ItemModel(title: "Get vegetables", isCompleted: false),
                    ItemModel(title: "Pick up bread", isCompleted: true)
                  ]
                 ),
        ListModel(name: "Daily Task List",
                  tasks:[
                    ItemModel(title: "Check email", isCompleted: true),
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
    var filteredLists: [ListModel] {
        guard !searchTerm.isEmpty else { return lists }
        return lists.filter {
            $0.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    //  MARK: - Properties
    
    var body: some View {
        VStack{
            NavigationStack {
                List(filteredLists) { list in
                    NavigationLink(destination: MainListView(items: list.tasks, navigationTitle: list.name)) {
                        listRow(for: list)
                    }
                    
                }
                
                .sheet(isPresented: $isPresented) {
                    AddNewListView(newNameList: $newNameList, lists: $lists, isPresented: $isPresented)
                }
                .foregroundColor(isDarkMode ? .white : .black)
                .navigationBarItems(trailing: addButton)
                .listRowBackground(Color.blushPlum)
                .listStyle(PlainListStyle())
                .navigationTitle("My Lists")
                .searchable(text: $searchTerm, prompt: "Search List")
            }
        }
        Toggle("Dark Mode", isOn: $isDarkMode)
                        .padding()
                    
                    if isDarkMode {
                       
                    } else {
                        
                    }
    }
       
        private func listRow(for list: ListModel) -> some View {
            HStack {
                Image(systemName: "checklist")
                Text(list.name)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                Text("\(checkedCount(items: list.tasks)) / \(countAllTask(items: list.tasks))")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.callout)
                    .fontWeight(.light)
            }
            .padding(.vertical)
        }
    
        
        private var addButton: some View {
            Button(action: {
                isPresented = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 15, weight: .bold))
            }
        }
        
        func checkedCount(items: [ItemModel]) -> Int {
            return items.filter { $0.isCompleted }.count
        }
        
        func countAllTask(items: [ItemModel]) -> Int {
            return items.count
        }
    
    }

    

    #Preview {
        ToDoHomePage()
    }
    
