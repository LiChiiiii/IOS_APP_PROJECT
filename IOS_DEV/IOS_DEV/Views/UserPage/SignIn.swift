//
//  Login.swift
//  Ｐｒｏｊｅｃｔ
//
//  Created by 張馨予 on 2021/1/28.
//

import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices
import CryptoKit
var NowUserName:String = "" // user who login
var NowUserID:UUID? // user who login
var NowUserPhoto:Image? // user who login


struct SignIn: View {
    @State private var failed = false
    @State private var check:Bool = false
    
    @State private var email:String = ""
    @State private var username:String = ""
    @State private var password:String = ""
   
    
    @Binding var isSignIn:Bool
    //  @Namespace var names
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button(action:{
                    withAnimation(){
                        isSignIn.toggle()
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
            
            SignInCell(email: $email, username: $username, password: $password)
            Spacer()
        }
        .padding(.top,20)
        .padding(.vertical)
        
        
    }
}
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(isSignIn: .constant(false))
    }
}

struct SignInCell : View{
    
    @Binding var email:String
    @Binding var username:String
    @Binding var password:String
    @State var isPresented = false
    @State var ErrorAlert = false
    @State private var remember = false
    @AppStorage("userName") private var userName : String = ""
    @AppStorage("userPassword") private var userPassword : String = ""
    @AppStorage("rememberUser") private var rememberUser : Bool = false
//    @AppStorage("rememberMe") private var rememberMe : = ""
    @ObservedObject private var networkingService = NetworkingService()
    
    func Login(){
        let login = UserLogin(UserName: self.username, Password: self.password)
        
        //If token is not nil check then token first else login with request
        networkingService.requestLogin(endpoint: "/users/login", loginObject: login) { (result) in
            print(result)
            
            switch result {
                
            case .success(let user):
                print("login success")
                self.isPresented.toggle()
                ErrorAlert = false
                NowUserName = user.UserName
                NowUserID = user.id
                UserDefaults.standard.set(self.remember ? username : "", forKey: "userName")
                UserDefaults.standard.set(self.remember ? password : "", forKey: "userPassword")
                
            case .failure:
                print("login failed")
                ErrorAlert = true
            }
        }
    }

    var body: some View{
        Group{
            Text("Sign In")
                .bold()
                .foregroundColor(.orange)
                .TekoBoldFontFont(size: 45)
            
            VStack(){
                VStack {
                    HStack{
                        Text("Username :")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    
                    TextFieldWithLineBorder(text: $username,placeholder: "Enter Your Username")
                        .keyboardType(.emailAddress)
                }
                .padding(.horizontal)
                
                VStack {
                    HStack{
                        Text("Password :")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    
                    SeruceFieldWithLineBorder(text: $password, placeholder: "Enter Your Password")
                    
                }
                .padding(.horizontal)
                
                HStack {
                    Group{
                        Image(systemName: self.remember ? "checkmark.square.fill" : "square.fill")
                            .font(.body)
                            .foregroundColor(.white)
                            .onTapGesture(){
                                withAnimation(){
                                    self.remember.toggle()
                                    UserDefaults.standard.set( self.remember, forKey: "rememberUser")
                                }
                            }
                        Text("Remember me")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action:{
                        //TODO
                        //GO TO FROGET PASSWORD
                        
                    }){
                        Text("Forget Password?")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                    
                }
                .padding(.horizontal)
                
            }
            .padding()
            
            Spacer()
            
            VStack{
                smallButton(text: "Sign In", textColor: .black, button: .white, image: ""){
                    self.Login()
                }.padding(.horizontal,50)
                .fullScreenCover(isPresented: $isPresented, content: {
                    NavBar(index: 0)
                })
                .alert(isPresented: $ErrorAlert, content: {
                    Alert(title: Text("帳號密碼錯誤"),
                          dismissButton: .cancel())

                })
            }
            
            HStack{
                VStack{
                    Divider()
                        .padding(.horizontal)
                        .background(Color.secondary)
                }

                Text("OR")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                VStack{
                    Divider()
                        .padding(.horizontal)
                        .background(Color.secondary)
                }
            }
            .padding(.vertical,5)
            .frame(width: UIScreen.main.bounds.width)


            
            
            SocialLogo()

        }
        .onAppear(){
            self.remember = rememberUser
            self.username = userName
            self.password = userPassword
        }
    }
}



struct Logo: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "circle.fill")
                    .font(.caption2)
                Image(systemName: "circle.fill")
                    .font(.caption2)
            }
            Image(systemName: "mustache")
        }
        .font(.system(size:150))
        .padding(.bottom)
        .padding(.top)
        .foregroundColor(.blue)
    }
}

