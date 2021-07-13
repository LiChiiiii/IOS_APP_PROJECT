//
//  ArticleController.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/5.
//

import Foundation
class ArticleController: ObservableObject {
    
    let commentService = CommentService()
    @Published var commentData:[Comment] = []

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
