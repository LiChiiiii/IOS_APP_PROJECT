//
//  TopicFrame.swift
//
//  Created by 張馨予 on 2021/3/18.
//

import SwiftUI

struct TopicFrame: View
{
    var article:Article
//    var commentData:[Comment]
    
    var body: some View
    {
        
            
            HStack(spacing: 0)
            {
            
//                NavigationLink(destination: MessageBoardView(article: article,comment: commentData ))
//                {
                    Image("ka")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 160)
                    .clipped()
                    //.overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                    //.cornerRadius(30.0)
                    Spacer()
                    Spacer()
                    VStack(alignment:.leading)
                    {
                        Spacer()
                        HStack()
                        {
                            Image("ka")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(30)
                            Text(article.user!.UserName)
                            Spacer()
                        }
                        .padding(.top,15)
                    
                        Text(article.Title)
                        .font(.system(.title, design: .rounded))
                        //Spacer()
                        Text(article.Text)
                        //Spacer()
                        Text(article.updatedOn)
                        Spacer()
                        HStack()
                        {
                        
//                            Image(systemName:"text.bubble")
//                            .resizable()
//                            .frame(width: 25, height: 25)
//                            Text("65")
                            Image(systemName:"heart")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.pink)
                            
                            Text(article.LikeCount)
                        
                        }
                        .padding(.bottom,25)
                    }
//                }
        }
        .frame(width: UIScreen.main.bounds.size.width-25, height: 160, alignment: .leading)
        .foregroundColor(.white).background(Color(hue: 1.0, saturation: 0.0, brightness: 0.144, opacity: 0.329))
        .shadow(color: .gray, radius: 0.5)
        .cornerRadius(20)
        .padding([.leading, .bottom, .trailing], 20)
   
        
            
        }
            
        
}

//struct TopicFrame_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        NavigationView
//        {
//            TopicFrame(topicc: TList.first!)
//        }
//    }
//}
