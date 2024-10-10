//
//  ListView.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//

import SwiftUI

struct MainListView: View {
    
    //  MARK: - Properties
    @State private var newItem :String = ""
    @State private var isPresented: Bool = false
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
                        editingItemId = nil
                    })
                    .focused($focusItemId, equals: item.id)
                    .onAppear{
                        focusItemId = item.id
                    }
                    .onChange(of: editingItemId) {
                        if editingItemId == item.id {
                            focusItemId = item.id
                        }
                    }
                } else{
                    
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
            .onDelete(perform: { indexSet in
                deleteItem(indexSet: indexSet)
            })
        }
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        .navigationTitle(navigationTitle)
        .sheet(
            isPresented: $isPresented,
            content: {
                
                AddNewItemView(isPresented: $isPresented,
                               newItem: $newItem,
                               items: $items)
                .presentationDetents([.fraction(0.3), .fraction(0.2)])
            }
        )
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button(action: {
                    isPresented = true
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
    }
    //  MARK: - Views
    
    //  MARK: - Utility
    
    func deleteItem (indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func markAsCompleted(item: ItemModel) {
        if let index = items.firstIndex(where: {
            $0.id == item.id }) {
            items[index].isCompleted = !items[index].isCompleted
        }
    }
}


#Preview {
    NavigationView{
        
        MainListView(navigationTitle: "Title")
        // .environmentObject(ThemeManager())
    }
}


