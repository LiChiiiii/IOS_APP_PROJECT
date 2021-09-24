//
//  ArticleTodo.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/9/25.
//

import Foundation

//------------------發表新文章（POST)------------------//
struct NewArticle: Decodable, Encodable {
    var Title : String
    var Text : String
    var movieID : Int
    var userID : UUID
}

//------------------編輯文章（PUT)------------------//
struct UpdateArticle: Decodable, Encodable {
    var articleID : UUID
    var Title : String
    var Text : String
    var LikeCount: Int
}

