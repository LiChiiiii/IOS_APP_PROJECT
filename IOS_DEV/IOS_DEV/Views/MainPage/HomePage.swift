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
    @State private var showHomePage = false

    
    var body:some View{
        MainHomeView(showHomePage: $showHomePage)
            .onAppear{
                showHomePage = true
            }
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        
        HomePage()
        
        
    }
}

struct MainHomeView:View{
    @State private var topBarIndx = 0
    @State private var trailerData = VideoList
    @State private var isReload = false
    @State private var value:Float = 0.0
    @State private var isAnimation = false
    @State private var isNavBarHidden = true
    @State private var isActive = false
    @State private var isLoading = true
    @State private var NavIndex = 0
    @Binding var showHomePage:Bool

    
//    init(){
//        UINavigationBar.appearance().barTintColor = UIColor(Color.init("navBarBlack").opacity(0.85))
//        UINavigationBar.appearance().tintColor = .white
//    }
    var body:some View{
        ZStack{
            VStack(spacing:0){
                GeometryReader{geo in
                    NavigationView{
                        ZStack(alignment:.topTrailing){
                            SubHomeView_Player(topBarIndx:$topBarIndx,trailerData:$trailerData,isReload:$isReload,value:$value,isAnimation:$isAnimation,isNavBarHidden:$isNavBarHidden,isActive:$isActive,isLoading:$isLoading, pageHeight: geo.frame(in:.global).height)
                            
                            NavigationLink(
                                destination:  MovieListView(showHomePage: $showHomePage),
                                isActive: $showHomePage){
                                BackHomePageButton(){
                                    //jump back to home page
                                    self.showHomePage.toggle()
                                }
                                .padding(.horizontal,15)
                            }
                            
                        }
                        .navigationViewStyle(DoubleColumnNavigationViewStyle())
                        .navigationTitle("")
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        
                    }
                }
 
            }
            .edgesIgnoringSafeArea(.all)

            
            
        }
      //  .animation(Animation.spring())
    }
}

