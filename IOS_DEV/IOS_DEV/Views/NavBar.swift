//
//  NavBar.swift
//  IOS_DEV
//
//  Created by Jackson on 17/4/2021.
//

import SwiftUI
let controller = NavBarController()
//Working Process
struct NavBar: View {
//    @Binding var selectedIndex:Int
    @State var index : Int
    @State var GroupSelect : Bool = false
    
    var body: some View {
        
        VStack{

            ZStack{
                if self.index == 0 {
                   HomePage()
                    
                }
                if self.index == 1 && GroupSelect == true{
                    ListView(articles: controller.articleData, index: 0)
                   
                }
                if self.index == 2 {
                    AutoScroll_V().preferredColorScheme(.dark)

                }
                if self.index == 3 {
                    ProfileView()
                        .preferredColorScheme(.dark)
                }
             

            }
            NavItemButton(index: self.$index ,GroupSelect: self.$GroupSelect)
        }
        
//        HStack(alignment:.bottom,spacing:0){
//                Spacer()
//                NavItemButton(buttonIndex: 0, itemIcon: "film", itemText: "Home", isSelectedInt: $selectedIndex){
//                    selectedIndex = 0
//                }
//            Spacer()
//                NavItemButton(buttonIndex: 1, itemIcon: "message", itemText: "Group", isSelectedInt: $selectedIndex){
//                    selectedIndex = 1
//                }
//                NavItemButton(buttonIndex: 2, itemIcon: "magnifyingglass", itemText: "Search", isSelectedInt: $selectedIndex){
//                    selectedIndex = 2
//                }
//            Spacer()
//                NavItemButton(buttonIndex: 3, itemIcon: "list.and.film", itemText: "My List", isSelectedInt: $selectedIndex){
//                    selectedIndex = 3
//                }
//            Spacer()
//                NavItemButton(buttonIndex: 4, itemIcon: "person", itemText: "Profile", isSelectedInt: $selectedIndex){
//                    selectedIndex = 4
//                }
//            Spacer()
//            }
//            .padding(.top)
//            .padding(.horizontal,10)
//            .background(Color.init("navBarBlack"))
//            .edgesIgnoringSafeArea(.all)
//            .frame(width:UIScreen.main.bounds.width,height: 65)
        
        
            
        
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
       
        Group {
            ZStack{
                Color.black.ignoresSafeArea(.all)
                NavBar(index: 0)
            }
        }
        
     
    }
}

struct NavItemButton:View{
    var unselectColor:Color = Color.gray
    var selectColor:Color = Color.blue
    @Binding var index:Int
    @Binding var GroupSelect:Bool
    var body:some View{
        
        HStack{
            
            
            //home
            Button(action:{
                self.index = 0
                
            }){
                VStack(alignment:.center,spacing:10){
                    Image(systemName:"film")
                        .shadow(radius: 10)
                    Text("Home")
                        .frame(width: 50)
                        .font(.caption)
                }
                
            }
            .foregroundColor(self.index == 0 ? selectColor : unselectColor)
            
            Spacer(minLength: 0)
            
            //list
            Button(action:{
                self.index = 1
                controller.GetAllArticle()
 
            }){
                VStack(alignment:.center,spacing:10){
                    Image(systemName:"list.and.film")
                        .shadow(radius: 10)
                    Text("My List")
                        .frame(width: 50)
                        .font(.caption)
                }
            }
            .foregroundColor(self.index == 1 ? selectColor : unselectColor)
            .simultaneousGesture(TapGesture().onEnded{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.GroupSelect = true
                })
            })
            
            Spacer(minLength: 0)
            
            //search
            Button(action:{
                self.index = 2
            }){
                VStack(alignment:.center,spacing:10){
                    Image(systemName:"magnifyingglass")
                        .shadow(radius: 10)
                    Text("Search")
                        .frame(width: 50)
                        .font(.caption)
                }
            }
            .foregroundColor(self.index == 2 ? selectColor : unselectColor)
            
            Spacer(minLength: 0)
            
//            Button(action:{
//                self.index = 3
//            }){
//                VStack(alignment:.center,spacing:10){
//                    Image(systemName:"message")
//                        .shadow(radius: 10)
//                    Text("Group")
//                        .frame(width: 50)
//                        .font(.caption)
//
//                }
//            }
//            .foregroundColor(self.index == 3 ? selectColor : unselectColor)
//
//            Spacer(minLength: 0)
            
            //profile
            Button(action:{
                self.index = 3
            }){
                VStack(alignment:.center,spacing:10){
                    Image(systemName:"person")
                        .shadow(radius: 10)
                    Text("Profile")
                        .frame(width: 50)
                        .font(.caption)
                }
            }
            .foregroundColor(self.index == 4 ? selectColor : unselectColor)
            
            
        }
        .padding(.horizontal,25)
        .padding(.top,10)
       
      
    }
    
    
//    var buttonIndex:Int
//    var unselectColor:Color = Color.gray
//    var selectColor:Color = Color.blue
//    var itemIcon:String
//    var itemText:String
//
//    @Binding var isSelectedInt:Int
//
//    var action:()->()
//    var body:some View{
//        Button(action:action){
//            GeometryReader{ proxy in
//                VStack(alignment:.center,spacing:10){
//                    Image(systemName: itemIcon)
//                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                      //  .resizable()
//                    Text(itemText)
//                        .frame(width: 50)
//                        .font(.caption)
//
//                }
//            }
//            .foregroundColor(isSelectedInt == buttonIndex ? selectColor : unselectColor)
//            .font(.system(size: 18))
//
//        }
//    }
    

}
