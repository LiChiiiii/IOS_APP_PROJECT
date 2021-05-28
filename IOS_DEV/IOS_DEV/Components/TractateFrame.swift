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
                    HStack()
                    {
                        
                        Image("ka")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(30)
                            .padding(.leading,8)
                        Text(article.Title)
                        Spacer()
                    }
                    
                    Text(article.Title)
                        .font(.system(.title, design: .rounded))
                        .padding(.leading,8)
                   // Spacer()
                    Text(article.Text)
                        .padding(.leading,8)
                    //Spacer()
                    Text(article.createdOn)
                        .padding(.leading,8)
                    Spacer()
                    HStack()
                    {
                        Image(systemName:"text.bubble")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("65")
                        Image(systemName:"heart")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.pink)
                            
                        Text("75")
                        
                    }
                    .padding([.leading, .bottom],8)
                    
                }
                
            }
            .frame(width: 170, height: 175, alignment: .leading)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 2, x: 1.0, y: 1.0)
            .padding(.horizontal, 10)
       
    }
   
}


struct TractateFrame_Previews: PreviewProvider
{
    static var previews: some View
    {
        TractateFrame(article: ArticleList.first!)
    }
}
