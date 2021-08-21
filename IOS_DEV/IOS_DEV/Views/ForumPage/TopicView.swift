//
//  Topic.swift
//  new
//
//  Created by 張馨予 on 2021/3/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct GetTopicView: View{
    let movie: Movie
    @ObservedObject private var forumController = ForumController()
 
    var body: some View {
        ZStack {

            TopicView(articles: forumController.articleData, movie: movie)
            
            
        }
        .onAppear {
            self.forumController.GetAllArticle()
            
        }
    }
}

struct TopicView: View
{
    let articles:[Article]
    let movie: Movie
    let FullSize = UIScreen.main.bounds.size

    
    var body: some View
    {

        
        VStack {

            ZStack()
            {
                WebImage(url: movie.backdropURL)
                    .resizable()
                    .ignoresSafeArea(edges: .top)
                    .frame(width: FullSize.width, height: 100)
                
                Text(movie.title)
                    .bold()
                    .font(.system(size: 30))
                    .padding(25)
                    .foregroundColor(.white)

            }
            
            
            ScrollView(.vertical, showsIndicators: true)
            {
                Spacer()
                
                ForEach(self.articles ,id: \.id) { article in
                  
                    HStack{
                        
                        NavigationLink(destination:   GetMessageBoardView(article: article))
                        {
                            TopicFrame(article:article)
                        }

                     
//                        TopicViewButton(article: article)
                            
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
//                MessageBoardView(article: article ,comment: controller.commentData, todo:$todo)

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
            TopicView(articles: stubbedArticles, movie: stubbedMovie[0])
        }
        .navigationBarHidden(true)
        .navigationBarTitle(Text("Home"))
        .edgesIgnoringSafeArea([.top, .bottom])

    }
}
