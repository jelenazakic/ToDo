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
    @ObservedObject private var databaseManager = DatabaseManager.shared
    @State private var newItem :String = ""
    @State private var isPresentedNewItemSheet: Bool = false
    @State var isCompleted: Bool = false
    @State var items: [ItemModel] = []
    @State private var isAnimatedPlusButton = false
    @State private var editingItemId: UUID? = nil
    @FocusState private var focusItemId: UUID?
    
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
                else{
                    
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
        items = databaseManager.fetchAllTasks()
        
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
        databaseManager.loadTask()
    }
    
    func markAsCompleted(item: ItemModel) {
        databaseManager.markTaskAsCompleted(task: item)
        loadTask()
    }
}


#Preview {
    NavigationView{
        
        MainListView(navigationTitle: "Title")
        // .environmentObject(ThemeManager())
    }
}


