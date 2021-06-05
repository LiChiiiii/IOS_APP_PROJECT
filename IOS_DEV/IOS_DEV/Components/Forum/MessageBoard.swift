//
//  Message_Board.swift
//  IOS_DEV
//
//  Created by 張馨予 on 2021/5/1.
//

import SwiftUI

struct MessageBoard: View
{
    @State private var texts=""
    
    var article:Article
    @State var comments:[Comment]
    let commentService = CommentService()

    func PostComment(){
        
        let com = CommentTodo(Text: self.texts, UserName: NowUser, ArticleID: article.id!.uuidString , LikeCount: "0")
       
        print(com)
        commentService.POSTrequest(endpoint: "/comment", RegisterObject: com){(result) in
            //print(result)
            switch result {
           
            case .success: print("PostComment success")
                commentService.GETrequest(endpoint: "/comment/\(article.id!)"){(result) in
                    //print(result)
                    switch result {
                    case .success(let comments):
                        print("updated comment")
                        self.comments = comments
                        self.texts=""   //  clear textfield

                    case .failure: print("comment failed")
                    }
                }

            case .failure: print("PostComment failed")
            }
        }
        
    }
    
    var body: some View
    {
        
            HStack(spacing:0)
            {
                VStack(alignment:.leading)
                {
                    //Spacer()
                    HStack()
                    {
                        
                        Image("ka")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .cornerRadius(30)
                            .padding(.leading,15)
                        Text(article.user!.UserName)
                        Spacer()
                    }
                 
                    Text(article.Title)
                        .font(.system(.title, design: .rounded))
                        .padding(25)
                    Text(article.Text)
                        .padding(25)
                    HStack{
                        Text(article.updatedOn)
                            .padding(25)
                        
                        Image(systemName:"heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.pink)
                        
                        Text(article.LikeCount)
                    }
                   
                    Divider()//分隔線
                    
                    
                    VStack
                    {
                        ForEach(self.comments ,id: \.id) { comment in
                            HStack
                            {
                                Comments(comment: comment)
                            }.padding(.bottom)

                        }
                    }
                    
                    
                    
                    HStack
                    {
                        TextField("your contents...", text: $texts)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: { PostComment() })
                        {
                            Image(systemName: "paperplane")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.gray)
                                .offset(x: -10)
                        }
                        
                    }
                   // .offset(y:20)
                    
                }
            }
    }
}

//struct MessageBoard_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//
//
//        MessageBoard(article: MList.first!)
//
//
//    }
//}
