//
//  ForumController.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/5.
//

import Foundation

class ForumController: ObservableObject {
    
    let commentService = CommentService()   //post comment
    let networkingService = NetworkingService() //get
    @Published var commentData:[Comment] = []
    @Published var articleData:[Article] = []
    @Published var isPresented = false
    
   
        
    func GetAllArticle(){
        networkingService.request(endpoint: "/article"){(result) in
            //print(result)
            switch result {
            case .success(let article):
                print("article success")
                self.articleData = article
                self.isPresented = true

            case .failure: print("article failed")
            }
        }
    }
    
    func articleDetails(articleID:article.ID){
        commentService.GETrequest(endpoint: "/comment/\(articleID)"){(result) in
            //print(result)
            switch result {
            case .success(let comments):
                print("comment success")
                self.commentData = comments

            case .failure: print("comment failed")
            }
        }
    }
}

