import SwiftUI

struct AddNewListView: View {
    
    // MARK: - Properties
    
    @Binding var newNameList: String
    @Binding var lists: [ListModel]
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    var listId: UUID
    
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
            .foregroundStyle(Color.gray)
            .autocorrectionDisabled()
       
    }
    
    private var saveNewListButton: some View {
        
        Button(action: onSaveNewListButtonTap) {
            Text("Save")
                .frame(width: 80, height: 1)
                .padding(5)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
        }
        .buttonStyle(GrowingButton())
    }
    
    // MARK: - Utility
    private func onSaveNewListButtonTap() {
        if let newListId = DatabaseManager.shared.insertList(title: newNameList) {
            lists = DatabaseManager.shared.fetchAllLists()
            newNameList = ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil,
                                            from: nil,
                                            for: nil)
            presentationMode.wrappedValue.dismiss()
            //isPresented = false
        }
    }
    
    struct GrowingButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.5 : 1)
                .animation(.easeOut(duration: 1.2), value: configuration.isPressed)
        }
    }
}
#Preview {
    AddNewListView(newNameList: .constant(""),
                   lists: .constant([]),
                   isPresented: .constant(false),
                   listId: UUID())
}

