//
//  UserController.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/9/15.
//

import Foundation

var NowUserID:UUID?
// getuserID
class UserController: ObservableObject {
    
    let networkingService = NetworkingService() //get
    @Published var NowUser:Me?
    
   
    func GetNowUser(UserName:String){
        networkingService.Get_nowUser(endpoint: "/users/\(UserName)"){(result) in
            //print(result)
            switch result {
            case .success(let user):
                self.NowUser = user
                NowUserID = user.id
                
            case .failure: print("getuser failed")
            }
        }
    }
}

