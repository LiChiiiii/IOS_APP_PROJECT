//
//  ArticleController.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/5.
//

import Foundation
class ListController: ObservableObject {

    let listService = ListService()
    @Published var listData:[List] = []
    @Published var listDetails:[ListDetail] = []
    

    func GetAllList(){
        listService.GET_allLists(endpoint: "/list"){ (result) in
            switch result {
            case .success(let lists):
                print("get all list")
                self.listData = lists

            case .failure: print("list failed")
            }
        }
    }
    
    func GetListDetail(listID : UUID){
        listService.GET_ListsDetails(endpoint: "/list/\(listID)"){ (result) in
            switch result {
            case .success(let lists):
                print("get list details")
                print(lists)
                self.listDetails = lists

            case .failure: print("list detail failed")
            }
        }
    }




}
