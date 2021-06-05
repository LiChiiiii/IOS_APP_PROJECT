//
//  Comments.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/3.
//

import SwiftUI

struct Comments: View
{
    var comment:Comment
    var body: some View
    {
        
            HStack(spacing:0)
            {
                VStack(alignment:.leading)
                {
                    //Spacer()
                    HStack()
                    {
                        
                        Image("ja")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .cornerRadius(30)
                            .padding(.leading,15)
                        Text(comment.user!.UserName)
                        Spacer()
                    }
                    Text(comment.Text)
                        .padding(5)
                    
                    HStack(){
                        Text(comment.updatedOn)
                            .padding(5)
                        
                        Image(systemName:"heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.pink)
                        
                        Text(comment.LikeCount)
                    }
                    
                    
                    Divider()//分隔線
                    
                    
                    
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
