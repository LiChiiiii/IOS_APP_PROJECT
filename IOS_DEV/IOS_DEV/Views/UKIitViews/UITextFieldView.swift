//
//  UITextFieldView.swift
//  IOS_DEV
//
//  Created by Jackson on 30/7/2021.
//

import SwiftUI
import UIKit

struct UITextFieldView : UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    @AppStorage("seachHistory") private var history : [String] =  []
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var SearchMV : SearchBarViewModel
    let keybooardType : UIKeyboardType
    let returnKeytype : UIReturnKeyType
    let tag:Int
//    let placeholder : String
//    @Binding var text:String
//    @Binding var getResult : Bool
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = keybooardType
        textField.returnKeyType = returnKeytype
        textField.tag = tag
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.placeholder = SearchMV.recommandPlachold
        textField.textColor = .white
        textField.tintColor = .darkGray
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = self.SearchMV.searchingText == "" ?  "" : self.SearchMV.searchingText
        if self.StateManager.isFocuse[tag]{
            uiView.becomeFirstResponder()
        }else{
            uiView.resignFirstResponder()
        }
    
    }
    
    class Coordinator:NSObject,UITextFieldDelegate{
        var parent : UITextFieldView
        
        init(_ textField:UITextFieldView){
            self.parent = textField
        }
        
        //check current text is larger than a length
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let maxLength = 32
            let currentStr : NSString = (textField.text ?? "") as NSString
            let newStr : NSString = currentStr.replacingCharacters(in: range, with: string) as NSString
            return newStr.length <= maxLength
        }

        //change it every keystroke
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if self.parent.StateManager.isSeaching {
                self.parent.StateManager.isEditing = textField.text == "" ? false : true
                
                if textField.text != nil{
                    let str = textField.text!.description
                    self.parent.SearchMV.searchingText = str
                    self.parent.SearchMV.getRecommandationList(keyWork:textField.text!)
                }
            }
            
        }
        
        func updatefocus(textfield: UITextField) {
            textfield.becomeFirstResponder()
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if parent.tag == 0{
                parent.StateManager.isFocuse = [false,true]
            }else{
                parent.StateManager.isFocuse = [false,false]
            }
            var keyWord = textField.text ?? ""
            
            if keyWord == ""{
                keyWord = self.parent.SearchMV.recommandPlachold
            }

            parent.SearchMV.searchingText = keyWord
            parent.StateManager.isEditing = false
            parent.StateManager.isSeaching = false
            updateHistory(history: keyWord)
            parent.StateManager.getSearchResult = true
            self.parent.StateManager.searchingLoading = true

            return true
        }
        
        func updateHistory(history : String){
            
            if self.parent.history.count == 15{
                self.parent.history.removeLast()
            }
            
            let exist = self.parent.history.contains{$0 == history}
            if exist{
                let index = self.parent.history.firstIndex(of: history)
                self.parent.history.remove(at: index!)
            }
            self.parent.history.insert(history, at: 0)
        }

    }
}
