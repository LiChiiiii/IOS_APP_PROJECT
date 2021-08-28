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
    var updatedOn: String?   //db is 'DATE', but here is 'STRING'
    
    init(id: UUID? = nil, Title:String, Text:String, LikeCount:String, updatedOn: String){
        self.id = id
        self.Title = Title
        self.Text = Text
        self.user = ArticleOwner(UserName: "", Email: "", Password: "")
        self.movie = Board(id:0, title: "")
        self.LikeCount = LikeCount
        self.updatedOn = updatedOn
    }
    
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    var dateText: String {
        guard let updatedOn = self.updatedOn, let date = Utils.Formatter.date(from: updatedOn) else {
            return "n/a"
        }
        return Article.dateFormatter.string(from: date)
    }
    
    var timeText: String {
        guard let updatedOn = self.updatedOn, let date = Utils.Formatter.date(from: updatedOn) else {
            return "n/a"
        }
        return Article.timeFormatter.string(from: date)
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



let stubbedArticles:[Article] = [
    Article(Title: "AAAA", Text: "bbb", LikeCount: "123", updatedOn: "123"),
    Article(Title: "B123BB", Text: "bbb", LikeCount: "123", updatedOn: "123"),
    Article(Title: "CCCC34234C", Text: "bbb", LikeCount: "123", updatedOn: "123")
]
