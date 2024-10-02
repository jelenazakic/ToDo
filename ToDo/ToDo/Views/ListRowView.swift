//
//  ListRowView.swift
//  ToDo
//
//  Created by Jelena Zakic on 5.9.24..
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack{
            
            Image(systemName: item.isCompleted ?  "checkmark":"circle.dotted" )
            Text(item.title).strikethrough(item.isCompleted, color: .black)
        }
        
    }
    
    struct ListRowView_Previews: PreviewProvider{
        
        static var item1 = ItemModel(title: "Prvi", isCompleted: true)
        static var item2 = ItemModel(title: "Drugi", isCompleted: false)
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
    ListRowView(item: ItemModel(title: "Sample 1", isCompleted: false))
    
}

