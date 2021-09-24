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
    @State var article:Article
    @State var comments:[Comment]
    @ObservedObject private var forumController = ForumController()
    @State var editAction : Bool = false
    @State var deleteAction : Bool = false
    
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
        .toolbar{
            if NowUserName == article.user?.UserName {
                Menu {
                    Button(action:{
                        self.editAction.toggle()
                    }){
                        HStack {
                            Text("Edit")
                            Image(systemName: "pencil")
                        }
                    }
                    Button(action:{
                        self.deleteAction.toggle()
                    }){
                        HStack {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                    
               } label: {
                   Image(systemName: "square.and.pencil")
               }
            }
        }
        .alert(isPresented: self.$deleteAction, content: {
            Alert(title: Text("刪除此文章？"),
                  primaryButton: .default(Text("確定"),
                                          action: { forumController.DeleteArticle(articleID: article.id!)} ),
                  secondaryButton: .destructive(Text("取消")))
        })
        .sheet(isPresented: self.$editAction,
               content: {EditArticleCard(editAction: self.$editAction , title: article.Title, text: article.Text,article:article) })
     
        
    }
}

//struct MessageBoardView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        MessageBoardView()
//    }
//}