struct SubHomeView_Player:View{
    @Binding var topBarIndx:Int
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
            PlayerScrollList(isAnimation: $isAnimation, isNavBarHidden: $isNavBarHidden, isActive: $isActive, value: $value, isLoading: $isLoading, trailerData: $trailerData, isReload: $isReload, topBarIndx: $topBarIndx, pageHeight: pageHeight)
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
    @Binding var topBarIndx:Int
    var pageHeight :CGFloat
    var body: some View {
        Group{
            PlayerScrollView(trailerList: $trailerData, reload: $isReload, value:$value, isAnimation: $isAnimation ,pageHegiht: pageHeight){
                LazyVStack(spacing:0){
                    ForEach(0..<trailerData.count){ i in
                        ZStack{
                            Player(VideoPlayer: trailerData[i].videoPlayer)
                                .frame(height:pageHeight)
                            //  .offset(y:-7)
                            MovieIntrol(trailer: trailerData[i], isAnimation: $isAnimation, isActive: $isActive, navBarHidden: $isNavBarHidden,isLoading:$isLoading)
                            VStack{
                                Spacer()
                                VideoProgressBar(value: $value, player: $trailerData[i].videoPlayer)
                                //.offset(y:-7)
                                
                            }
                            
                        }
//                        .onDisappear{
//                         //   data[i].videoPlayer.pause()
//                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


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
    //    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(.bottom,(UIApplication.shared.windows.first?.safeAreaInsets.bottom))
    }
}

struct MovieIntrol: View {
    var trailer:Trailer
    @State private var like = false
    @Binding var isAnimation:Bool
    @Binding var isActive:Bool
    @Binding var navBarHidden:Bool
    @Binding var isLoading:Bool
    var body: some View {
        VStack{
            Spacer()
            HStack(alignment:.bottom){
                VStack(alignment:.leading,spacing:10){
                    HStack{
                        Text(trailer.movieName)
                            .bold()
                            .font(.title)
                        
                    }
                    
                    Text("TailerName")
                        .font(.body)

                    Text("Release Date:12/04/2020")
                    
                }
                .font(.body)
                Spacer()
                
                
                //click icon enter to moviedetail page
//                NavigationLink(destination: MovieDetailView(movieId:399566,navBarHidden: $navBarHidden,isAction: $isActive,isLoading: $isLoading))
//                {
//                    SmallCoverIcon()
//                }
                    
                    
                    
                    
                    
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


//JUST FOR SAVING CODE

//struct HomePage: View {
//    @State private var topbar = 0
//    @State private var data = VideoList
//    @State private var reload = false
//    @State private var value:Float = 0.0
//    @State private var showDetailView = false
//
//    init(){
//        UINavigationBar.appearance().barTintColor = UIColor(Color.init("navBarBlack").opacity(0.85))
//        UINavigationBar.appearance().tintColor = .white
//
//    }
//
//    var body: some View {
//        NavigationView{
//            VStack(spacing:0){
//                GeometryReader{geo in
//                    PlayerView(videoList: $data, reload: $reload, value: $value,pageHeight: geo.size.height)
//                        .edgesIgnoringSafeArea(.all)
//
//                }
//
//            }
//
//            //NavBar()
//
//        }
//
//    }
//
//}
//
//struct PlayerView:View{
//    @Binding var videoList:[Traier]
//    @Binding var reload:Bool
//    @Binding var value:Float
//    @State var isAnimation:Bool = false
//    @State var isAction = false
//    @State var isLoading = false
//    var pageHeight:CGFloat
//
//    var body:some View{
//            PlayerScrollView(trainer: $videoList, reload: $reload, value:$value, isAnimation: $isAnimation ,pageHegiht: pageHeight){
//
//                LazyVStack(spacing:0){
//                    ForEach(0..<videoList.count){ i in
//                        ZStack{
//                            NavigationLink(
//                                destination: WebImages(navBarHidden: .constant(true), isAction: $isAction, isLoading: $isLoading),
//                                isActive: $isAction){
//                                    HStack{
//                                        Player(VideoPlayer: videoList[i].videoPlayer)
//                                            .frame(height:pageHeight)
//                                          //  .offset(y:-24)
//                                    }
//
//                                }
//                                .navigationTitle("")
//                                .navigationBarTitle("")
//                                .navigationBarHidden(true)
//
//                            //     MovieIntrol(trainer: videoList[i], isAnimation: $isAnimation)
//
//                            //                                    VStack{
//                            //                                        Spacer()
//                            //                                        VideoProgressBar(value: $value, player: $videoList[i].videoPlayer)
//                            //                                            .offset(y:-7)
//                            //
//                            //                                    }
//
//                        }
//
//                    }
//                }
//
//            }
//            .edgesIgnoringSafeArea(.all)
//            .onAppear(perform: {
//                videoList[0].videoPlayer.play()
//                videoList[0].videoPlayer.actionAtItemEnd = .none
//
//                //Add this view to NotificationCentre and tell all of those evnet
//                //Chage Replay to true
//
//                //get the time period of the play back control
//                videoList[0].videoPlayer.addPeriodicTimeObserver(forInterval: .init(seconds: 1.0, preferredTimescale: 1), queue: .main){ _ in
//                    self.value =
//                        (Float(videoList[0].videoPlayer.currentTime().seconds / videoList[0].videoPlayer.currentItem!.duration.seconds))
//
//                }
//
//                NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object: videoList[0].videoPlayer.currentItem, queue: .main){ _ in
//                    videoList[0].videoReplay = true
//                    videoList[0].videoPlayer.seek(to: .zero)
//                    videoList[0].videoPlayer.play()
//                    //                print(trainerList[0].videoPlayer.currentTime().seconds)
//                }
//            })
//
//    }
//
//}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
