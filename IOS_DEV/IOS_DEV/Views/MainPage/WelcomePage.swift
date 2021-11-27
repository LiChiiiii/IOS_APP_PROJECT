//
//  WelcomePage.swift
//  new
//
//  Created by Jackson on 23/2/2021.
//

import SwiftUI

struct WelcomePage: View {
    let screen = UIScreen.main.bounds
    
    @State private var isSignUp : Bool = false
    @State private var isSignIn : Bool = false
    @State private var animateImagge:Bool = false
    
    //Auto login is Token is not null
    @AppStorage("userToken") private var userToken : String = ""
    @State private var isLoggedIn : Bool = false
    @State private var isLoading : Bool = false
    @ObservedObject private var networkingService = NetworkingService.shared
    var body: some View {
        
        ZStack(){
            
            
            Group{
                Image("HomeBG")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                    .offset(x:animateImagge ? 0 : -100)
                    .animation(.easeInOut(duration: 20).repeatForever())
                    .frame(width:screen.width)
                    .zIndex(-1)
                    .overlay(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all).blur(radius: 10))
                
                VStack(spacing:20){
                    Spacer()
                    HStack(spacing:10) {
                        Text("Adam's apple")
                            .foregroundColor(Color.white)
                            .CourgetteRegularFont(size: 50)
                            .offset(x:animateImagge ? 0 : -350)
                            .animation(.easeInOut(duration: 1.5))
                    }
                    .frame(width:screen.width - 50)
                    .padding(.horizontal,5)
                    .padding(.bottom,50)
                    
                    Spacer()
                    //2button here
                    VStack{
                        LargeButton(text: "Sign In", textColor: .black, button: .white){
                            withAnimation(){
                                isSignIn.toggle()
                            }
                        }
                        .fullScreenCover(isPresented: $isSignIn, content: {
                            SignIn(isSignIn: $isSignIn, isLoggedIn: $isLoggedIn)
                        })
                        
                        LargeButton(text: "Sign Up", textColor: .black, button:Color.red.opacity(0.75)){
                            withAnimation(){
                                isSignUp.toggle()
                            }
                        }
                        .fullScreenCover(isPresented: $isSignUp, content: {
                            SignUp(isSignUp: $isSignUp, isSignIn: self.$isSignIn)
                        })
                    }
                    .offset(y:animateImagge ? 0 : 400)
                    .animation(.easeInOut(duration: 1.5))

                }
            }
            .zIndex(0)
            if isLoading {
                Color.black.edgesIgnoringSafeArea(.all)
                    .zIndex(1)
            }

        }
        .onAppear{
            //Check the token too
            self.isLoading = true
            if !userToken.isEmpty{
                networkingService.AuthUser(token: self.userToken){ result in
                    switch result{
                    case.success(let data):
                        self.isLoggedIn.toggle()
                        NowUserName = data.UserName
                        NowUserID = data.id
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                            self.isLoading.toggle()
                        }

                    case .failure(let err):
                        self.isLoading.toggle()
                        print(err)

                    }

                }
            }else{
                self.isLoading = false
            }
            animateImagge = true
        }
        .fullScreenCover(isPresented: self.$isLoggedIn, content: {
            NavBar(isLogOut: self.$isLoggedIn,index: 0)
        })
        
        
    }
    
    func checkToken(){
        
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
