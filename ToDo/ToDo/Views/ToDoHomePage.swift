//
//  ToDoHomePage.swift
//  ToDo
//
//  Created by Jelena Zakic on 10.9.24..
//

import SwiftUI

struct ToDoHomePage: View {
    
    var body: some View {
        NavigationView{
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                NavigationLink {
                    ListView(navigationTitle: "todo: jelena") // todo: ovde da se prosledjuje naziv iz liste
                } label: {
                    navigationItem
                }
            }
            .navigationTitle("My lists")
        }
    }
    
    var navigationItem: some View {
        HStack{
            Image(systemName: "checklist")
            Text("Shopping list") // todo: nazivi da budu dinamički
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
    }
}

#Preview {
    ToDoHomePage()
}
