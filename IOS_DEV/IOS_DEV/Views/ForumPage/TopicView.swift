//
//  Topic.swift
//  new
//
//  Created by 張馨予 on 2021/3/21.
//

import SwiftUI


struct TopicView: View
{
    var articles:[Article]
    let FullSize = UIScreen.main.bounds.size

    
    var body: some View
    {
            VStack {
//                SearchBar(text: .constant(""))
//                    .position(x: 195, y: 50)
//                    .padding(.top, 70)
//                    .clipped()
//                    .ignoresSafeArea(edges: .top)
                Spacer()
        
                
                ScrollView(.vertical, showsIndicators: true)
                {
                    Spacer()
                    
                    //TODO
                    //two 'TopicFrame' in a Row
                    //self.articleDetails(articleID: article.id!)
         
                    ForEach(self.articles ,id: \.id) { article in
                      
                        HStack{
                         
                            TopicViewButton(article: article)
                        
                
                        }


                    }
                    
                }
//                .ignoresSafeArea(edges: .top)
//                .frame(width: FullSize.width,height:FullSize.height)
            }
           
                
            
    }
}



struct TopicViewButton:View{
    let controller = ForumController()
    @State var article:Article

    @State private var todo : Bool = false
    var body:some View{
        
        HStack{
            
            Button(action:{
                controller.articleDetails(articleID: article.id!)
       
            }){
                TopicFrame(article:article)
            }
            .simultaneousGesture(TapGesture().onEnded{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.todo = true
                })
            })
            .fullScreenCover(isPresented: $todo, content: {
                MessageBoardView(article: article ,comment: controller.commentData, todo:$todo)

            })
            
      
        }

    }

}


struct TopicView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            TopicView(articles: stubbedArticles)
        }
        .navigationBarHidden(true)
        .navigationBarTitle(Text("Home"))
        .edgesIgnoringSafeArea([.top, .bottom])

    }
}
