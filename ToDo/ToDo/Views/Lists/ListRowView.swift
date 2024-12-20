//
//  ListRowView.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//

import SwiftUI

struct ListRowView: View {
    
    let item: TaskModel
    @AppStorage("appTheme") private var appTheme: String = "dark"
    
    var body: some View {
        HStack{
            
            Image(systemName: item.isCompleted ?  "checkmark":"circle.dotted" )
            Text(item.title)
                .strikethrough(item.isCompleted, color: strikethroughColor())
                .padding()
        }
    }
    private func strikethroughColor() -> Color {
        if appTheme == "dark" {
            print("Test")
            return .white
        } else if appTheme == "light" {
            
            return .black
        } else {
            return .primary
        }
    }
    
    struct ListRowView_Previews: PreviewProvider{
        
        static var item1 = TaskModel(title: "Prvi", isCompleted: true,listId: UUID())
        static var item2 = TaskModel(title: "Drugi", isCompleted: false, listId: UUID())
        static var previews: some View{
            
            Group{
                ListRowView (item:item1)
                ListRowView (item:item2)
            }
            .previewLayout(.sizeThatFits)
        }
        
    }
}
#Preview {
    ListRowView(item: TaskModel(title: "Sample 1", isCompleted: false,listId: UUID()))
    
}

