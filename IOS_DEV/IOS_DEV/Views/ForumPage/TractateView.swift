//
//  TractateView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/5/23.
//

import Foundation
import SwiftUI

struct TractateView: View
{
    var articles:[Article]
    let FullSize = UIScreen.main.bounds.size

    
    
    var body: some View
    {
        NavigationView{
        VStack()
        {
            //top pic can not move
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
                
                    //TODO
                    //two 'TractateFrame' in a Row
         
                    ForEach(self.articles ,id: \.Title) { article in
                        NavigationLink(destination:Message_BoardView()) {
                            HStack
                            {
                                TractateFrame(article:article)
                                TractateFrame(article:article)
                            }.padding(.bottom)
                                
                        }.foregroundColor(.black)
                    }
                            
            }
        }
        .ignoresSafeArea(edges: .top)
        .frame(width: FullSize.width, height: FullSize.height)
        
        }
    }
}
//
//struct TractateView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        TractateView()
//    }
//}
