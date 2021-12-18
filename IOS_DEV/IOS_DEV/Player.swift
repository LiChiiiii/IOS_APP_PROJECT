//
//  Player.swift
//  IOS_DEV
//
//  Created by Jackson on 8/4/2021.
//

import Foundation
import SwiftUI
import UIKit
import AVKit


//let AVPlayerController to SWiftUI

struct TrailerPlayer:UIViewControllerRepresentable{
    var player:AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let movieTrailerPlayer = AVPlayerViewController()
        movieTrailerPlayer.player = player
//        movieTrailerPlayer.player?.play()
        movieTrailerPlayer.showsPlaybackControls = false
        return movieTrailerPlayer
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        //to update view
        
    }
}




struct Player:UIViewControllerRepresentable{
    var VideoPlayer:AVPlayer
    var videoLayer : AVLayerVideoGravity = .resizeAspect
    func makeCoordinator() -> Coordinator {
        return Player.Coordinator(parent: self)
    }

    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerview = AVPlayerViewController()
        playerview.player = VideoPlayer
        playerview.showsPlaybackControls = false
        playerview.videoGravity = videoLayer
        playerview.delegate = context.coordinator
        return playerview
    }
    
    func updateUIViewController(_ controller: AVPlayerViewController, context content: Context) {
        if Appdelegate.orientationLock == .landscape{
            controller.modalPresentationStyle = .fullScreen
        }else{
            controller.modalPresentationStyle = .none
        }
    }
    
    
    class Coordinator:NSObject,AVPlayerViewControllerDelegate{
        var parent : Player
        init(parent : Player){
            self.parent = parent
        }


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
    @Binding var isUpdateView : Bool
    @Binding var currentVideIndex : Int
    @Binding var orientation : UIDeviceOrientation
    
    @State private var indexChange : Bool = false
    let pageHegiht:CGFloat
    let content:()->Content

    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
//
//        //UIHostingController is a UIKit Controller to control SWIFTUI Hierarchy
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
        view.contentOffset.y = CGFloat(currentVideIndex) * pageHegiht

        //Paging the page ,not Scroll
        view.isPagingEnabled  = true
        view.delegate = context.coordinator
        return view

    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if isUpdateView {
//            print("Upading the view")
            if Appdelegate.orientationLock == .landscape {
                print("Upading the landscape")
                Landscape(uiView,context) //Landscape Mode
            }else if Appdelegate.orientationLock == .portrait {
                print("Upading the Portrait")
                Portrait(uiView,context) // Portrait mode
            }


        }
    }

    private func Landscape(_ view: UIScrollView,_ context: Context){
        let rootView = UIHostingController(rootView: self.content())

        //Total Height of this view is the fullscreen * total trainer
        rootView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: pageHegiht * CGFloat(trailerList.count))
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1.0)
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height:  pageHegiht * CGFloat(trailerList.count))
        view.subviews.last?.removeFromSuperview()
        view.addSubview(rootView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = false
        view.alwaysBounceVertical = false
        view.bounces = false
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled  = true
        view.contentOffset.y =  CGFloat(currentVideIndex) * pageHegiht
        view.delegate = context.coordinator
        
        for i in 0..<view.subviews.count{
            view.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  pageHegiht  * CGFloat(trailerList.count))
        }
        viewUpdated()
    }
    
    private func Portrait(_ view : UIScrollView,_ context: Context){
        //Re-init the view!
        let rootView = UIHostingController(rootView: self.content())

        //Total Height of this view is the fullscreen * total trainer
        rootView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.pageHegiht * CGFloat(trailerList.count))

        //Total ScrollView Content size ,width: full window ,and height : trainer count * full screen
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height))
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height:  pageHegiht * CGFloat(trailerList.count))
        view.subviews.last?.removeFromSuperview()
        view.addSubview(rootView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        view.isScrollEnabled = true
        view.alwaysBounceVertical = true
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled  = true
        view.contentOffset.y =  CGFloat(currentVideIndex) * pageHegiht
        for i in 0..<view.subviews.count{
            view.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  pageHegiht  * CGFloat(trailerList.count))
        }
        view.delegate = context.coordinator
        viewUpdated()
    }
    
    private func viewUpdated(){
        DispatchQueue.main.async {
            self.isUpdateView = false
        }
    }

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

            let currentIndex = Int(scrollView.contentOffset.y / parentView.pageHegiht)
            self.parentView.currentVideIndex = currentIndex
            
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
                    self.parentView.value =  Float(self.parentView.trailerList[self.index].videoPlayer.currentTime().seconds  / (self.parentView.trailerList[self.index].videoPlayer.currentItem?.duration.seconds ?? 0))
  
                }
                
                
                NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object: parentView.trailerList[index].videoPlayer.currentItem, queue: .main){ (_) in
//                    self.parentView.trailerList[self.index].videoReplay = true
                    self.parentView.trailerList[self.index].videoPlayer.seek(to: .zero)
                    self.parentView.trailerList[self.index].videoPlayer.play()
//                    self.parentView.trailerList[self.index].maxValue = self.parentView.trailerList[self.index].videoPlayer.currentItem!.duration.seconds
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
    var player:AVPlayer
    var minTintColor : UIColor = .white
    var maxTintColor : UIColor = .clear
    var setThumbImage : Bool = false
    func makeUIView(context: Context) -> UISlider {
        let silder = UISlider()
        silder.minimumTrackTintColor = minTintColor
        silder.maximumTrackTintColor = maxTintColor
        silder.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        silder.tintColor = .white
        silder.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
//        silder.thumbTintColor = .white
        silder.value = value
//        silder.
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
