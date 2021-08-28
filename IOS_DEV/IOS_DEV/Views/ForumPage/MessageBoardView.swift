//
//  Message_BoardView.swift
//  IOS_DEV
//
//  Created by 張馨予 on 2021/5/2.
//

import SwiftUI
import UIKit

struct GetMessageBoardView: View{
    @State var article:Article
    @ObservedObject private var forumController = ForumController()
    @State private var todo : Bool = false
 
    var body: some View {
        ZStack {

            if self.todo == true {
                MessageBoardView(article: article ,comments: forumController.commentData)
            }
            
        }
        .onAppear {
            self.forumController.articleDetails(articleID: article.id!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.todo = true
            })
       
        }
    }
}

struct MessageBoardView: View
{
    var article:Article
    var comments:[Comment]
//    @Binding var todo:Bool
    
    var body: some View
    {
        
        
        Spacer()
    
        
        ScrollView(.vertical, showsIndicators: false)
        {
           
            HStack(spacing: 0)
            {
            
                MessageBoard(article: article,comments: comments)
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
