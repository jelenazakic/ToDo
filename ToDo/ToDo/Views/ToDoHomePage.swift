//
//  ToDoHomePage.swift
//  ToDo
//
//  Created by Jelena Zakic on 10.9.24..
//

import SwiftUI

struct ToDoHomePage: View {
    
    //  MARK: - Properties
    
    @State private var searchTerm = ""
    @State var isPresentedSheetNewList: Bool = false
    @State var isPresentedSheetSettings: Bool = false
    @State private var newList = ListModel(name: "", tasks: [])
    @State var items: [ItemModel] = []
    @State var newNameList: String = ""
    @State private var isHovered = false
    @State private var editingListId: UUID? = nil
    @FocusState private var focusListId: UUID?
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
                List {
                    ForEach(filterList) { list in
                        if( list.id == editingListId){
                            TextField("", text: list.title, onCommit: {
                                editingListId = nil
                            })
                            .focused($focusListId, equals: List.id)
                            .onAppear{
                                focusListId = list.id
                            }
                            .onChange(of: editingListId) {
                                if editingListId == list.id {
                                    focusListId = list.id
                                }
                            }
                        } else{
                            
                                .contentShape(Rectangle())
                                .contextMenu{
                                    Button ("Edit"){
                                        editingListId = list.id
                                    }
                                }
                        }

                        NavigationLink(destination: MainListView(items: list.tasks,
                                                                 navigationTitle: list.name))
                        {
                            listRow(for: list)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteList(at: indexSet)
                    })
                }
                .scrollContentBackground(.hidden)
                .sheet(isPresented: $isPresentedSheetNewList) {
                    AddNewListView(newNameList: $newNameList,
                                   lists: $lists, isPresented: $isPresentedSheetNewList)
                    .presentationDetents([.fraction(0.3), .fraction(0.2)])
                }
                .sheet(isPresented: $isPresentedSheetSettings){
                    SettingsView()
                        .presentationDetents([.fraction(0.9)])
                        .edgesIgnoringSafeArea(.all)
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        addSettingButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addNewListButton
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("My Lists")
                .searchable(text: $searchTerm, prompt: "Search List")
            }
            .tint(Color.blue)
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
    
    private var addNewListButton: some View {
        Button(action: {
            isPresentedSheetNewList = true
        }) {
            Image(systemName: "plus")
                .font(.system(size: 15, weight: .bold))
        }
    }
    private var addSettingButton: some View {
        
        Button(action: {
            isPresentedSheetSettings = true
        }) {
            Image(systemName: "gearshape")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 15, weight: .bold))
                .frame(width: isHovered ? 50 : 25, height: isHovered ? 50 : 25)
                .animation(.easeInOut(duration: 0.2), value: isHovered)
        }
        .onHover { hovering in
            isHovered = hovering}
    }
    
    
    func checkedCount(items: [ItemModel]) -> Int {
        return items.filter { $0.isCompleted }.count
    }
    
    func countAllTask(items: [ItemModel]) -> Int {
        return items.count
    }
    
    private func deleteList(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets) // Removes items from the lists array
    }
}


#Preview {
    ToDoHomePage()
}


