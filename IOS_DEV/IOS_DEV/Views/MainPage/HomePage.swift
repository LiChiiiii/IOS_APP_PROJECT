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


class TrailerVideoVM : ObservableObject {
    //
    @Published var TrailerList : [Trailer] = []
    init(){
        let VideoList:[Trailer] = [
            Trailer(id:1,
                   movieName:"《蜘蛛俠：返校日》Spider-Man: Homecoming",
                   movieType: ["科幻","動作","冒險"],
                   videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "spider1", ofType: "mp4")!)) ,
//                    videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/SpiderManNoWayHome.mp4")!),
                   videoReplay: false,
                   maxValue: 0),
            
            Trailer(id:2,
                   movieName:"《蜘蛛俠：離家日》Spider-Man: Far From Home",
                   movieType: ["科幻","動作","冒險"],
                   videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "spider2", ofType: "mp4")!)) ,
//                    videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/SpiderManNoWayHome.mp4")!),
                   videoReplay: false,
                   maxValue: 0),
            
            Trailer(id:3,
                   movieName:"《蜘蛛俠：不戰無歸》Spider-Man: No Way Home",
                   movieType: ["科幻","動作","冒險"],
                   videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "spider3", ofType: "mp4")!)) ,
//                    videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/SpiderManNoWayHome.mp4")!),
                   videoReplay: false,
                   maxValue: 0),
            
        //
            Trailer(id:4,
                   movieName:"七龍珠第20部劇場版【七龍珠超：布羅利】",
                   movieType: ["動作","冒險"],
                   videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "dbsBroly", ofType: "mp4")!)) ,
//                    videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/dbs.mp4")!),
                   videoReplay: false,
                   maxValue: 0),

            Trailer(id:5,
                   movieName:"七龍珠第21部劇場版 【七龍珠超：超級英雄】",
                   movieType: ["動作","冒險"],
                   videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "2020dbs", ofType: "mp4")!)) ,
//                    videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/2020dbs.mp4")!),
                   videoReplay: false,
                   maxValue: 0),
            Trailer(id:6,
                   movieName:"《黑寡婦》Black Widow",
                   movieType: ["科幻","動作","冒險"],
                   videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bw", ofType: "mp4")!)) ,
//                    videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/bw.mp4")!),
                   videoReplay: false,
                   maxValue: 0),
//            Trailer(id:6,
//                   movieName:"《黑寡婦》Black Widow",
//                   movieType: ["科幻","動作","冒險"],
//                   videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bw", ofType: "mp4")!)) ,
////                    videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/bw.mp4")!),
//                   videoReplay: false,
//                   maxValue: 0),
        ]
        
        TrailerList.append(contentsOf: VideoList.map{$0})
    }
}

class TrailerStateManager : ObservableObject{
    @Published var isReload = false
    @Published var isAnimation = false
    @Published var isNavBarHidden = true
    @Published var isActive = false
    @Published var isLoading = true
    @Published var NavIndex = 0
    @Published var isShowVideoController : Bool = true
    @Published var pageHeight : CGFloat = 0
    init(){}
}


struct StaticButtonStyle : ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct HomePage:View{
    @Binding var showHomePage : Bool
    @Binding var isLogOut : Bool
    @Binding var mainPageHeight : CGFloat
    
    var body:some View{
        NavigationView{
            MovieListView(showHomePage: $showHomePage, isLogOut: self.$isLogOut,mainPageHeight:$mainPageHeight)
        }.environment(\.horizontalSizeClass, .compact)
    }
}

struct MovieTrailerDiscoryView : View{
    @StateObject private var TrailerManager = TrailerStateManager()
    @State private var isLoading : Bool = false
    @State private var orientaion : UIDeviceOrientation = UIDeviceOrientation.unknown
    @Binding var showHomePage : Bool
    @Binding var mainPageHeight : CGFloat
    
