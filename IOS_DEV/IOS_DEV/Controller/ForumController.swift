//
//  ForumController.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/5.
//

import Foundation

class ForumController: ObservableObject {
    
    let commentService = CommentService()   //post comment
    let articleService = ArticleService() //get
    @Published var commentData:[Comment] = []
    @Published var articleData:[Article] = []
    
   
    //--------------------------------get某電影的討論區文章--------------------------------//
    func GetAllArticle(movieID:Int){
        articleService.GET_allArticle(endpoint: "/article/\(movieID)"){(result) in
            //print(result)
            switch result {
            case .success(let res):
                print("article success")
                self.articleData = res

            case .failure:
                print("article failed")
            }
        }
    }
    
    //--------------------------------get我發的討論區文章--------------------------------//
    func GetMyArticle(userID:UUID){
        articleService.GET_allArticle(endpoint: "/article/my/\(userID)"){(result) in
            //print(result)
            switch result {
            case .success(let res):
                print("my article success")
                self.articleData = res

            case .failure:
                print("my article failed")
            }
        }
    }
    
    //---------------------刪除文章---------------------//
    func DeleteArticle(articleID: UUID){
      
        articleService.DELETE_Article(endpoint: "/article/delete/\(articleID)"){ (result) in
            switch result {
            case 200 :
                print("delete article success")

            default:
                print("delete article failed")
            }
            
        }
    }
    
    
    //---------------------抓留言---------------------//
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

