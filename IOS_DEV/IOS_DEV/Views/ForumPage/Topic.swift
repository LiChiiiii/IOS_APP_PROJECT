//
//  Topic.swift
//  new
//
//  Created by 張馨予 on 2021/3/21.
//

import SwiftUI

struct Topic: View
{
    
    var body: some View
    {
        
//        func Article(){
//            networkingService.request(endpoint: "/article"){(result) in
//                print(result)
//                switch result {
//                case .success: print("article success")
//                case .failure: print("article failed")
//                }
//
//            }
//        }
        let FullSize = UIScreen.main.bounds.size
            VStack()
            {
                SearchBar(text: .constant(""))
                    //.position(x: 195, y: 50)
                    .padding(.top, 70)
                    .clipped()
                    .ignoresSafeArea(edges: .top)
                Spacer()
                
                ScrollView(.vertical, showsIndicators: true)
                {
                        
                        RoundedRectangle(ImageName:"ka",TopicName: "刻在心底",TopicTitle: "Title",Content: "Here is content",Date: "2020-09-18")
                        
                        RoundedRectangle(ImageName:"ta",TopicName: "怪胎",TopicTitle: "Title",Content: "Here is content",Date: "2020-05-12")
                        
                        RoundedRectangle(ImageName:"wa",TopicName: "孤味",TopicTitle: "Title",Content: "Here is content",Date: "2020-10-22")
                        
                        RoundedRectangle(ImageName:"me",TopicName: "我沒有談的那場戀愛",TopicTitle: "Title",Content: "Here is content",Date: "2021-03-18")
                    
                    RoundedRectangle(ImageName:"ka",TopicName: "刻在心底",TopicTitle: "Title",Content: "Here is content",Date: "2020-09-18")
                        

                    
                }
                .ignoresSafeArea(edges: .top)
                .frame(width: FullSize.width,height:750)
                
            }
                
    }
}


struct Topic_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            Topic()
        }
        .navigationBarHidden(true)
        .navigationBarTitle(Text("Home"))
        .edgesIgnoringSafeArea([.top, .bottom])
        
    }
}
