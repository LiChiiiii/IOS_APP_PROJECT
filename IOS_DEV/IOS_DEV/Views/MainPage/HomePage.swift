//
//  HomePage.swift
//  IOS_DEV
//
//  Created by Jackson on 29/3/2021.
//

import SwiftUI
import Foundation
import AVKit
import SDWebImageSwiftUI


struct StaticButtonStyle : ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct HomePage:View{
    @Binding var showHomePage : Bool
    @Binding var isLogOut : Bool
    
    var body:some View{
        MainHomeView(showHomePage: $showHomePage, isLogOut: self.$isLogOut)

    }
}



//struct MainHomeView:View{
//    @State private var topBarIndx = 0
//    @State private var trailerData = VideoList
//    @State private var isReload = false
//    @State private var value:Float = 0.0
//    @State private var isAnimation = false
//    @State private var isNavBarHidden = true
//    @State private var isActive = false
//    @State private var isLoading = true
//    @State private var NavIndex = 0
//
//    @Binding var showHomePage:Bool
//    @Binding var isLogOut : Bool
//
////    init(){
////        UINavigationBar.appearance().barTintColor = UIColor(Color.init("navBarBlack").opacity(0.85))
////        UINavigationBar.appearance().tintColor = .white
////    }
//    var body:some View{
//        ZStack{
//            VStack(spacing:0){
//                GeometryReader{geo in
//                    NavigationView{
//                        ZStack(alignment:.topTrailing){
//                            HomeTrailerPlayer(topBarIndx:$topBarIndx,trailerData:$trailerData,isReload:$isReload,value:$value,isAnimation:$isAnimation,isNavBarHidden:$isNavBarHidden,isActive:$isActive,isLoading:$isLoading, pageHeight: geo.frame(in:.global).height)
//
//                            NavigationLink(
//                                destination:  MovieListView(showHomePage: $showHomePage, isLogOut: self.$isLogOut),
//                                isActive: $showHomePage){
//                                        BackHomePageButton(){
//                                            //jump back to home page
//                                            self.showHomePage.toggle()
//                                        }
//                                        .padding(.horizontal,15)
//
//
//                        }
//                                .buttonStyle(StaticButtonStyle())
//                        .navigationViewStyle(DoubleColumnNavigationViewStyle())
//                        .navigationTitle("")
//                        .navigationBarTitle("")
//                        .navigationBarHidden(true)
//
//                        }
//                    }
//                }
//
//            }
//            .edgesIgnoringSafeArea(.all)
//        }
//    }
//}


struct MainHomeView:View{

    @Binding var showHomePage:Bool
    @Binding var isLogOut : Bool

//    init(){
//        UINavigationBar.appearance().barTintColor = UIColor(Color.init("navBarBlack").opacity(0.85))
//        UINavigationBar.appearance().tintColor = .white
//    }
    var body:some View{
        NavigationView{
            MovieListView(showHomePage: $showHomePage, isLogOut: self.$isLogOut)

        }
    }
}

struct MovieTrailerDiscoryView : View{
    @State private var trailerData = VideoList
    @State private var isReload = false
    @State private var value:Float = 0.0
    @State private var isAnimation = false
    @State private var isNavBarHidden = true
    @State private var isActive = false
    @State private var isLoading = true
    @State private var NavIndex = 0

    @Binding var showHomePage:Bool

