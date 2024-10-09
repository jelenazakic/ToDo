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
            .foregroundStyle(Color.gray)
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
                .buttonStyle(GrowingButton())
                
                
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
struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 2.2 : 1)
            .animation(.easeOut(duration: 1.2), value: configuration.isPressed)
    }
}
#Preview {
    AddNewListView(newNameList: .constant(""),
                   lists: .constant([]),
                   isPresented: .constant(false))
}

