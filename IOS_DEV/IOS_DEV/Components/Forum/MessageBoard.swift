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

    
    var body: some View
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
                .bold()
                .padding(25)
             
         
        
            Text(article.Text)
                .font(.body)
                .padding(25)
                

            
            HStack()
            {
                Text(article.timeText)
                    .padding(25)
                    .foregroundColor(.gray)

                Image(systemName:"heart")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(.pink)

                Text(article.LikeCount)
            }
            .font(.footnote)
           
            Divider()//分隔線
                .background(Color.gray)


            
            ForEach(self.comments ,id: \.id) { comment in
                Comments(comment: comment)
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
  
            
        }
            
    }
    
    func PostComment(){
        
        let com = CommentTodo(Text: self.texts, UserName: NowUserName, ArticleID: article.id!.uuidString , LikeCount: "0")
       
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