    var body : some View{
        ZStack(alignment:.topLeading){
            GeometryReader{ geo in
                ZStack(alignment:.center){
                    HomeTrailerPlayer(showHomePage: $showHomePage, mainPageHeight: $mainPageHeight,pageHeight: geo.frame(in: .global).height)
                }
            }
            
            if !orientaion.isLandscape && (Appdelegate.orientationLock == .portrait){
                BackHomePageButton(){
                    //jump back to home page
                    self.showHomePage.toggle()
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.horizontal,15)
            }
        }
        .onRotate{value in
            orientaion = value
        }
//        .onAppear(){
//            self.isLoading = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08){
//                self.isLoading.toggle()
//            }
//        }
        .environmentObject(TrailerManager)
        .edgesIgnoringSafeArea(.all)
        
    }

}

struct HomeTrailerPlayer:View{
    @EnvironmentObject private var TrailerModel : TrailerVideoVM
    @EnvironmentObject private var TrailerManager : TrailerStateManager
    
    @Binding var showHomePage : Bool
    @Binding var mainPageHeight : CGFloat
    @State private var value : Float = 0
    var pageHeight : CGFloat
    var body:some View{
        PlayerScrollList(value:$value, showHomePage: $showHomePage,mainPageHeight: $mainPageHeight, pageHeight:pageHeight)
            .onAppear(perform: {
                if  TrailerModel.TrailerList.count <= 0{
                    return
                }
                
                TrailerModel.TrailerList[0].videoPlayer.play()
                TrailerModel.TrailerList[0].videoPlayer.actionAtItemEnd = .none
                
                //Add this view to NotificationCentre and tell all of those evnet
                //Chage Replay to true
                
                //get the time period of the play back control
                TrailerModel.TrailerList[0].videoPlayer.addPeriodicTimeObserver(forInterval: .init(seconds: 1.0, preferredTimescale: 1), queue: .main){ _ in
                    self.value =
                    (Float( TrailerModel.TrailerList[0].videoPlayer.currentTime().seconds /  TrailerModel.TrailerList[0].videoPlayer.currentItem!.duration.seconds))
                    
                }
                
                NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object:   TrailerModel.TrailerList[0].videoPlayer.currentItem, queue: .main){ _ in
                    TrailerModel.TrailerList[0].videoReplay = true
                    TrailerModel.TrailerList[0].videoPlayer.seek(to: .zero)
                    TrailerModel.TrailerList[0].videoPlayer.play()
                    
                    //                print(trainerList[0].videoPlayer.currentTime().seconds)
                }
            })
        
        
    }
}


struct FullScreenTop :View{
    @Binding var isUpdateView : Bool
    @Binding var isFullScreen : Bool
    var movieName : String
    
