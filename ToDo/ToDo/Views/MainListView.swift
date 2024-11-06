//
//  ListView.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//

import SwiftUI
import Combine

struct MainListView: View {
    
    //  MARK: - Properties
    var databaseManager = DatabaseManager.shared
    @State var newItem :String = ""
    @State var isPresentedNewItemSheet: Bool = false
    @State var isCompleted: Bool = false
    @State var items: [ItemModel] = []
    @State var isAnimatedPlusButton = false
    @State var editingItemId: UUID? = nil
    @FocusState var focusItemId: UUID?
    
    let navigationTitle: String
    
    //  MARK: - Lifecycle
    
    var body: some View {
        List {
            ForEach($items) { $item in
                if( item.id == editingItemId){
                    TextField("", text: $item.title, onCommit: {
                        updateTask(item)
                        editingItemId = nil
                    })
                    .focused($focusItemId, equals: item.id ?? UUID())
                    
                    .onAppear{
                        focusItemId = item.id
                    }
                    
                    .onChange(of: editingItemId) {
                        if editingItemId == item.id {
                            focusItemId = item.id
                        }
                    }
                }
                else {
                    ListRowView(item: item)
                        .onTapGesture {
                            markAsCompleted(item: item)
                        }
                        .contentShape(Rectangle())
                        .contextMenu{
                            Button ("Edit"){
                                editingItemId = item.id
                            }
                        }
                }
            }
            .onDelete(perform: deleteItem)
        }
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        .navigationTitle(navigationTitle)
        .sheet(isPresented: $isPresentedNewItemSheet){
            
            AddNewItemView(isPresented: $isPresentedNewItemSheet,
                           newItem: $newItem,
                           items: $items)
            .presentationDetents([.medium])
            
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button(action: {
                    
                    isPresentedNewItemSheet = true
                    newItem = ""
                })
                {
                    Image(systemName: "plus")
                        .font(.system(size: 15,
                                      weight: .bold,
                                      design: .default))
                }
            }
        }
        .onAppear{
            loadTask()
        }
    }
    //  MARK: - Views
    
    //  MARK: - Utility
    
    func loadTask() {
        items = databaseManager.fetchAllTasks(forListId: UUID()) ?? []
        
    }
    
    func updateTask(_ item: ItemModel) {
        databaseManager.updateTask(task: item)
        loadTask()
        
    }
    
    func deleteItem (at offsets : IndexSet){
        offsets.forEach {index in
            let item = items[index]
            databaseManager.deleteTask(id: item.id)
            items.remove(at: index)
        }
    }
    
    func markAsCompleted(item: ItemModel) {
        var updatedTask = item
        updatedTask.isCompleted.toggle()
        updateTask(updatedTask)
    }
}
#Preview {
    NavigationView{
        
        MainListView(navigationTitle: "Title")
        // .environmentObject(ThemeManager())
    }
}