struct SocialLogo: View {
    
    @State private var currentNonce: String?
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    
    //random string for apple request
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    //shash a string
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    var body: some View {
        HStack {
            VStack{
                SocialLoginButton(text: "Sign in with Google", textColor: .black, button: .white,image: "google"){
                    GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                    
                    GIDSignIn.sharedInstance()?.signIn()
                }
                
                
                //SignIn with google
                SignInWithAppleButton(
                    onRequest: { request in
                        let Nonce = randomNonceString()
                        currentNonce = Nonce
                        
                        //what i want to get
                        request.requestedScopes = [.fullName,.email]
                        //request full Name and  Email
                        
                        request.nonce = sha256(Nonce)
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            switch authResults.credential {
                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                
                                guard let nonce = currentNonce else {
                                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                }
                                guard let appleIDToken = appleIDCredential.identityToken else {
                                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                }
                                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                    return
                                }
                                
                                //Creating a request for firebase
                                let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                                
                                ///Step
                                //Same as goole ,need a credential first, getting form apple request
                                //after request back ,if request include nonce id token apple token send the request to firebase and get the credential from firebase
                                //after auth that credintial
                                //Sending Request to Firebase
                                Auth.auth().signIn(with: credential) { (authResult, error) in
                                    if (error != nil) {
                                        // Error. If error.code == .MissingOrInvalidNonce, make sure
                                        // you're sending the SHA256-hashed nonce as a hex string with
                                        // your request to Apple.
                                        print(error?.localizedDescription as Any)
                                        return
                                    }
                                    // User is signed in to Firebase with Apple.
                                    print("you're in")
                                }
                                
                                //Prints the current userID for firebase
                                print("\(String(describing: Auth.auth().currentUser?.uid))")
                                
                            default:
                                break
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                )
                .signInWithAppleButtonStyle(.white)
                .cornerRadius(25)
                .frame(height:50)
                .padding(.horizontal,50)

            }

//
//            Spacer()
//            CircleButton(IconName: "applelogo") {
//                // TODO:
//                // SIGN IN WITH APPLE ID
//
//
//            }
//            Spacer()
//
//            CircleButton(IconName: "GoogleIcon",isSystemName: false) {
//                // TODO:
//                // SIGN IN WITH APPLE ID
//                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
//
//                GIDSignIn.sharedInstance()?.signIn()
//            }
//
//            Spacer()
//
//            CircleButton(IconName: "facebook",isSystemName: false) {
//                // TODO:
//                // SIGN IN WITH APPLE ID
//
//                //NOT WORKING YET
////                let manger = LoginManager()
////                manger.logIn(permissions: ["public_profile","emiil"]){ result  in
////
////                    if case LoginResult.success(granted: _, declined: _, token: _) = result{
////                        print("OK")
////                    }
////                    else{
////                        print("fail")
////                    }
////
////                }
//            }
//
//
//            Spacer()
//
//            CircleButton(IconName: "twitter",isSystemName: false) {
//                // TODO:
//                // SIGN IN WITH APPLE ID
//            }
//
//            Spacer()
            
        }
        
    }
}