    var body: some View{
        HStack(alignment:.center){
            Button(action: {
                //Close to full screen
                DispatchQueue.main.async {
                    Appdelegate.orientationLock = UIInterfaceOrientationMask.portrait
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                    withAnimation(){
                        self.isFullScreen.toggle()
                        self.isUpdateView = true
                    }
                }

            }, label: {
                Image(systemName: "chevron.left")
                    .padding(.horizontal)
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .padding(5)
            })

            VStack{
                HStack{
                    Text(movieName)
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        
                    
                    Spacer()
                }
            }
            .frame(maxWidth:.infinity)
            .padding(.horizontal)
            Spacer()
                
            
        }
        .edgesIgnoringSafeArea(.top)
        .padding(.top,35)
        .padding(.horizontal,25)
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct VideoTimeline : View {
//    @Binding var value : Float
    var maxValue : Double
    @Binding var isPlaying : Bool
    @Binding var trailerInfo : Trailer
    @State private var value : Float = 0
    var body: some View{
        VStack{
            VideoProgressBar(value: $value, player: $trailerInfo.videoPlayer, minTintColor: .red, maxTintColor: .gray)
            HStack{
                Button(action: {
                    if isPlaying {
                        trailerInfo.videoPlayer.pause()
                    }else{
                        trailerInfo.videoPlayer.play()
                    }
                    isPlaying.toggle()
                    
                }, label: {
                    HStack{
                        Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                    .frame(width: 20, height: 20, alignment: .center)

                })
                
                HStack{
                    Text("\(getTrailerMins(second: trailerInfo.videoPlayer.currentTime().seconds))/\(getTrailerMins(second:maxValue))")
                        .bold()
                        .padding(.horizontal,3)
                }
                Spacer()
            }
           
        }
        .padding(.bottom,20)
        .padding(.horizontal,25)
        .onAppear(){
            trailerInfo.videoPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main){ _ in
                self.value = Float(trailerInfo.videoPlayer.currentTime().seconds / trailerInfo.videoPlayer.currentItem!.duration.seconds)
                
            }
        }
    }
    
    private func getTrailerMins(second : Double)-> String{
        let (m,s) = (((Int(second) % 3600) / 60), ((Int(second) % 3600) % 60))
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        return "\(m_string):\(s_string)"
    }
    
}

struct PlayerScrollList: View {
    @EnvironmentObject  var TrailerModel : TrailerVideoVM
    @EnvironmentObject  var TrailerManager : TrailerStateManager
    
    @State private var isFullScreen : Bool = false
    @State private var currentVideo : Int = 0
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var counter : Int = 1
    @State private var isPlaying : Bool = true
    @State private var trailerTime : Double = 0
    @State private var isUpdateView : Bool  = false //When toggle to FullScreen View
    @State private var fullScreenSize : CGFloat = 0
    @Binding var value : Float
    @Binding var showHomePage : Bool
    @Binding var mainPageHeight : CGFloat

    var pageHeight : CGFloat

    var body: some View {
        Group{
            PlayerScrollView(trailerList: $TrailerModel.TrailerList, reload: $TrailerManager.isReload, value:$value, isAnimation: $TrailerManager.isAnimation , isUpdateView: $isUpdateView,currentVideIndex:$currentVideo,orientation:$orientation ,pageHegiht: Appdelegate.orientationLock == .landscape ? UIScreen.main.bounds.height  : self.mainPageHeight){
                LazyVStack(spacing:0){
                    ForEach(0..<TrailerModel.TrailerList.count){ i in
                        ZStack{
                            if isFullScreen && i != currentVideo{
                                EmptyView()
                            }else{
                                TrailerCell(pageHeight: pageHeight,mainPageHeight:$mainPageHeight,currentVideo: $currentVideo, trailerInfo: $TrailerModel.TrailerList[i], isFullScreen: $isFullScreen, isUpdateView: $isUpdateView, isPlaying: $isPlaying, value: $value , trailerIndex:i)
                                    .onAppear(){
                                        value = 0
                                    }
                            }
                        }
                        .frame(width:UIScreen.main.bounds.width,height: Appdelegate.orientationLock == .landscape ? UIScreen.main.bounds.height  : self.mainPageHeight)
                        
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("")
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        

    }
    
}

struct TrailerCell : View{
    @EnvironmentObject  var TrailerModel : TrailerVideoVM
    @EnvironmentObject  var TrailerManager : TrailerStateManager
    var pageHeight : CGFloat
    @Binding var mainPageHeight : CGFloat
    @Binding var currentVideo : Int
    @Binding var trailerInfo : Trailer
    @Binding var isFullScreen : Bool
    @Binding var isUpdateView : Bool
    @Binding var isPlaying: Bool
    @Binding var value : Float
    @State private var isShowController : Bool = true
    @State private var counter : Int = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var trailerIndex : Int
    var body : some View {

        ZStack(alignment:.bottom){

            Player(VideoPlayer: trailerInfo.videoPlayer,videoLayer:.resizeAspect)
                .frame(width:UIScreen.main.bounds.width,height: Appdelegate.orientationLock == .landscape ? UIScreen.main.bounds.height : self.mainPageHeight)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture{
                    counter = 0
                    withAnimation(.easeOut(duration: 0.2)){
                        isShowController.toggle()
                    }

                }
                .zIndex(0)
                .padding(.top,Appdelegate.orientationLock == .landscape ? 21 : 0)
            

            
            if Appdelegate.orientationLock == .portrait{
                Group{
                    MovieIntrol(trailer: $trailerInfo, tailerIndex: trailerIndex, selectedVideo: $currentVideo, isFullScreen: self.$isFullScreen, isUpdateView: $isUpdateView)
                    VStack{
                        Spacer()
                        VideoProgressBar(value: trailerIndex ==  currentVideo ? $value : .constant(0), player: $TrailerModel.TrailerList[trailerIndex].videoPlayer)
                    }
                }
            } else   if isShowController{
                VStack{
                    FullScreenTop(isUpdateView: $isUpdateView, isFullScreen: $isFullScreen, movieName: trailerInfo.movieName)
                    Spacer()
                    VideoTimeline(maxValue: trailerInfo.videoPlayer.currentItem?.duration.seconds ?? 0, isPlaying: $isPlaying, trailerInfo: $trailerInfo)
                }
                .frame(height:  Appdelegate.orientationLock == .landscape ? UIScreen.main.bounds.height : self.mainPageHeight)
                .background(Color.black.opacity(0.5).onTapGesture{
                    counter = 0
                    withAnimation(.easeOut(duration: 0.2)){
                        isShowController.toggle()
                    }
                })
                .zIndex(2)
            }
            
            
        }
        .onReceive(timer){_ in
            if counter < 3 && isShowController{
                counter += 1
            }else{
                counter = 1
                withAnimation(){
                    self.isShowController = false
                }
            }
        }
        .onDisappear(){
            //remove the timer
            timer.upstream.connect().cancel()
        }
    }
    
}

struct MovieIntrol: View {
    @EnvironmentObject  var TrailerModel : TrailerVideoVM
    @EnvironmentObject  var TrailerManager : TrailerStateManager
    
    @Binding var trailer:Trailer
    var tailerIndex : Int
    @Binding var selectedVideo : Int
    @Binding var isFullScreen : Bool
    @Binding var isUpdateView : Bool
    var body: some View {
        VStack{
            Spacer()
            HStack(alignment:.bottom){
                VStack(alignment:.leading,spacing:10){
                    Button(action: {
                            DispatchQueue.main.async {
                                Appdelegate.orientationLock = UIInterfaceOrientationMask.landscape
                                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                                UINavigationController.attemptRotationToDeviceOrientation()
                                self.isFullScreen.toggle()
                                self.selectedVideo = tailerIndex
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation(){
                                        self.isUpdateView = true
                                    }
                                }

                                
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

                    
                }
                .font(.body)
                Spacer()
                
                VStack{
                    VStack(spacing:8){
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("4")
                            .bold()
                            .font(.caption)
                    }
                    .padding(.vertical,3)

                    
                    VStack(spacing:8){
                        Image(systemName: "ellipsis.bubble.fill")
                        
                            .font(.title)
                            .foregroundColor(.white)
                        Text("30")
                            .bold()
                            .font(.caption)
                    }.padding(.vertical,3)

                    
                    VStack(spacing:5){
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Text("25")
                            .bold()
                            .font(.caption)
                    }
//                    //click icon enter to moviedetail page
                    NavigationLink(destination: MovieDetailView(movieId:299534,navBarHidden: $TrailerManager.isNavBarHidden,isAction: $TrailerManager.isActive,isLoading: $TrailerManager.isLoading)){
                        SmallCoverIcon()
                    }
                    .navigationTitle("")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .buttonStyle(StaticButtonStyle())
                    

                }
                .padding(.horizontal,5)
            }
        }
        .padding(.horizontal,5)
        .foregroundColor(.white)
        .padding(.vertical,15)
        .padding(.bottom,5)
//        .navigationTitle("")
//        .navigationBarTitle("")
//        .navigationBarHidden(true)

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

