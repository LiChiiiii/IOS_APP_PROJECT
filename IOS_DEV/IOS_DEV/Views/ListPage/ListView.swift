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
    var lists:[List]
    let FullSize = UIScreen.main.bounds.size
    var columns = Array(repeating: GridItem(.flexible(),spacing:15), count: 2)
    
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
            
                
            ScrollView(.vertical, showsIndicators: false)
            {
                Spacer()
                
                    //TODO
                    //two 'TractateFrame' in a Row
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(self.lists ,id: \.id) { list in
                        
                      
                        ListButton(list: list)
                    }
                }
         

                            
            }
            
        
            
        }
        .ignoresSafeArea(edges: .top)
//        .frame(width: FullSize.width, height: FullSize.height)
        

        
       
    

    }
}


struct ListButton:View{
    @ObservedObject private var listController = ListController()
    @State var list:List
    @State private var todo : Bool = false

    var body:some View{
        
        HStack{
            
            Button(action:{
                listController.GetListDetail(listID: list.id!)  //取得片單內容
                
            }){
               
               
                VStack(){
                    Text(list.Title)
                        .bold()
                        .font(.system(size: 22))
                }
                .frame(width:170,height: 170)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.144, opacity: 0.329))
                .shadow(color: .gray, radius: 0.5)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(8)
                 

            
            }
            .simultaneousGesture(TapGesture().onEnded{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.todo = true
                    
//                    ForEach(listController.listDetails, id:\.id) { movie in
//                    }
                    
                })
            })
            .fullScreenCover(isPresented: $todo, content: {
               // ListDetailView(todo: $todo)
                
                //ListDetailView不能一次抓所有的照片
            })
          
            
      
        }

    }

}


//struct ListView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        ListView(articles: stubbedArticles, index: 0)
//    }
//}
