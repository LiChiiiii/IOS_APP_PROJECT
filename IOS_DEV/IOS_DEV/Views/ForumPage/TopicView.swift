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
    let commentService = CommentService()
    @State var commentData:[Comment] = []
    @State var commentDataDelay:[Comment] = []
    @State private var GotoDetail : Bool = false
    @State var temp:Article  = Article(Title: "", Text: "", LikeCount: "", updatedOn: "")
    
    func articleDetails(articleID:article.ID){
        commentService.GETrequest(endpoint: "/comment/\(articleID)"){(result) in
            //print(result)
            switch result {
            case .success(let comments):
                print("comment success")
                self.commentData = comments

            case .failure: print("comment failed")
            }
        }
        
    }
    
    var body: some View
    {
        NavigationView{
            VStack()
            {
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
                            //test1
                            Button(action: {
                                print("button")
                                self.articleDetails(articleID: article.id!)
                                self.temp = article
                                
                            }){
                                TopicFrame(article:article)
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                    print("here")
                                    GotoDetail.toggle()
                                    
                                })
                            })
                            .fullScreenCover(isPresented: $GotoDetail, content: {
                                Text(temp.Title)
                                MessageBoardView(article: temp ,comment: commentData, GotoDetail: $GotoDetail )

                            })
                            
                            //test2
//                            NavigationLink(destination: MessageBoardView(article: article,comment: commentData, GotoDetail: $GotoDetail ))
//                            {
//                                TopicFrame(article:article)
//                            }.simultaneousGesture(TapGesture().onEnded{
//                                self.articleDetails(articleID: article.id!)
//                            })
                
                        }.padding(50)

 
                    }
                    
                }
                //.ignoresSafeArea(edges: .top)
                .frame(width: FullSize.width,height:FullSize.height)
                
            }
    }
    }
}


//struct TopicView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        NavigationView
//        {
//            TopicView()
//        }
//        .navigationBarHidden(true)
//        .navigationBarTitle(Text("Home"))
//        .edgesIgnoringSafeArea([.top, .bottom])
//
//    }
//}
