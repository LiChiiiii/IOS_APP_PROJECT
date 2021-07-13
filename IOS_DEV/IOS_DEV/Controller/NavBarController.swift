//
//  NavBarController.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/5.
//

import Foundation

class NavBarController: ObservableObject {
    
    let networkingService = NetworkingService()
    @Published var articleData:[Article] = []
        
    func GetAllArticle(){
        networkingService.request(endpoint: "/article"){(result) in
            //print(result)
            switch result {
            case .success(let article):
                print("article success")
                self.articleData = article
                

            case .failure: print("article failed")
            }
        }
    }
}

