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
    
    let navigationTitle: String
    
    //  MARK: - Lifecycle
    
    var body: some View {
        List {
            ForEach(items) { item in
                ListRowView(item: item)
                    .onTapGesture {
                        markAsCompleted(item: item)
                    }
            }
            .onDelete(perform: { indexSet in
                deleteItem(indexSet: indexSet)
            })
        }
        .listStyle(PlainListStyle())
        .navigationTitle(navigationTitle)
        .navigationBarItems(
            trailing:
                Button(
                    " ",
                    systemImage: "plus",
                    action: {
                        isPresented = true
                        newItem = ""
                    }
                )
                .font(.system(size: 15,weight: .bold, design: .default))
                .foregroundStyle(Color.blue)
        )
        .sheet(
            isPresented: $isPresented,
            content: {
                AddNewItemView(isPresented: $isPresented, newItem: $newItem, items: $items)
                    .presentationDetents([.fraction(0.3), .fraction(0.2)])
            }
        )
    }
    
    //  MARK: - Views
    
    //  MARK: - Utility
    
    func deleteItem (indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func markAsCompleted(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted = !items[index].isCompleted
        }
    }
    
    
}

#Preview {
    NavigationView{
        
        MainListView(navigationTitle: "Title")
    }
}


