//
//  Topic1.swift
//  new
//
//  Created by 張馨予 on 2021/3/22.
//

import SwiftUI

struct Topic1: View
{
    let FullSize = UIScreen.main.bounds.size
    var body: some View
    {
        VStack()
        {
            ZStack()
            {
                Image("wa")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(edges: .top)
                    .frame(width: FullSize.width, height: 250)
                    .clipped()
            LinearGradient(
                gradient: Gradient(colors: [.white, .gray]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
            .blendMode(.multiply)
            .frame(width: FullSize.width, height: 250)
                //漸層
            }
            
            
                
            ScrollView(.vertical, showsIndicators: true)
            {
                Spacer()
                HStack()
                    {
                    Square(ImageName: "ka", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12"){print("test")}
                            
                        
                    Square(ImageName: "wa", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12"){print("test")}
                            
                    }
                    .padding(.bottom)
                HStack()
                {
                    Square(ImageName: "ha", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12"){print("test")}
                    
                    Square(ImageName: "ja", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12")
                        {print("test")}
                }
                .padding(.bottom)
                HStack()
                {
                    Square(ImageName: "me", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12"){print("test")}
                    
                    Square(ImageName: "ta", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12")
                        {print("test")}
                }
                .padding(.bottom)
                HStack()
                {
                    Square(ImageName: "ka", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12")
                        {print("test")}
                    
                    Square(ImageName: "ja", TopicName: "Name", TopicTitle: "Title", Content: "Content", Date: "2020-05-12")
                        {print("test")}
                }
                .padding(.bottom)
                
            }
        }
        .ignoresSafeArea(edges: .top)
        .frame(width: FullSize.width, height: FullSize.height)
    }
}
    


struct Topic1_Previews: PreviewProvider
{
    static var previews: some View
    {
        Topic1()
    }
}
