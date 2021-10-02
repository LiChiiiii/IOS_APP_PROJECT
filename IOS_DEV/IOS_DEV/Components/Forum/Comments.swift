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
                        if comment.user!.UserName == "Abc" {
                            Image("p3")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(30)
                                .padding(.leading,15)
                        }
                        else if comment.user!.UserName == "Chichi" {
                            Image("pic")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(30)
                                .padding(.leading,15)
                        }
                        else if comment.user!.UserName == "Angelababy" {
                            Image("p1")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(30)
                                .padding(.leading,15)
                        }
                        else{
                            Image("p2")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(30)
                                .padding(.leading,15)
                        }
                        
//                        Image("ka")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .cornerRadius(30)
//                            .padding(.leading,15)
                        Text(comment.user!.UserName)
                        Spacer()
                        
                        VStack(alignment: .trailing,spacing:5)
                        {
                            HStack(){
                                
                  
                                
                                Text(comment.dateText)
                                    .padding(5)
                                    .foregroundColor(.gray)
                                
                                Image(systemName:"heart")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.pink)
                                
                                Text("\(comment.LikeCount)")
                                
                        
                            }
                            .font(.footnote)
                            .padding([.trailing],10)
                            
                        }
                        
                        
                    }
  
                    Text(comment.Text)
                        .font(.body)
                        .padding(20)
                        
                        
                        
                        
                 
                    
                    
                    Divider()//分隔線
                        .background(Color.gray)
                       
                    
                    
                    
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
