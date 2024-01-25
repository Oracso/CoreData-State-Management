//
//  NumberTextFieldView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//


import SwiftUI

struct NumberTextFieldView<T: Numeric>: View {
    
    init(_ number: Binding<T>, _ startingNumber: T = 0) {
        _localString = State(initialValue: String(describing: startingNumber))
        self._number = number
    }

    @State private var localString: String = ""
    
    @Binding var number: T
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        
        TextField("Weight", text: $localString)
            .keyboardType(.decimalPad)
            .focused($isFocused)
        
            .onChange(of: localString) {
                number = T(integerLiteral: localString as! T.IntegerLiteralType)
            }
        
        
        // MARK: Dismiss Keyboard
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
            }
        
        
            .onAppear() {
                UIApplication.shared.addTapGestureRecogniser()
            }
        
    }
}

#Preview {
    List {
        NumberTextFieldView(.constant(5), 55)
    }
}



extension UIApplication {
    func addTapGestureRecogniser() {
        guard let window = UIApplication.shared.currentUIWindow() else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecogniser(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
