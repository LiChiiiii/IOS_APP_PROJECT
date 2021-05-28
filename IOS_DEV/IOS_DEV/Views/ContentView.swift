//
//  SwiftUIView.swift
//  new
//
//  Created by 張馨予 on 2021/1/28.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    var body: some View {
        VStack{
            Spacer()
            SocialLoginButton(text: "Sign in with Google", textColor: .white, button: .black,image: "google"){
                print("test")
            }
            
            SocialLoginButton(text: "Sign in with Facebook", textColor: .white, button: .black,image: "twitter"){
                print("test")
            }
            
            
            SignInWithAppleButton(
                onRequest: { request in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                },
                onCompletion: { result in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                }
            )
            .cornerRadius(25)
            .frame(height:50)
            .padding(.horizontal,50)
        }

    }
}
 
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack{
            Color.gray.edgesIgnoringSafeArea(.all)
            ContentView()
        }
            
    }
}

