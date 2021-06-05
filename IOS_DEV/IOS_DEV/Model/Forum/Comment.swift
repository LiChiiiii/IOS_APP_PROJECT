//
//  Comment.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/3.
//

import Foundation

struct Comment: Decodable, Identifiable{
    var id: UUID?
    var Text: String
    var user: CommentOwner?
    var article: article?
    var LikeCount: String
    var updatedOn: String   //db is 'DATE', but here is 'STRING'

}

struct CommentOwner: Decodable, Identifiable{
    var id: UUID
    var UserName: String
    var Email: String
    var Password: String
}

struct article: Decodable, Identifiable{
    var id: UUID
}
