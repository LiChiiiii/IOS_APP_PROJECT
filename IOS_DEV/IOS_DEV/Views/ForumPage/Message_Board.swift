//
//  Message_Board.swift
//  IOS_DEV
//
//  Created by 張馨予 on 2021/5/1.
//

import SwiftUI

struct Message_Board: View
{
    @State private var texts=""
    
    var ImageName:String = ""
    var UserName:String = ""
    var Content:String = ""
    
    var body: some View
    {
        
            HStack(spacing:0)
            {
                VStack(alignment:.leading)
                {
                    //Spacer()
                    HStack()
                    {
                        
                        Image(ImageName)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .cornerRadius(30)
                            .padding(.leading,15)
                        Text(UserName)
                        Spacer()
                    }
                    Text(Content)
                        .padding(25)
                    Divider()//分隔線
                    Spacer()
                    
                    HStack
                    {
                        TextField("your contents...", text: $texts)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {})
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

struct Message_Board_Previews: PreviewProvider
{
    static var previews: some View
    {
        
    
            Message_Board(ImageName: "ka", UserName: "UserName",Content: "the content in this topic.the content in this topic.the content in this topic.the content in this topic.the content in this topic.the content in this topic.the content in this topic.")
       
        
    }
}
