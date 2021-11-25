//
//  signIn.swift
//
//  Ｐｒｏｊｅｃｔ
//
//  Created by 張馨予 on 2021/1/28.
//

import SwiftUI
let registerService = RegisterService()


struct SignUp: View {
    @State var ErrorResponse:String = ""
    @State var ErrorAlert = false
        
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var ConfirmPassword:String = ""
    @State private var UserName:String = ""

    @Binding var isSignUp:Bool
    @Binding var isSignIn : Bool
    //  @Namespace var names
    

    
    func Register(){
  
        let auth = UserRegister(UserName: self.UserName, Email: self.email, Password: self.password, confirmPassword: self.ConfirmPassword)
        
        registerService.requestRegister(endpoint: "/users/register", RegisterObject: auth) { (result) in
            print(result)
            
            switch result {
                
            case .success:
                print("register success")
                ErrorAlert = false
                self.isSignUp.toggle()
                
            case .failure(let error):
                print("register failed")
                ErrorAlert = true
                ErrorResponse = error.localizedDescription

            }
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Spacer()
                Button(action:{
                    withAnimation(){
                        isSignUp.toggle()
                    }
                }){
                    HStack {
                        Image(systemName: "arrow.backward")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.5))
                            .padding(.bottom,20)
                            .padding(.leading)
                        Spacer()
                        
                    }
                }
            }
            Spacer()

            
            HStack {
                Text("Sign Up")
                    .bold()
                    .foregroundColor(.orange)
                    .TekoBoldFontFont(size: 45)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.leading,10)

            UserRegForm(email: $email, password: $password, ConfirmPassword: $ConfirmPassword, UserName: $UserName)
            
            
            Spacer()
            

            smallButton(text: "Sign Up", textColor: .black, button: .white, image: ""){
                self.Register()
            }
            .padding(.horizontal,50)
            .alert(isPresented: $ErrorAlert, content: {
                Alert(title: Text(self.ErrorResponse),
                      dismissButton: .cancel())

            })

            
            Spacer()


            HStack{
                Text("Already have an account?")
                    .foregroundColor(.secondary)
                Button(action:{
                    //TODO:
                    //GO TO SIGN UP PAGE
                    withAnimation{
                        self.isSignIn.toggle()
                        self.isSignUp.toggle()
                    }
                }){
                    Text("Sign In")
                }
            }
            .font(.system(size: 14))
            .padding()
            
            Spacer()

        }
    }
    
}


//



struct SocialSignUp: View {
    var body: some View {
        HStack {
            Spacer()
            CircleButton(IconName: "applelogo") {
                // TODO:
                // SIGN IN WITH APPLE ID
            }
            Spacer()
            
            CircleButton(IconName: "GoogleIcon",isSystemName: false) {
                // TODO:
                // SIGN IN WITH APPLE ID
            }
            
            Spacer()
            
            CircleButton(IconName: "facebook",isSystemName: false) {
                // TODO:
                // SIGN IN WITH APPLE ID
            }
            
            Spacer()
            
            CircleButton(IconName: "twitter",isSystemName: false) {
                // TODO:
                // SIGN IN WITH APPLE ID
            }
            
            Spacer()
            
        }
    }
}

struct UserRegForm: View {
    @Binding var email:String
    @Binding var password:String
    @Binding var ConfirmPassword:String
    @Binding var UserName:String
    
    
    var body: some View {
        VStack(spacing:20){
            
            VStack {
                HStack{
                    Text("User Name :")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                }
                
                TextFieldWithLineBorder(text: $UserName,placeholder: "Enter Yout UserName")
            }
            .padding(.horizontal)
            
            VStack {
                HStack{
                    Text("Email :")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                }
                
                TextFieldWithLineBorder(text: $email,placeholder: "Enter Your Email")
                    .keyboardType(.emailAddress)
            }
            .padding(.horizontal)

            
            VStack {
                HStack{
                    Text("Password :")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                }
                
                SeruceFieldWithLineBorder(text: $ConfirmPassword, placeholder: "Enter Your Password")
                
            }
            .padding(.horizontal)
            
            
            VStack {
                HStack{
                    Text("Enter Password :")
                        .foregroundColor(.black)
                        .font(.headline)
                    Spacer()
                }
                
                SeruceFieldWithLineBorder(text: $password, placeholder: "Enter Your Password")
                
            }
            .padding(.horizontal)
            
            
        }
        .padding()
    }
}
