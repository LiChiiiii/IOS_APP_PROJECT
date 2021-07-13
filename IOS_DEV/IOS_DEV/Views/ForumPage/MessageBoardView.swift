//
//  Message_BoardView.swift
//  IOS_DEV
//
//  Created by 張馨予 on 2021/5/2.
//

import SwiftUI
import UIKit

struct MessageBoardView: View
{
    var article:Article
    var comment:[Comment]
    @Binding var todo:Bool
    
    var body: some View
    {
        
        
        Spacer()
    
        Button(action:{
            withAnimation(){
                todo.toggle()

            }
        }){
            HStack {
                Image(systemName: "arrow.backward")
                    .font(.title)
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.bottom,20)
                    .padding(.leading)
                Spacer()

            }
        }
    
        
        ScrollView
        {
           
            HStack(spacing: 0)
            {
                MessageBoard(article: article,comments: comment)
            }
            
        }
       
        
    }
}

//struct MessageBoardView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        MessageBoardView()
//    }
//}
