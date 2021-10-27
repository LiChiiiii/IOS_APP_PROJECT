//
//  ProfileView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/6.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI


enum SideOfState: String, CaseIterable {
    case movie = "電影"
    case article = "文章"
}//Picker Content

//struct GetProfileView: View {
//    @ObservedObject private var listController = ListController()
//    @ObservedObject private var forumController = ForumController()
//    @State var isLoading : Bool = true
//
//    var body:some View{
//
//        VStack{
//
//            if self.isLoading == false {
//                ProfileView(myListData: listController.mylistData, myArticleData: forumController.articleData)
//            }
//        }
//        .onAppear{
//            self.listController.GetMyList(userID: NowUserID!)
//            self.forumController.GetMyArticle(userID: NowUserID!)
//            DispatchQueue.main.asyncAfter(deadline:.now() + 3){
//                self.isLoading = false
//            }
//        }
//    }
//
//
//}


struct ProfileView: View {
    
//    init(){
//        UISegmentedControl.appearance().selectedSegmentTintColor = .systemYellow
//    }
    
    @State private var userID = "Justin Bieber" //UserID
    @State private var likedMovie = 30
//    @State private var PhotoStr:String = "http://127.0.0.1:8080/UserPhoto/4c163c0d-79f0-45ea-94c9-556e49853a6f"
    @State private var notification = true
    @State private var select: SideOfState = .movie
    @ObservedObject private var userController = UserController()
    @State private var appearPhoto = false
    
    @State var isLoading : Bool = true
    
    var body: some View{
        NavigationView{
  
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    
                    
                    VStack{
                                             
                            NowUserPhoto?
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                           
                            
                            Text(NowUserName)
                                .bold()

                    }.onAppear(){
                        self.userController.GetUserPhoto()
                    }
                  
               
                  
                  
                    HStack{
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 12))
                            .frame(width: 8)
                        Text("\(likedMovie) movies")
                            .font(.system(size: 12))
                    }
                    
                    Group{
                        NavigationLink(
                            destination: AccountSettingView(userID: $userID),
                            label: {
                                Text("帳號設定")
                                    .bold()
                                    .frame(width: 350, height: 45, alignment: .center)
                                    .background(Color("CustomRed"))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            })
                            .padding(5)
                        NavigationLink(
                            destination: MovieSettingView(userID: $userID, likedMovie: $likedMovie),
                            label: {
                                Text("電影喜好設定")
                                    .bold()
                                    .frame(width: 350, height: 45, alignment: .center)
                                    .background(Color("CustomRed"))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            })
                            .padding(5)
                        NavigationLink(
                            destination: MyListView(),
                            label: {
                                Text("我的片單")
                                    .bold()
                                    .frame(width: 350, height: 45, alignment: .center)
                                    .background(Color("CustomRed"))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            })
                            .padding(5)
                        NavigationLink(
                            destination: MyArticleView(),
                            label: {
                                Text("我發表過的文章")
                                    .bold()
                                    .frame(width: 350, height: 45, alignment: .center)
                                    .background(Color("CustomRed"))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            })
                            .padding(5)
                        
        //                ZStack{
        //                    Text("Notification")
        //                        .bold()
        //                        .frame(width: 350, height: 45, alignment: .center)
        //                        .background(Color.red)
        //                        .foregroundColor(.white)
        //                        .cornerRadius(15)
        //                    Toggle(" ", isOn: $notification)
        //                        .toggleStyle(SwitchToggleStyle(tint: .clear))
        //                        .frame(width: 330, height: 45, alignment: .center)
        //                }
        //                .padding(5)
                    }
                   
                    Text("喜愛項目")
                        .bold()
                    Picker("123", selection: $select){
                        ForEach(SideOfState.allCases, id:\.self){
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(5)
                    .frame(width: 360)
                    switch select{
                    case .movie:
                        movieRecord()
                    case .article:
                        articleRecord()
                    }
                    Spacer()
                }
               
            }
        
            
                
            
            
           
        }
        .accentColor(.red)
     

    }
    
}

struct AccountSettingView: View {
    
