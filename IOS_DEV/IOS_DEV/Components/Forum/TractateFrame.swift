//
//  TractateFrame.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/5/23.
//

import Foundation
import SwiftUI

struct TractateFrame: View
{
    var article:Article

    
    var body: some View
    {
        
       
            HStack(spacing:0)
            {
                
                VStack(alignment:.leading)
                {
                    Spacer()
                    Spacer()
                    HStack()
                    {
                        Image("ka")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(30)
                            .padding(.leading,8)
                        Text(article.user!.UserName)
                        Spacer()
                    }
                    
                    Text(article.Title)
                        .font(.system(.title, design: .rounded))
                        .padding(.leading,8)
                    Spacer()
                    Text(article.Text)
                        .padding(.leading,8)
                    Spacer()

                    Text(article.updatedOn)
                        .padding(.leading,8)
                    
                    
                    HStack()
                    {
//                        Image(systemName:"text.bubble")
//                            .resizable()
//                            .frame(width: 25, height: 25)
//                        Text("20")
                        Spacer()
                        Image(systemName:"heart")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.pink)
                        Text(article.LikeCount)

                    }
                    .padding([.trailing,.bottom],20)
                    
                    Spacer()
                    
                    
                
                    
                }
                
            }
            .frame(width: 170, height: 190, alignment: .leading)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 2, x: 1.5, y: 1.5)
            .padding(.horizontal, 10)
            .foregroundColor(.black)
            
       
    }
   
}


//struct TractateFrame_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        TractateFrame(article: ArticleList.first!)
//    }
//}
