import SwiftUI

struct AddNewListView: View {
    
    // MARK: - Properties
    @Binding var newNameList: String
    @Binding var lists: [ListModel]
    @Binding var isPresented: Bool 

    // MARK: - Lifecycle
    var body: some View {
        VStack {
            newListTextField
            saveNewListButton
        }
        .padding()
    }
    
    // MARK: - Views
    private var newListTextField: some View {
        TextField("Enter New List", text: $newNameList)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(20)
    }
    
    private var saveNewListButton: some View {
        Button(action: onSaveNewListButtonTap) {
            Text("Save")
                .frame(width: 100, height: 20)
                .padding(5)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
        }
    }
    
    // MARK: - Utility
    private func onSaveNewListButtonTap() {
       
    
        let newList = ListModel(name: newNameList, tasks: [])
        lists.append(newList)
        newNameList = ""
        isPresented = false
    }
}

#Preview {
    AddNewListView(newNameList: .constant(""),
                   lists: .constant([]),
                   isPresented: .constant(false))
}

