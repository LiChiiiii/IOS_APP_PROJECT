//
//  NavBar.swift
//  IOS_DEV
//
//  Created by Jackson on 17/4/2021.
//

import SwiftUI
let controller = ListController()
//Working Process
//struct NavBar: View {
////    @Binding var selectedIndex:Int
//    @State var index : Int
//    @State var GroupSelect : Bool = false
//    @ObservedObject private var userController = UserController()
//    var body: some View {
//
//        VStack{
//
//            ZStack{
//                if self.index == 0 {
//                    HomePage()
//
//                }
//                if self.index == 1 && GroupSelect == true{
//                    ListView(lists: controller.listData)
//
//                }
//                if self.index == 2 {
//                    AutoScroll_V().preferredColorScheme(.dark)
//
//                }
//                if self.index == 3 {
//                    ProfileView(NowUser: userController.NowUser)
//                }
//
//
//            }
//            NavItemButton(index: self.$index ,GroupSelect: self.$GroupSelect)
//        }.onAppear{
//            self.userController.GetNowUser(UserName: NowUserName)
//        }
//
//
//    }
//}

//Working Process
struct NavBar: View {
    @StateObject var previewModle = PreviewModle()
    
    @StateObject var StateManager  = SeachingViewStateManager()
    @StateObject var DragAndDropPreview = DragAndDropViewModel()
    
    @State var index : Int
    @State private var GroupSelect : Bool = false
    @State private var isPriview = false
    @ObservedObject private var userController = UserController()
    var body: some View {
        ZStack(alignment:.top){
            VStack(spacing:0){
                ZStack(alignment:.top){
                        HomePage()
                            .opacity(self.index == 0 ? 1 : 0)
                    
                        ListView(lists: controller.listData)
                            .opacity((self.index == 1 && GroupSelect == true) ? 1 : 0)

                        AutoScroll_V()
                            .opacity(self.index == 2 ? 1 : 0)
                    
//                        ProfileView(NowUser: userController.NowUser)
//                            .opacity(self.index == 3 ? 1 : 0)
//
                }
                NavItemButton(index: self.$index ,GroupSelect: self.$GroupSelect)
            }
            .onAppear{
                self.userController.GetNowUser(UserName: NowUserName)
            }
              
            .edgesIgnoringSafeArea(.all)
            //thse all padding is to adding back the padding of ignoresSafeArea()
            //ignoresSafeArea() just for keyboard
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.leading,UIApplication.shared.windows.first?.safeAreaInsets.left)
            .padding(.trailing,UIApplication.shared.windows.first?.safeAreaInsets.right)
            
            BottomSheet()
                .animation(.spring())
            
        }
        .environmentObject(previewModle)
        .environmentObject(StateManager) //here due to bottomSheet need to use to update some state
        .environmentObject(DragAndDropPreview) //here due to bottomSheet need to use to update some state
        .ignoresSafeArea()

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
    var selectColor:Color = Color.white
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
                controller.GetAllList()
 
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
            .foregroundColor(self.index == 3 ? selectColor : unselectColor)
            
            
        }
        .padding(.horizontal,25)
        .padding(.top,10)
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color("DarkMode2"))
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
