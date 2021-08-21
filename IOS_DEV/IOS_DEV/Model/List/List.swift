//
//  List.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/8/1.
//

import Foundation

struct List: Decodable, Identifiable{       //取片單
    var id: UUID?
    var Title: String
    var user: ListOwner?
    var updatedOn: String   //db is 'DATE', but here is 'STRING'

}

struct ListOwner: Decodable, Identifiable{      //取片單的user
    var id: UUID
    var UserName: String
}

struct ListDetail:Decodable, Identifiable {         //取片單裡內容
    let id: UUID
    let text: String
    let movie: GetMovie?

}

struct GetMovie: Decodable, Identifiable{         //取片單裡的電影id
    let id: Int
    let title: String
}

struct ListDetail_Image:Decodable, Identifiable {   //用片單裡的電影id去tmdb抓照片
    let id: Int
    let title: String
    let posterPath: String?
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var posterHTTP: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
}
