//
//  Article.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/5/22.
//

import Foundation

struct Article: Decodable, Identifiable{
    var id: UUID?
    var Title: String
    var Text: String
    var user: ArticleOwner?
    var movie: Board?
    var LikeCount: String
    var updatedOn: String   //db is 'DATE', but here is 'STRING'
    
    init(id: UUID? = nil, Title:String, Text:String, LikeCount:String, updatedOn: String){
        self.id = id
        self.Title = Title
        self.Text = Text
        self.user = ArticleOwner(UserName: "", Email: "", Password: "")
        self.movie = Board(id:0, title: "")
        self.LikeCount = LikeCount
        self.updatedOn = updatedOn
    }
    
}

struct ArticleOwner: Decodable, Identifiable{
    var id: UUID?
    var UserName: String
    var Email: String
    var Password: String
    
    init(id:UUID? = nil, UserName: String, Email:String, Password:String)
    {
        self.id = id
        self.UserName = UserName
        self.Email = Email
        self.Password = Password
    }
}

struct Board: Decodable, Identifiable{
    var id: Int
    var title: String
    
    init(id:Int , title:String)
    {
        self.id = id
        self.title = title
    }
}