    var body : some View{
        VStack{
            GeometryReader{geo in
                ZStack(alignment:.topLeading){
                    HomeTrailerPlayer(trailerData:$trailerData,isReload:$isReload,value:$value,isAnimation:$isAnimation,isNavBarHidden:$isNavBarHidden,isActive:$isActive,isLoading:$isLoading, pageHeight: geo.frame(in:.global).height)

                    BackHomePageButton(){
                        //jump back to home page
                        self.showHomePage.toggle()
                    }
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(.horizontal,15)
                }


            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeTrailerPlayer:View{
    @Binding var trailerData:[Trailer]
    @Binding var isReload:Bool
    @Binding var value:Float
    @Binding var isAnimation:Bool
    @Binding var isNavBarHidden:Bool
    @Binding var isActive:Bool
    @Binding var isLoading:Bool
    var pageHeight:CGFloat

    var body:some View{
        ZStack{
            PlayerScrollList(isAnimation: $isAnimation, isNavBarHidden: $isNavBarHidden, isActive: $isActive, value: $value, isLoading: $isLoading, trailerData: $trailerData, isReload: $isReload, pageHeight: pageHeight)

                .onAppear(perform: {
                    trailerData[0].videoPlayer.play()
                    trailerData[0].videoPlayer.actionAtItemEnd = .none
                    
                    //Add this view to NotificationCentre and tell all of those evnet
                    //Chage Replay to true
                    
                    //get the time period of the play back control
                    trailerData[0].videoPlayer.addPeriodicTimeObserver(forInterval: .init(seconds: 1.0, preferredTimescale: 1), queue: .main){ _ in
                        self.value =
                            (Float(trailerData[0].videoPlayer.currentTime().seconds / trailerData[0].videoPlayer.currentItem!.duration.seconds))
                        
                    }
                    
                    NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object: trailerData[0].videoPlayer.currentItem, queue: .main){ _ in
                        trailerData[0].videoReplay = true
                        trailerData[0].videoPlayer.seek(to: .zero)
                        trailerData[0].videoPlayer.play()
                        //                print(trainerList[0].videoPlayer.currentTime().seconds)
                    }
                })
//
        }
    }
}

struct PlayerScrollList: View {
    @Binding var isAnimation:Bool
    @Binding var isNavBarHidden:Bool
    @Binding var isActive:Bool
    @Binding var value:Float
    @Binding var isLoading:Bool
    @Binding var trailerData : [Trailer]
    @Binding var isReload : Bool
    
    @State private var isFullScreen : Bool = false
    @State private var currentVideo : Int = 0
    var pageHeight :CGFloat
    var body: some View {
        Group{
            PlayerScrollView(trailerList: $trailerData, reload: $isReload, value:$value, isAnimation: $isAnimation ,pageHegiht: pageHeight){
                LazyVStack(spacing:0){
                    ForEach(0..<trailerData.count){ i in
                        ZStack{
                            Player(VideoPlayer: trailerData[i].videoPlayer,videoLayer:.resizeAspect, isFullScreen: self.$isFullScreen)
                                .frame(height:pageHeight)
                                .onDisappear(){
                                    trailerData[i].videoPlayer.pause()
                                }
                            
                            
                            
                            MovieIntrol(trailer: trailerData[i], tailerIndex: i, selectedVideo: $currentVideo, isAnimation: $isAnimation, isActive: $isActive, navBarHidden: $isNavBarHidden,isLoading:$isLoading, isFullScreen: self.$isFullScreen)
                            VStack{
                                Spacer()
                                VideoProgressBar(value: $value, player: $trailerData[i].videoPlayer)
                            }
                            
                        }

                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .fullScreenCover(isPresented: $isFullScreen){
            Player(VideoPlayer: self.trailerData[currentVideo].videoPlayer, videoLayer: .resizeAspect, isFullScreen: self.$isFullScreen)
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {

                    
                    Appdelegate.orientationLock = UIInterfaceOrientationMask.all

                      UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")

                      UINavigationController.attemptRotationToDeviceOrientation()

                    })
                .onDisappear(perform: {

            

                          Appdelegate.orientationLock = UIInterfaceOrientationMask.portrait

                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")

                        UINavigationController.attemptRotationToDeviceOrientation()

                      

                    })
        }

        
    }
}


//struct TopBar: View {
//    @Binding var topbar:Int
//    var body: some View {
//        VStack{
//            HStack(spacing:15){
//                Button(action:{
//                    //TODO:Show Trainer view
//                    //change to selected : 0
//                    self.topbar = 0
//                }){
//                    Text("Following")
//                        .font(.system(size: 16))
//                        .foregroundColor(self.topbar == 0 ? .white : Color.white.opacity(0.75))
//                        .fontWeight(self.topbar == 0 ? .bold : .none)
//                        .padding(.vertical)
//
//                }
//
//                Button(action:{
//                    //TODO:Show Movie Card View
//                    //change to selected : 1
//                    self.topbar = 1
//                }){
//                    Text("For You")
//                        .font(.system(size: 16))
//                        .foregroundColor(self.topbar == 1 ? .white : Color.white.opacity(0.75))
//                        .fontWeight(self.topbar == 1 ? .bold : .none)
//                        .padding(.vertical)
//                }
//            }
//            Spacer()
//        }
//    //    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
//        .padding(.bottom,(UIApplication.shared.windows.first?.safeAreaInsets.bottom))
//    }
//}

struct MovieIntrol: View {
    var trailer:Trailer
    var tailerIndex : Int
    @Binding var selectedVideo : Int
    @State private var like = false
    @Binding var isAnimation:Bool
    @Binding var isActive:Bool
    @Binding var navBarHidden:Bool
    @Binding var isLoading:Bool
    @Binding var isFullScreen : Bool
    var body: some View {
        VStack{
            Spacer()
            HStack(alignment:.bottom){
                VStack(alignment:.leading,spacing:10){
                    Button(action: {
                        withAnimation{
                            self.isFullScreen.toggle()
                            self.selectedVideo = tailerIndex
                        }
                    }, label: {
                        HStack{
                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                            Text("Full Screen")
                                .font(.subheadline)
                               
                        }
                        .padding(5)
                        .background(BlurView().clipShape(CustomeConer(width: 5, height: 5, coners: [.allCorners])))
                    })
                    
                    HStack{
                        Text(trailer.movieName)
                            .TekoBoldFontFont(size: 25)
                        
                    }
                    
                    HStack{
                        ForEach(trailer.movieType,id: \.self ){ type in
                            Text(type)
                                .font(.system(size: 14))
                                .bold()
                                .foregroundColor(Color.white)
                                .padding(.horizontal,8)
                                .padding(.vertical,5)
                                .background(BlurView().clipShape(CustomeConer(coners: [.allCorners])))
                                .cornerRadius(5)
                        }
                    }

//                    Text(trailer.releaseDate!)
//                        .foregroundColor(.secondary)
//                        .font(.system(size:16))
                    
                }
                .font(.body)
                Spacer()
                
                
                //click icon enter to moviedetail page
                NavigationLink(destination: MovieDetailView(movieId:299534,navBarHidden: $navBarHidden,isAction: $isActive,isLoading: $isLoading)){
                    SmallCoverIcon()
                }
  
                    
//                NavigationLink(
//                    destination: WebImages(
//                        navBarHidden: $navBarHidden,
//                        isAction: $isActive,
//                        isLoading: $isLoading).redacted(reason: self.isLoading ? .placeholder : []),
//                    isActive: $isActive){
//                    Button(action:{isActive.toggle()}){
//                        SmallCoverIcon()
//
//                    }
//                }
                .navigationTitle("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .buttonStyle(StaticButtonStyle())
            }
            .padding(.horizontal,10)
        }
        .foregroundColor(.white)
        .padding(.vertical,15)
        .padding(.bottom,5)
    }
}

struct BackHomePageButton:View{
    var action:()->()
    var body: some View{
        Button(action:action, label: {
            ZStack{
                Circle()
                    .foregroundColor(Color.init("ThemeSubColor").opacity(0.8))
                    .frame(width: 30, height: 50)
                
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .opacity(0.85)
            }
        })

        
        
    }
}

