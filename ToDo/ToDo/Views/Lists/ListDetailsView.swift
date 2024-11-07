//
//  ListView.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//

import SwiftUI
import Combine

struct ListDetailsView: View {
    
    //  MARK: - Properties
    
    @State var isPresentedNewItemSheet: Bool = false
    @State var isCompleted: Bool = false
    @State var items: [ItemModel] = []
    @State var isAnimatedPlusButton = false
    @State var editingItemId: UUID? = nil
    @FocusState var focusItemId: UUID?
    
    var databaseManager = DatabaseManager.shared
    let navigationTitle: String
    
    //  MARK: - Lifecycle
    
    var body: some View {
        List {
            ForEach($items) { $item in
                if( item.id == editingItemId){
                    taskTextField(for: $item)
                }
                else {
                    taskRowView(for: item)
                }
            }
            .onDelete(perform: deleteItem)
        }
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        .navigationTitle(navigationTitle)
        .sheet(isPresented: $isPresentedNewItemSheet) {
            addNewItemSheetView
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                plusNavigationBarButton
            }
        }
        .onAppear {
            loadTask()
        }
    }
    
    //  MARK: - Views
    
    func taskRowView(for item: ItemModel) -> some View {
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
    
    func taskTextField(for item: Binding<ItemModel>) -> some View {
        TextField("", text: item.title, onCommit: {
            updateTask(item.wrappedValue)
            editingItemId = nil
        })
        .focused($focusItemId, equals: item.id)
        .onAppear {
            focusItemId = item.id
        }
        .onChange(of: editingItemId) {
            if editingItemId == item.id {
                focusItemId = item.id
            }
        }
    }
    
    var plusNavigationBarButton: some View {
        Button {
            isPresentedNewItemSheet = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 15, weight: .bold))
        }
    }
    
    var addNewItemSheetView: some View {
        AddNewItemView(
            isPresented: $isPresentedNewItemSheet,
            items: $items,
            listId: UUID()
        )
        .presentationDetents([.medium])
    }
    
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
        
        ListDetailsView(navigationTitle: "Title")
        // .environmentObject(ThemeManager())
    }
}


