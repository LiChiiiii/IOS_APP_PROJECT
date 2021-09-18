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

struct ProfileView: View {
    
//    init(){
//        UISegmentedControl.appearance().selectedSegmentTintColor = .systemRed
//    }
    
    @State private var userID = "Justin Bieber" //UserID
    @State private var likedMovie = 30
    @State private var notification = true
    @State private var select: SideOfState = .movie
    @ObservedObject private var listController = ListController()
    @State var NowUser:Me?
    
    var body: some View{
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Image("ka")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    Text(NowUserName)
                        .bold()
                    HStack{
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 12))
                            .frame(width: 8)
                        Text("\(likedMovie) movies")
                            .font(.system(size: 12))
                    }
                    NavigationLink(
                        destination: AccountSettingView(userID: $userID),
                        label: {
                            Text("Account Setting")
                                .bold()
                                .frame(width: 350, height: 45, alignment: .center)
                                .background(Color("ButtonRed"))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        })
                        .padding(5)
                    NavigationLink(
                        destination: MovieSettingView(userID: $userID, likedMovie: $likedMovie),
                        label: {
                            Text("Movie Setting")
                                .bold()
                                .frame(width: 350, height: 45, alignment: .center)
                                .background(Color("ButtonRed"))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        })
                        .padding(5)
                    NavigationLink(
                        destination: MyListView(lists: listController.mylistData),
                        label: {
                            Text("My List")
                                .bold()
                                .frame(width: 350, height: 45, alignment: .center)
                                .background(Color("ButtonRed"))
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
                .navigationTitle("Profile")
            }
        }
        .accentColor(.red)
        .onAppear{
            self.listController.GetMyList(userID: NowUserID!)
        }
    }
    
}

struct AccountSettingView: View {
    
    @Binding var userID:String
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    @State private var bio = ""
    
    var body: some View{
        VStack{
            Image("ka")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Text(NowUserName)
                .bold()
            Form{
                Section(header: Text("Name")){
                    TextField("Enter Name", text: $name)
                }
                Section(header: Text("Email")){
                    TextField("Enter Email", text: $email)
                }
                Section(header: Text("Password")){
                    SecureField("Enter Password", text: $password)
                    SecureField("Confirm Password", text: $confirm)
                }
                Section(header: Text("Bio")){
                    TextEditor(text: $bio)
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationTitle("Account Setting")
            .toolbar{
                Button("Save"){}
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
            

            Text("Preferred genre")
                .font(.body)
                .padding(15)
            
            LazyVGrid(columns: columns, spacing: 15){

                ForEach(genreData, id:\.id){ genre in
                    genrebutton(genreText: genre.name)
                }

            }

            
        }
        .navigationTitle("Movie Setting")
        .toolbar{
            Button("Save"){}
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            
    }
}



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
                        Image("ka")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(30)
                            .padding(.leading,5)
                        Text("username")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }
                    .padding(.top,15)
                    
                    
                    Text(article.Title)
                        .bold()
                        .font(.system(size: 20))
                        .padding(5)
                    
                    Text(article.Text)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
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
