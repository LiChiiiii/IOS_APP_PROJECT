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
    
    var body: some View {
        ZStack(){
            //a image here
            Image("test")
                .resizable()
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.all)
                .offset(x:animateImagge ? 0 : -350)
                .animation(.easeInOut(duration: 20))
                .frame(width:screen.width)
                .zIndex(-1)
            
            VStack(spacing:20){
                
//                HStack(spacing:10) {
//                    Text("Welcome")
//                        .foregroundColor(.black)
//                        .bold()
//                        .font(.system(size:40))
//                        .offset(x: animateImagge ? 0: -350)
//                        .animation(.easeInOut(duration: 1.5))
//                    Spacer()
//                }
//                .frame(width:screen.width - 50)
//                .padding(.horizontal,5)
//                .padding(.top,100)
                
            
                
                Spacer()
                HStack(spacing:10) {
                    Text("Adam's apple")
                        .foregroundColor(Color.white)
                        .font(.system(size:50,weight: .regular, design: .serif))
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
                        SignIn(isSignIn: $isSignIn)
                    })
                    
                    LargeButton(text: "Sign Up", textColor: .black, button:Color.red.opacity(0.75)){
                        withAnimation(){
                            isSignUp.toggle()
                        }
                    }
                    .fullScreenCover(isPresented: $isSignUp, content: {
                        SignUp(isSignUp: $isSignUp)
                    })
                }
                .offset(y:animateImagge ? 0 : 400)
                .animation(.easeInOut(duration: 1.5))

            }
            
//            if isSignIn{
//                SignIn(isSignIn: $isSignIn)
//
////                    .transition(.move(edge: .bottom))
////                    .animation(.easeInOut)
//            }
//
//            if isSignUp{
//                signUp(isSignUp: $isSignUp)
//                    .transition(.move(edge: .bottom))
//                    .animation(.easeInOut)
//            }
        }
        .onAppear{
            animateImagge = true
        }
        
        
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
