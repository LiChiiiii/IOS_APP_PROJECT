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
    var user: UserID?
    var createdOn: String   //db is 'DATE', but here is 'STRING'
    var updatedOn: String
}

struct UserID: Decodable, Identifiable{
    var id: UUID
}


var ArticleList:[Article] = [
    
    Article(Title: "Hello!",
            Text: "testestestTEXT",
            createdOn: "2020-05-20",
            updatedOn: "2020-05-20"),
    Article(Title: "test222!",
            Text: "t222222",
            createdOn: "2020-05-21",
            updatedOn: "2020-05-21")
]

