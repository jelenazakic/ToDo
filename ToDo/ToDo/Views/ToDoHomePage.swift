//
//  ToDoHomePage.swift
//  ToDo
//
//  Created by Jelena Zakic on 10.9.24..
//

import SwiftUI

struct ToDoHomePage: View {
    
    //  MARK: - Properties
    var databaseManager = DatabaseManager.shared
    @State private var searchTerm = ""
    @State var isPresentedSheetNewList: Bool = false
    @State var isPresentedSheetSettings: Bool = false
    @State private var newList = ListModel(name: "")
    @State var items: [ItemModel] = []
    @State var newNameList: String = ""
    @State private var isHovered = false
    @State private var editingListId: UUID? = nil
    @FocusState private var focusListId: UUID?
    @State var lists: [ListModel] = []
    
    private var filterLists: [ListModel] {
        guard !searchTerm.isEmpty else {
            return lists
        }
        
        let filteredLists = lists
            .filter {
                $0.name.localizedCaseInsensitiveContains(searchTerm)
            }
        
        return filteredLists
    }
    
    //  MARK: - Properties
    
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(filterLists) { list in
                        NavigationLink(destination: MainListView(
                            items: list.tasks,
                            navigationTitle: list.name)
                        ) {
                            listRow(for: list)
                        }
                    }
                    .onDelete(perform: deleteList)
                }
                .scrollContentBackground(.hidden)
                .sheet(isPresented: $isPresentedSheetNewList) {
                    AddNewListView(
                        newNameList: $newNameList,
                        lists: $lists,
                        isPresented: $isPresentedSheetNewList,
                        listId: UUID()
                        
                    )
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
    //MARK: - Utility
    func loadList() {
        lists = databaseManager.fetchAllLists()
    }
    
    func updateList (_ list: ListModel) {
        databaseManager.updateList(list: list)
        loadList()
    }
    
    func deleteList (at offsets: IndexSet) {
        offsets.forEach { index in
            let list = lists[index]
            databaseManager.deleteList(id: list.id)
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
    
 //   private func deleteList(at offsets: IndexSet) {
 //       lists.remove(atOffsets: offsets) // Removes items from the lists array
  //  }
}


#Preview {
    ToDoHomePage()
}
