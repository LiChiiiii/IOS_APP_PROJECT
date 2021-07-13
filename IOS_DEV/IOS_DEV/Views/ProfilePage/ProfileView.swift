//
//  ProfileView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/6.
//

import Foundation

import SwiftUI

enum SideOfState: String, CaseIterable {
    case movie = "電影"
    case article = "文章"
}//Picker Content

struct ProfileView: View {
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemYellow
    }
    @State private var userID = "Justin Bieber" //UserID
    @State private var likedMovie = 30
    @State private var notification = true
    @State private var select: SideOfState = .movie
    
    var body: some View{
        NavigationView{
            VStack{
                Image("Justin Bieber")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                Text(userID)
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
                            .background(Color.yellow)
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
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    })
                    .padding(5)
                ZStack{
                    Text("Notification")
                        .bold()
                        .frame(width: 350, height: 45, alignment: .center)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    Toggle(" ", isOn: $notification)
                        .toggleStyle(SwitchToggleStyle(tint: .clear))
                        .frame(width: 330, height: 45, alignment: .center)
                }
                .padding(5)
                Text("瀏覽紀錄")
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
                    Text("Movie Detail")//MovieView
                case .article:
                    Text("Article Detail")//ArticleView
                }
                Spacer()
            }
            .navigationTitle("Profile")
        }
        .accentColor(.yellow)
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
            Image("Justin Bieber")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Text(userID)
                .bold()
            Form{
//                Section(header: Text("Name")){
//                    TextField("Enter Name", text: $name)
//                }
//                Section(header: Text("Email")){
//                    TextField("Enter Email", text: $email)
//                }
//                Section(header: Text("Password")){
//                    SecureField("Enter Password", text: $password)
//                    SecureField("Confirm Password", text: $confirm)
//                }
//                Section(header: Text("Bio")){
//                    TextEditor(text: $bio)
//                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//                }
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
    var body: some View{
        VStack{
            Image("Justin Bieber")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Text(userID)
                .bold()
            HStack{
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .frame(width: 8)
                Text("\(likedMovie) movies")
                    .font(.system(size: 12))
            }
            
            Spacer()
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
