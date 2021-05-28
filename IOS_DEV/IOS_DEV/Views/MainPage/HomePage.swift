//
//  HomePage.swift
//  IOS_DEV
//
//  Created by Jackson on 29/3/2021.
//

import SwiftUI
import Foundation
import AVKit

struct HomePage: View {
    @State private var topbar = 0
    @State private var data = VideoList
    @State private var reload = false
    @State private var value:Float = 0.0
    var body: some View {
        
        ZStack{
            VStack(spacing:0){
                GeometryReader{ proxy in
                    ZStack{
                        PlayerView(videoList: $data, reload: $reload, value: $value, pageHeigh: proxy.size.height)
                        
                       TopBar(topbar: $topbar)
                    }
                }
                NavBar()
            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}


struct PlayerView:View{
    @Binding var videoList:[Traier]
    @Binding var reload:Bool
    @Binding var value:Float
    var pageHeigh:CGFloat
    
    var body:some View{
        ZStack{
            PlayerScrollView(trainer: $videoList, reload: $reload, value:$value ,pageHegiht: pageHeigh){
                LazyVStack(spacing:0){
                    ForEach(0..<videoList.count){ i in
                        
                        ZStack{
                            Player(VideoPlayer: videoList[i].videoPlayer)
                                .frame(height:pageHeigh)
                                .offset(y:-24)
                                .onTapGesture {
                                    /*
                                     Load The Detail Page with that movie
                                     MovieID = xx
                                     */
                                    //show movie detail
                                    
                                }
                            
                            MovieIntrol(trainer: videoList[i])
                            
                            VStack{
                                Spacer()
                                VideoProgressBar(value: $value, player: $videoList[i].videoPlayer)
                                    .offset(y:-24)
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
            .onAppear(perform: {
                videoList[0].videoPlayer.play()
                videoList[0].videoPlayer.actionAtItemEnd = .none
                
                //Add this view to NotificationCentre and tell all of those evnet
                //Chage Replay to true
                
                //get the time period of the play back control
                videoList[0].videoPlayer.addPeriodicTimeObserver(forInterval: .init(seconds: 1.0, preferredTimescale: 1), queue: .main){ _ in
                    self.value =
                        (Float(videoList[0].videoPlayer.currentTime().seconds / videoList[0].videoPlayer.currentItem!.duration.seconds))
                    
                }
                
                NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object: videoList[0].videoPlayer.currentItem, queue: .main){ _ in
                    videoList[0].videoReplay = true
                    videoList[0].videoPlayer.seek(to: .zero)
                    videoList[0].videoPlayer.play()
                    //                print(trainerList[0].videoPlayer.currentTime().seconds)
                }
            })
        }
        
        
    }
}


//
////FOR ALL DATA IN TRAINER LIST
//struct PlayerView:View{
//    @Binding var trainerList:[Traier]
//    @State private var time:Double = 0.0
//    @State private var like:Bool = false //just test ,not working like that
//    @Binding var value:Float
//    var body:some View{
//
//        GeometryReader{ proxy in
//            LazyVStack(spacing:0){
//                ForEach(0..<trainerList.count){ i in
//                    Player(VideoPlayer: trainerList[i].videoPlayer, value: 0.0)
//                        .frame(height:proxy.size.height-70)
//                }
//
//        }
//            .edgesIgnoringSafeArea(.all)
//
//                  //  ZStack{
//                  //      Group{
////                            Player(VideoPlayer: trainerList[i].videoPlayer)
////                                //for each trainer ->need a full screen
////                                .frame(width:UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height))
////                                .offset(y:-7)
////                                .zIndex(0.0)
////                                .onTapGesture {
////                                    /*
////                                      Load The Detail Page with that movie
////                                      MovieID = xx
////                                     */
////                                    print(i)
////
////                                    //test here
////                                    time = trainerList[i].videoPlayer.currentTime().seconds
////                                    print(time)
////                                }
//
////
////
////                            MovieIntrol(trainer: trainerList[i])
////                            VStack{
////                                Spacer()
////                                VideoProgressBar(value:self.$value, player: $trainerList[i].videoPlayer)
////                            }
//                    //    }
//
//                  //  }
//                }
//
//
//        .onAppear(perform: {
//            trainerList[0].videoPlayer.play()
//            trainerList[0].videoPlayer.actionAtItemEnd = .none
//
//            //Add this view to NotificationCentre and tell all of those evnet
//            //Chage Replay to true
//
//            //get the time period of the play back control
//            trainerList[0].videoPlayer.addPeriodicTimeObserver(forInterval: .init(seconds: 1.0, preferredTimescale: 1), queue: .main){ _ in
//                self.value =
//                    Float(trainerList[0].videoPlayer.currentTime().seconds / trainerList[0].videoPlayer.currentItem!.duration.seconds)
//
//            }
//
//            NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object: trainerList[0].videoPlayer.currentItem, queue: .main){ _ in
//                trainerList[0].videoReplay = true
//                trainerList[0].videoPlayer.seek(to: .zero)
//                trainerList[0].videoPlayer.play()
////                print(trainerList[0].videoPlayer.currentTime().seconds)
//            }
//
//
//        })
//    }
//}

//TOPBAR AT THE TOP OF HOMEPAGE
struct TopBar: View {
    @Binding var topbar:Int
    
    var body: some View {
        VStack{
            HStack(spacing:15){
                Button(action:{
                    //TODO:Show Trainer view
                    //change to selected : 0
                    self.topbar = 0
                }){
                    Text("Following")
                        .font(.system(size: 16))
                        .foregroundColor(self.topbar == 0 ? .white : Color.white.opacity(0.75))
                        .fontWeight(self.topbar == 0 ? .bold : .none)
                        .padding(.vertical)
                    
                }
                
                Button(action:{
                    //TODO:Show Movie Card View
                    //change to selected : 1
                    self.topbar = 1
                }){
                    Text("For You")
                        .font(.system(size: 16))
                        .foregroundColor(self.topbar == 1 ? .white : Color.white.opacity(0.75))
                        .fontWeight(self.topbar == 1 ? .bold : .none)
                        .padding(.vertical)
                }
            }
            Spacer()
        }
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(.bottom,(UIApplication.shared.windows.first?.safeAreaInsets.bottom)!+24)
    }
}

struct MovieIntrol: View {
    var trainer:Traier
    @State private var like = false
    
    var body: some View {
        VStack{
            Spacer()
            HStack(alignment:.bottom){
                VStack(alignment:.leading,spacing:10){
                    HStack{
                        
                        
                        Text(trainer.movieName)
                            .bold()
                            .font(.largeTitle)
                        
                    }
                    
                    Text("Release Date:12/04/2020")
                    
                    Text("Movie Type:")
                    
                }
                .font(.body)
                Spacer()
                
                VStack(spacing:20){
                    
                    Button(action:{
                        //LIKE THE VIDEO
                        self.like.toggle()
                        //if like add to my list
                    }){
                        Image(systemName: self.like ? "heart.fill": "heart")
                            .font(.system(size:30.0))
                        
                    }
                    Button(action:{
                        //Share THE VIDEO
                    }){
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 30.0))
                    }
                    
                    
                }
                
            }
            .padding(.horizontal,20)
            
            
        }
        .foregroundColor(.white)
        .padding(.vertical,40)
    }
}
