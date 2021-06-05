//
//  Player.swift
//  IOS_DEV
//
//  Created by Jackson on 8/4/2021.
//

import Foundation
import SwiftUI
import AVKit

//let AVPlayerController to SWiftUI

struct TrailerPlayer:UIViewControllerRepresentable{
    var player:AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let movieTrailerPlayer = AVPlayerViewController()
        movieTrailerPlayer.player = player
        movieTrailerPlayer.showsPlaybackControls = false
        return movieTrailerPlayer
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        //to update view
    }
}



struct Player:UIViewControllerRepresentable{
    var VideoPlayer:AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {

        let playerview = AVPlayerViewController()
        playerview.player = VideoPlayer
        playerview.showsPlaybackControls = false
        playerview.videoGravity = .resizeAspectFill
        return playerview
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        //What to do if view is updated
        //workcall ,coz nothing will be updated
    }
}

struct PlayerScrollView<Content:View>: UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(parent: self,didRefresh: self.$reload)
    }

    @Binding var trailerList:[Trailer]
    @Binding var reload:Bool
    @Binding var value:Float
    @Binding var isAnimation:Bool
    let pageHegiht:CGFloat
    let content:()->Content

    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()

        //UIHostingController is a UIKit Controller to control SWIFTUI Hierarchy
        //rootView is the root View for this controller
        let rootView = UIHostingController(rootView: self.content())

        //Total Height of this view is the fullscreen * total trainer
        rootView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.pageHegiht * CGFloat(trailerList.count))

        //Total ScrollView Content size ,width: full window ,and height : trainer count * full screen
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height))
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: pageHegiht * CGFloat(trailerList.count))

        view.addSubview(rootView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.bounces = false

        //ignore safe area
        view.contentInsetAdjustmentBehavior = .never


        //Paging the page ,not Scroll
        view.isPagingEnabled  = true
        view.delegate = context.coordinator
        return view

    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        //TODO
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height:  pageHegiht  * CGFloat(trailerList.count))
        

        for i in 0..<uiView.subviews.count{
            //let all subview have same frame size
            //in this case ,we only have 1 subview:rootView:PlayerView
            //when trainer data is updated
            uiView.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  pageHegiht  * CGFloat(trailerList.count))
        }
    }

    //this is used to communicated between UIKit View And SiwftUI View :UIScrollViewDelegate
    class Coordinator:NSObject,UIScrollViewDelegate{

        var parentView:PlayerScrollView
        var index = 0 //default index
        var loadMore :Binding<Bool>

        init(parent:PlayerScrollView,didRefresh:Binding<Bool>){
            parentView = parent
            loadMore = didRefresh
        }
        //is Scroll ened?
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            /*
              TODO LIST(might implement):
              1.WHEN SCROLLING TO THE TOP
             2.SET THR VALUE TO 0
             3.MOVING THE TOPBAR
             */
            
//
//            if scrollView.contentOffset.y <= 0{
//                print("i am now at the top")
//                loadMore.wrappedValue = true //assign the value to warppedValue
//            }
//            else{
//                loadMore.wrappedValue = false
//            }
//
//

          //  print(scrollView.contentOffset.y)
            //get index of each content

            let currentIndex = Int(scrollView.contentOffset.y / parentView.pageHegiht)

            if index != currentIndex{
                index = currentIndex

                for i in 0..<parentView.trailerList.count{
                    parentView.trailerList[i].videoPlayer.seek(to: .zero) //video time line to 0
                    parentView.trailerList[i].videoPlayer.pause() //pause the video
                    parentView.isAnimation = false
                }

                parentView.trailerList[index].videoPlayer.play() //play the video
                parentView.trailerList[index].videoPlayer.actionAtItemEnd = .none
                
                parentView.isAnimation = true
                
                
                //add Observer to player timeer
                parentView.trailerList[index].videoPlayer.addPeriodicTimeObserver(forInterval: .init(seconds: 1.0, preferredTimescale: 1), queue: .main){ _ in
                    self.parentView.value =  Float(self.parentView.trailerList[self.index].videoPlayer.currentTime().seconds / self.parentView.trailerList[self.index].videoPlayer.currentItem!.duration.seconds)
                    
                }

                NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object: parentView.trailerList[index].videoPlayer.currentItem, queue: .main){ (_) in
                    self.parentView.trailerList[self.index].videoReplay = true
                    self.parentView.trailerList[self.index].videoPlayer.seek(to: .zero)
                    self.parentView.trailerList[self.index].videoPlayer.play()

                }
            }

        }
    }
}

struct VideoProgressBar : UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return VideoProgressBar.Coordinator(parent: self)
    }
    
    @Binding var value:Float
    @Binding var player:AVPlayer
    
    func makeUIView(context: Context) -> UISlider {
        let silder = UISlider()
        silder.minimumTrackTintColor = .white
        silder.maximumTrackTintColor = .none
        silder.setThumbImage(UIImage(), for: .normal)
        silder.value = value
        silder.addTarget(context.coordinator, action: #selector(context.coordinator.videoTimeProgress(silder:)), for: .valueChanged)
        return silder
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
       // print(value)
        uiView.value = value
    }
    
    class Coordinator:NSObject{
        var parentView:VideoProgressBar
        
        init(parent:VideoProgressBar){
            parentView = parent
        }
        
        @objc func videoTimeProgress(silder:UISlider){
            if silder.isTracking{
                // when user moving slider bar
                //silder target will call that function
                
                //pause the video
                self.parentView.player.pause()
                
                //getting total video time * silder.value
                //max silder value is 1
                let trackingSec = Double(silder.value * Float(parentView.player.currentItem!.duration.seconds))
                
                //set current video time seek to silder value * total duration
                self.parentView.player.seek(to: .init(seconds: trackingSec, preferredTimescale: 1))
                
            }
            else{

                let trackingSec = Double(silder.value * Float(parentView.player.currentItem!.duration.seconds)) //is total second is 10 and tracking is 5s
                self.parentView.player.seek(to: .init(seconds: trackingSec, preferredTimescale: 1))
                self.parentView.player.play()
            }
        }
    }
}
