//
//  RefreshableScrollView.swift
//  IOS_DEV
//
//  Created by Jackson on 14/9/2021.
//

import SwiftUI
import UIKit

struct DragRefreshableScrollView<Content:View> : UIViewRepresentable{
    
    @Binding var datas : [DragItemData]
    @Binding var isFetchingData : Bool
    var dataType : CharacterRule
    var content : Content
    var onRefresh : (UIRefreshControl)->()
    var beAbleToUpdate : Bool
    
    var refreshController = UIRefreshControl()
    init(dataType :CharacterRule,datas : Binding<[DragItemData]>,isFetchingData : Binding<Bool>,beAbleToUpdate : Bool,@ViewBuilder content: @escaping ()->Content,onRefresh: @escaping (UIRefreshControl)->()){
        self.content = content()
        self.onRefresh = onRefresh
        self._isFetchingData = isFetchingData
        self._datas = datas
        self.dataType = dataType
        self.beAbleToUpdate = beAbleToUpdate
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) ->  UIScrollView {
        let view = UIScrollView()
        
        setUp(view: view)
        
        if beAbleToUpdate{
            self.refreshController.attributedTitle = NSAttributedString(string: "Loading...")
            self.refreshController.tintColor = .white
            self.refreshController.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
            view.refreshControl = self.refreshController //need to add  after setting up
        }
    
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        //TO UPDATE CURRENT VIEW
        setUp(view: uiView)
        uiView.delegate = context.coordinator
    }
    
    private func setUp(view : UIScrollView){
        let host = UIHostingController(rootView: self.content.frame(maxHeight: .infinity, alignment: .top))
        host.view.translatesAutoresizingMaskIntoConstraints = false
        //our swiftui view add the constrans to uiview
        
        let constrains = [ //UIKit autolayout to swiftUI layout
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            host.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            host.view.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor,constant: 1),
        ]
        
        //here we need to remove the previous view before adding a new view, only for updating case
        view.subviews.last?.removeFromSuperview() //remove
        view.addSubview(host.view)
        view.showsVerticalScrollIndicator = false
        view.addConstraints(constrains)
        
//        view.addConstraints(constrains)
//        view.addSubview(host.view)
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        var parent : DragRefreshableScrollView
        init(parent : DragRefreshableScrollView){
            self.parent = parent
        }
        
        @objc func onRefresh(){
            parent.onRefresh(parent.refreshController)
        }
        
        func fakeDataFetch(type : CharacterRule) -> [DragItemData] {
            switch type {
            case .Genre:
                let genreTest : [DragItemData] = [
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[0], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[1], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[2], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[3], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[4], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[5], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[6], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[7], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[8], personData: nil),
                    DragItemData(itemType: .Genre, genreData: tempDragGenreData[9], personData: nil),
                ]
                return genreTest.shuffled()
                
            case .Actor:
                let actorTest: [DragItemData] = [
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[0]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[1]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[2]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[3]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[4]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[5]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[6]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[7]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[8]),
                    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[9]),
                ]
                
                return actorTest.shuffled()
               
            case .Director:
                let directorTest: [DragItemData] = [
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[0]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[1]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[2]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[3]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[4]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[5]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[6]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[7]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[8]),
                    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[9]),
                ]
                
                return directorTest.shuffled()
            
            }
        }
        

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            if offsetY > scrollView.contentSize.height - 300 - scrollView.frame.height{
              //  print("fetching more data")
                //just call once
                guard !self.parent.isFetchingData else {
//                    print("is already featched!")
                    return
                }
                
                self.parent.isFetchingData = true
//                print("a")
                if parent.beAbleToUpdate{
                    DispatchQueue.main.asyncAfter(deadline: .now()+2){ [self] in
                        //                    self.parent.datas.append(tes) // add 5 to list
                        withAnimation(){
                            self.parent.datas.append(contentsOf: self.fakeDataFetch(type: self.parent.dataType))
                            self.parent.isFetchingData = false
                        }
                    }
                    
                }
            }
        }
        
    }
}
