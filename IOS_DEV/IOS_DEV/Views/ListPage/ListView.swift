//
//  ListView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/10.
//


import Foundation
import SwiftUI

struct ListView: View
{
    var articles:[Article]
    let FullSize = UIScreen.main.bounds.size
    var columns = Array(repeating: GridItem(.flexible(),spacing:15), count: 2)
    @State var index : Int
    
    var body: some View
    {
        VStack()
        {
            //top pic can not move
            ZStack()
            {
                Image("ta")
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

            
            }
            
                
            ScrollView(.vertical, showsIndicators: true)
            {
                Spacer()
                
                    //TODO
                    //two 'TractateFrame' in a Row
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(self.articles ,id: \.id) { article in
                      
                        ListButton(article: article,index: self.$index)
                    }
                }
         

                            
            }
            
        
            
        }
        .ignoresSafeArea(edges: .top)
//        .frame(width: FullSize.width, height: FullSize.height)
        
        if self.index == 1 {    // if click the button
//            MovieCoverStackRemovablePreview(movies: coverList, backHomePage: .constant(false)).transition(.slide)
        }
        
       
    

    }
}


struct ListButton:View{
    let controller = ArticleController()
    @State var article:Article
    @State private var todo : Bool = false
    @Binding var index:Int

    var body:some View{
        
        HStack{
            
            Button(action:{
                controller.articleDetails(articleID: article.id!)
                self.index = 1
       
            }){
               
               
                VStack(){
                    Text("2020必追韓劇")
                        .bold()
                        .font(.system(size: 22))
                }
                .frame(width:170,height: 170)
//                .background(Rectangle().fill(Color(hue: 0.122, saturation: 0.678, brightness: 0.721, opacity: 0.805)).blur(radius: 20))
                .background(
                    Image("ta")
                        .resizable()
                        .blur(radius: 20))
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(8)
                 

            
            }
            .simultaneousGesture(TapGesture().onEnded{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.todo = true
                })
            })
//            .fullScreenCover(isPresented: $todo, content: {
//                MovieCoverStackRemovablePreview(movies: coverList, backHomePage: .constant(false))
//
//            })
          
            
      
        }

    }

}


//struct TractateView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        TractateView()
//    }
//}
