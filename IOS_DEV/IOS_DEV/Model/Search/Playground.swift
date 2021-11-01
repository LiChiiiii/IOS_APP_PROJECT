//
//  Playground.swift
//  IOS_DEV
//
//  Created by Jackson on 30/10/2021.
//

import Foundation

struct PersonInfoResponse : Decodable {
    let response : [PersonInfo]
}

struct GenreInfoResponse : Decodable {
    let response : [GenreInfo]
}

struct GenreInfo : Decodable {
    var id : Int //genre id
    var name : String //genre name
    var describe_img : String //using any image which movie can describe this Genre (URL)
    
    var posterImg: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\( describe_img)")!
    }
}
