//
//  EditListCard.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/9/24.
//

import Foundation
import SwiftUI

struct EditListCard:View{
    @ObservedObject private var listController = ListController()
    @Binding var editAction: Bool
    @Binding var title:String
    @Binding var listID:UUID?

    var body: some View {
        VStack{
            VStack{
                Text("Edit List Title ")
                    .foregroundColor(.black)
                    .font(.system(size: 20).bold())

                TextField(" ", text: $title)
                    .font(.system(size: 20))
                    .background(Color(.gray).opacity(0.1))
                    .foregroundColor(.black)
                    
            }
            .padding()
            
            Divider()
                .padding(.horizontal)
            
            HStack{
                
                Button(action: {
                    self.listController.putList(listID: self.listID! , listTitle: self.title)
                    self.editAction.toggle()
                })
                {
                    Text("Save")
                        .foregroundColor(.blue)
                        .padding()
                    
                }
                .disabled(self.title == "" ? true : false)
                .opacity(self.title == "" ? 0.5 : 1)
            
                
           
                Button(action: {
                    self.editAction.toggle()
                })
                {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .padding()
                    
                }
            
            }
            
        }
        .padding()
        .frame(width: screenSize.width*0.7, height: screenSize.height*0.24)
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: editAction ? 0 : screenSize.height)
        .animation(.spring())
        .shadow(color: .gray.opacity(0.5), radius: 6, x: -9, y: -9)
        
       
    
    }

}