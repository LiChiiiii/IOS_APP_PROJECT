//
//  MyListView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/9/5.
//

import Foundation
import SwiftUI


struct MyListView: View {
    var lists:[CustomList]
    @State var cardShown : Bool = false
    @State private var isAppear:Bool = false
    @State private var showAnimation = false
    let FullSize = UIScreen.main.bounds.size
    var columns = Array(repeating: GridItem(.flexible(),spacing:15), count: 2)
    
    var body: some View{
        
        
        Spacer()
        
        ScrollView(.vertical, showsIndicators: false){
     
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
  
                
                VStack()
                {
                
        
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(self.lists ,id: \.id) { list in
                           
                            MyListButton(list: list)
  
                        }
                    }
        
                    
                }
                .ignoresSafeArea(edges: .top)
                

                
                
            })
            .sheet(isPresented: $cardShown, content: {
                NewListCard()
            })
            
        
                
            
            
        }
        .navigationTitle("My List")
        .toolbar{
            Button(action:{
                self.cardShown.toggle()
            }){
                HStack{
                    Image(systemName: "plus")
//                    Text( "ADD")
                }
               
            }
         
        }
        
    
    }

}


struct MyListButton:View{
    @ObservedObject private var listController = ListController()
    @State var list:CustomList
    @State private var todo : Bool = false

    var body:some View{
        
        HStack{
            
            Button(action:{
                listController.GetListDetail(listID: list.id!)  //取得片單內容
            }){
               
                
                VStack(alignment:.leading){
                    
                
                    HStack(){
                        Image("ka")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(30)
                        Text(list.user!.UserName)
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }
                    .padding(.top,15)
                    
                    
                    
                    Text(list.Title)
                        .bold()
                        .font(.system(size: 20))
                        .padding(.top,25)
                            
                    
                    Spacer()
                    
                    
                }
                .frame(width:170,height: 170)
                .background(BlurView().cornerRadius(25))
                //.background(Color(hue: 1.0, saturation: 0.0, brightness: 0.144, opacity: 0.329))
                .shadow(color: .gray, radius: 0.5)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(8)
        

            
            }
            .simultaneousGesture(TapGesture().onEnded{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.todo = true
                })
            })
            .fullScreenCover(isPresented: self.$todo, content: {
                ListDetailView(todo: self.$todo, listDetails: listController.listDetails, listOwner: NowUserName, listTitle: list.Title)
                
            })
            .contextMenu{
                Button(action: {
                    // edit
                }) {
                    HStack {
                        Text("Edit")
                        Image(systemName: "pencil")
                    }
                }

                Button(action: {
                     // delete the selected restaurant
                 }) {
                     HStack {
                         Text("Delete")
                         Image(systemName: "trash")
                     }
                 }


            }
            
            
      
        }

    }

}