    let FullSize = UIScreen.main.bounds.size
    @Binding var userID:String
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    @State var show = false
    @State var showImagePicker: Bool = false
    @State var selectedImage: Image? = NowUserPhoto
    @ObservedObject private var userController = UserController()

    
    var body: some View{
        
        ZStack{
            VStack{
                self.selectedImage?
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    
                
                VStack(spacing:10){
                    Button(action:{
                        self.showImagePicker.toggle()
                    }, label:{
                        Text("選擇大頭照")
                    })
                    
    //                Button(action:{
    //                    let uiImage: UIImage = self.selectedImage.asUIImage()
    //                    userController.PostUserPhoto(uiImage:uiImage)
    //                    NowUserPhoto = selectedImage
    //
    //                }, label:{
    //                    Text("確定更換大頭照")
    //                })
                    
                    
                }
                .sheet(isPresented: $showImagePicker, content: {
                    ImagePicker(image: self.$selectedImage)
                })
                
                Spacer(minLength: 0)
                
                Form{
                    Section(header: Text("Name")){
                        TextField("\(NowUserName)", text: $name)
                    }
                    Section(header: Text("Email")){
                        TextField("Enter Email", text: $email)
                    }
                    Section(header: Text("Password")){
                        SecureField("Enter Password", text: $password)
                        SecureField("Confirm Password", text: $confirm)
                    }
                }
            }
            
            if self.show == true{
               
                Loader()
                    .frame(width:FullSize.width , height: FullSize.height/1.4, alignment: .center)
                    .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
            
                
                
            }
        
        }
        .navigationTitle("Account Setting")
        .toolbar{
            Button("Save"){
                if NowUserPhoto != selectedImage {
                    self.show = true
                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.1){
                        let uiImage: UIImage = self.selectedImage.asUIImage()
                        userController.PostUserPhoto(uiImage:uiImage)
                        NowUserPhoto = selectedImage
                    }
                    DispatchQueue.main.asyncAfter(deadline:.now() + 2){
                        self.show = false
                    }
                }
                
            }
           
        }
        
    }
}

struct MovieSettingView: View {
    
    @Binding var userID: String
    @Binding var likedMovie: Int
    let genreData = DataLoader().genreData
    var columns = Array(repeating: GridItem(.flexible(),spacing:15), count: 3)
    var body: some View{
        
        Spacer()
        
        ScrollView(.vertical, showsIndicators: false){
            

            Text("選擇您喜愛的類別")
                .font(.body)
                .padding(15)
            
            LazyVGrid(columns: columns, spacing: 15){

                ForEach(genreData, id:\.id){ genre in
                    genrebutton(genreText: genre.name)
                }

            }

            
        }
        .navigationTitle("電影喜好設定")
        .toolbar{
            Button("Save"){}
        }
    }
}

//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSettingView(userID: NowUserID)
//
//    }
//}



struct genrebutton: View {
    
    var genreText: String
    @State private var choose : Bool = false
    
    var body: some View{
        
        Button(action: {
            print("press!")
            self.choose.toggle()
            
        }) {
            HStack {
                Text(genreText)
                    .fontWeight(.semibold)
                    .font(.system(size:15))
            }
            .padding()
            .foregroundColor(self.choose == true ? Color.white : Color.black)
            .background(self.choose == true ? Color("CustomRed") : Color.gray)
            .cornerRadius(40)
        }
    }
}


struct movieRecord: View {
    
    let movies : [Movie] = stubbedMovie
    var columns = Array(repeating: GridItem(.flexible(),spacing:20), count: 2)
      
    var body: some View{
        
        LazyVGrid(columns: columns, spacing: 20){
            
            ForEach(movies, id:\.id){ movie in
                WebImage(url: movie.posterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            }
        }
    }
}


struct articleRecord: View {
    
    let articles : [Article] = stubbedArticles
    var columns = Array(repeating: GridItem(.flexible(),spacing:5), count: 2)
      
    var body: some View{
        
        LazyVGrid(columns: columns, spacing: 10){
            
            ForEach(articles, id:\.Title){ article in
                
                VStack(alignment:.leading){
                    HStack(){
                        
                        if article.user!.UserName == "Abc" {
                            Image("p3")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(30)
                                .padding(.leading,5)
                        }
                        else if article.user!.UserName == "Chichi" {
                            Image("pic")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(30)
                                .padding(.leading,5)
                        }
                        else if article.user!.UserName == "Angelababy" {
                            Image("p1")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(30)
                                .padding(.leading,5)
                        }
                        else{
                            Image("p2")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(30)
                                .padding(.leading,5)
                        }
                        
//                        Image("ka")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .cornerRadius(30)
//                            .padding(.leading,5)
                        
                        
                        Text(article.user!.UserName)
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }
                    .padding(.top,15)
                    
                    
                    Text(article.Title)
                        .bold()
                        .font(.system(size: 16))
                        .padding(5)
                    
                    Text(article.Text)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                        .padding(5)
                            
                    
                    Spacer()
                    
                    
                }
                .frame(width:170,height: 170)
                .background(BlurView().cornerRadius(25))
                .shadow(color: .gray, radius: 0.5)
                .foregroundColor(.white)
                .padding(10)
                .cornerRadius(20)

                
            }
        }
    }
}


