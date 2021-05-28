//
//  MessageBoardView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/5/3.
//


import SwiftUI
import UIKit

struct Message_BoardView: View
{
    var body: some View
    {
        NavigationView
        {
            HStack(spacing: 0)
            {
                Message_Board(ImageName: "ka", UserName: "UserName",Content: "the content in this topic.the content in this topic.the content in this topic.the content in this topic.the content in this topic.the content in this topic.the content in this topic.")
            }
            .offset(y: -40)
        }
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea([.top, .bottom])
        
    }
}

struct Message_BoardView_Previews: PreviewProvider
{
    static var previews: some View
    {
        Message_BoardView()
    }
}
