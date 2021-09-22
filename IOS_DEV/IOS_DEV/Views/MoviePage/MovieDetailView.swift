//
//  WebImage.swift
//  IOS_DEV
//
//  Created by Jackson on 18/4/2021.
//

import SwiftUI
import SDWebImageSwiftUI


struct MovieDetailView: View {

    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    @ObservedObject private var listController = ListController()
    @Binding var navBarHidden:Bool
    @Binding var isAction : Bool
    @Binding var isLoading : Bool
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }

            if movieDetailState.movie != nil {
                
                WebImages(movie: movieDetailState.movie! , navBarHidden: $navBarHidden, isAction: $isAction, isLoading: $isLoading,myMovieList:listController.mylistData)

            }
        }
        .onAppear {
            print(self.movieId)
            self.movieDetailState.loadMovie(id: self.movieId)
//            self.listController.GetMyList(userID: NowUserID!)
            
        }
    }
}

//struct GetMyMovieList: View {
//    @ObservedObject private var listController = ListController()
//    @State var NowUser:Me?
//    @Binding var navBarHidden:Bool
//    @Binding var isAction : Bool
//    @Binding var isLoading : Bool
//    @State var movie : Movie
//
//    var body: some View {
//        ZStack {
//
//
//
//
//        }
//        .onAppear {
//            self.listController.GetMyList(userID: (NowUser?.id)!)
//
//        }
//    }
//}



struct movieImage:View{
    let imgURL: URL
    var body : some View{
        WebImage(url:imgURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [Color.init("navBarBlack").opacity(0.0),Color.init("navBarBlack").opacity(0.95)]), startPoint:.top, endPoint: .bottom)
            )
            .background(Color.black.edgesIgnoringSafeArea(.all))

    }
}

struct WebImages: View {
   
    @State var movie : Movie
    //MOVIE URL
    @State private var size = 0.0
    @State private var opacity = 0.0
    @State private var showMovieName = false
    @State private var showAnimation = false
    @Binding var navBarHidden:Bool
    @Binding var isAction : Bool
    @Binding var isLoading : Bool
    @State private var isAppear:Bool = false
    @State var myMovieList : [CustomList]

    
    //     var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
        
        
        ZStack(alignment:Alignment(horizontal: .center, vertical: .top)){
            
            ScrollView(.vertical, showsIndicators: false){
                GeometryReader{ proxy in
                    if proxy.frame(in:.global).minY > -480{
                        movieImage(imgURL: movie.posterURL)
                            .offset(y:-proxy.frame(in:.global).minY)
                            .frame(width: isAppear ?  0: proxy.frame(in:.global).maxX, height:
                                   isAppear ? 0 :proxy.frame(in:.global).minY  > 0 ?
                                    proxy.frame(in:.global).minY + 480 : 480   )
                            
                            .opacity((Double(proxy.frame(in:.global).minY * 0.0045 + 1)) < 0.45 ? 0.45 :(Double(proxy.frame(in:.global).minY * 0.0045 + 1)))
                            .blur(radius: CGFloat((Double(proxy.frame(in:.global).minY * 0.005 + 1)) < 0.45  ? (Double(proxy.frame(in:.global).minY) * -1 * 0.03) : 0))
                            .onChange(of: proxy.frame(in:.global).minY, perform: { value in
                                
                            //-----下滑顯示bar上的討論區按鈕和電影名稱-----//
                                
//                                let offset = value + UIScreen.main.bounds.height / 2.2
//                                print(offset)
                                
//
//                                if offset < 80{
//
//                                if offset > 0{
//
//                                    let op_value = (80 - offset) / 80 * 5 * 1.2
//                                    self.opacity = Double(op_value)
//                                    self.showMovieName = true
//
//                                    return
//                                }
//                                self.opacity = 1
//                                }
//                                else{
//                                    self.opacity = 0
//                                    self.showMovieName = false
//                                }
                            })
                        
                    }
                }
                .frame(height: 510)
                //.frame(height:480 - 150)
                .animation(.spring(),value:showAnimation)
                //                        Detail Items
                
               
               
                MovieInfoDetail(myMovieList:myMovieList , movie: movie)
                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    
                //     .offset(y:10)
                //   .background(Color.black.edgesIgnoringSafeArea(.all))
                
                
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
            .background(Color.init("navBarBlack").edgesIgnoringSafeArea(.all))
            
//            Group{
//                HStack(alignment:.bottom){
//                    HStack(alignment:.center,spacing:0){
//                        Button(action:{
//                            //back to the page
//                            withAnimation{
//                                isAction.toggle()
//                                isAppear = true
//                            }
//                        }){
//                            HStack(alignment:.center , spacing: 5){
//                                Image(systemName: "chevron.backward")
//                                    .font(.system(size:18,weight:.bold))
//                                Text("Back")
//                            }
//
//                        }
//
//                        Spacer()
//
//                            if self.showMovieName{
//                                showBarItem(imgURL: movie.posterURL,name:movie.title)
//                                    .animation(.easeInOut(duration: 0.08))
//                                    .transition(.asymmetric(insertion: .flipFromBottom, removal:.fade))
//                            }
//
//                    }
//                }
//                .frame(minHeight:50)
//                .padding(.horizontal,10)
//                .padding(.bottom,5)
//
//            }
//            .foregroundColor(opacity > 0.6 ? Color(UIColor.systemGray3):.white)
//            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
//            .background(Color.init("navBarBlack").opacity(opacity))
//            .shadow(color: Color.init("navBarBlack").opacity(self.opacity > 0.8 ? 0.5 : 0), radius: 5, x: 0, y: 5)
//            .edgesIgnoringSafeArea(.top)
//            .unredacted()


            
            
        }
        .edgesIgnoringSafeArea(.all)
        .frame(height:UIScreen.main.bounds.height)
        .navigationTitle("")
        .navigationBarTitle("")
        .navigationBarItems(trailing:showBarItem(imgURL: movie.posterURL, name:movie.title).opacity(showMovieName ? 1 : 0).animation(.linear).transition(.flipFromBottom))
        .padding(.horizontal,10)
        .onAppear{
            isAppear = false
            loading()
//            withAnimation(){
//                self.navBarHidden = false
//            }
//            UIScrollView.appearance().bounces = true
            
        }
        .onDisappear{
//            withAnimation(){
//                self.navBarHidden = true
//            }
            self.isLoading = true
//            UIScrollView.appearance().bounces = false
        }
        
        
    }
    
    func loading(){
        DispatchQueue.main.asyncAfter(deadline:.now() + 1.25){
            self.isLoading = false
        }
    }
}

struct MovieInfoDetail: View {
    @State private var isMyList = false
    @State private var gotoChat : Bool = false
    @State var myMovieList : [CustomList]
    @State var movie : Movie
    
    var body: some View {
        VStack(spacing:5){
            HStack(alignment:.center){
                
                
                Text(movie.title)
                    .bold()
                    .font(.system(size:35))
                    .foregroundColor(.red)
              //      .unredacted()
                

            
                Spacer()
                
                
                
//                Button(action:{
//                    print("MovieDetailView 220 chat")
//                   forumController.GetAllArticle()
//                }){
//                    HStack(spacing:0){
//                        Text("CHAT")
//                            .bold()
//                            .foregroundColor(.white)
//                    }
//                    .frame(width: 60, height: 30  )
//                    .background(Color.blue)
//                    .cornerRadius(20)
//                    .font(.system(size: 15))
//                }
//                .simultaneousGesture(TapGesture().onEnded{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//                        self.gotoChat = true
//
//                    })
//
//                })
//                .fullScreenCover(isPresented: self.$gotoChat, content: {
//                    TopicView(articles: forumController.articleData, isPresented: self.$gotoChat)
//
//                })
                
                NavigationLink(destination: GetTopicView(movie:movie))
                {
                    Text("討論區")
                        .bold()
                        .frame(width: 60, height: 30  )
                        .background(Color.blue)
                        .cornerRadius(20)
                        .font(.system(size: 15))
                }

                


       

            }
            .padding(.horizontal,10)
            
            Spacer()
            
            HScrollList(info: movie)
                .font(.system(size: 14))
             //   .unredacted()
            
            
            
            Spacer()
            Genre(Genres: movie.genres!)
                .padding(.horizontal,10)
              //  .unredacted()
            
            Spacer()


            
            //ScrollView for more info
            VStack(alignment:.leading,spacing:5){

                HStack(spacing:10){
                    SmallRectButton(title: "Play", icon: "arrowtriangle.right.fill"){
                        //To Move to Video source page
                        print("test")
                    }

                    //------------------------  + MY List ----------------------- -//
                    Menu {
                        ForEach(myMovieList, id:\.id){list in
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text(list.Title)
                            })
                        }
                    

                   } label: {
                        SmallBorderOnlyButton(title: "My List", icon: "plus", onChangeIcon: "checkmark",isMylist: $isMyList){
                            //To Add this movie to my List
                            isMyList.toggle()
                        }
                   }
                    

                    
                    
                    Spacer()
                    
                    

                    SmallVerticalButton(IsOnImage: "heart.fill", IsOffImage: "heart", text: "Like", IsOn: true){
                        //TODO
                    }
                    
                    

                    .padding(.trailing)

                }
                .padding(.horizontal,10)
          //      .unredacted()

                MovieDetailList(movie: movie, tabs: [.overView,.trailer,.more,.resources])
                    
//
//                VerticalButton()



            }
            .padding(.top,5)
            .font(.system(size: 14))
            .foregroundColor(Color(UIColor.systemGray3))

            
            
        }
        .font(.system(.title3))
        .foregroundColor(.white)
        .padding(.top)
//        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct VerticalButton: View {
    var body: some View {
        HStack(spacing:30){
            SmallVerticalButton(IsOnImage: "paperplane.fill", IsOffImage: "paperplane.fill", text: "Share", IsOn: true){
                //TODO
            }
            
            SmallVerticalButton(IsOnImage: "message.fill", IsOffImage: "message", text: "comment", IsOn: true){
                //TODO
            }
            Spacer()
        }
      //  .padding(.horizontal)
    }
}

struct NavBarImage:View{
    @State var show = false
    let imgURL: URL
    var body:some View{
        
        VStack{
            WebImage(url:imgURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct showBarItem:View{
    let imgURL: URL
    let name:String
    var body:some View{
        HStack(alignment:.bottom,spacing:10){
            Spacer()
            NavBarImage(imgURL:imgURL )
                .frame(width:22,height: 22)
                .padding(.horizontal)
            
            HStack(alignment:.center,spacing:8){
                Text(name)
                    .bold()
                    .font(.system(size:12))
                    .foregroundColor(.gray)
                
                smallNavButton(buttonColor: .blue, buttonTextColor: .white, text: "CHAT"){
                    print("chat test")
                }
            }
            

        }
//
    }
    
}
//



//struct testt:View{
//    @Binding var videoList:[Trailer]
//    @Binding var reload:Bool
//    @Binding var value:Float
//    @Binding var showDetailView:Bool
//    @State var isAnimaing = false
//    var pageHeigh:CGFloat
//
//    var body:some View{
////
////        NavigationView{
//        PlayerScrollView(trailerList: $videoList, reload: $reload, value:$value, isAnimation:$isAnimaing  ,pageHegiht: pageHeigh){
//                LazyVStack(spacing:0){
//                    ForEach(0..<videoList.count){ i in
//                        ZStack{
//
//                                Player(VideoPlayer: videoList[i].videoPlayer)
//                                    .frame(height:pageHeigh)
//                                    .offset(y:-7)
//
//                   //         MovieIntrol(trainer: videoList[i], isAnimation: $isAnimaing)
//
//                            VStack{
//                                Spacer()
//                                VideoProgressBar(value: $value, player: $videoList[i].videoPlayer)
//                                    .offset(y:-7)
//
//                            }
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
//
//    }
//
////}
//
//struct testImage_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ZStack{
//            Color.black.edgesIgnoringSafeArea(.all)
//            b()
//        }
//        .foregroundColor(.black)
//    }
//}
//
//struct b:View{
//    var body: some View{
//
//        VStack(spacing:0){
//            GeometryReader{geo in
//
//                NavigationView{
//
//                    a(pageHeight: geo.frame(in: .global).height)
//
//                }
//            }
//
//          //  NavBar(selectedIndex: .constant(0))
//
//        }
//        .edgesIgnoringSafeArea(.all)
//
//
//    }
//}
//
//struct a:View {
//    @State private var show = false
//    @State private var topbar = 0
//    @State private var data = VideoList
//    @State private var reload = false
//    @State private var value:Float = 0.0
//    @State private var showDetailView = false
//    @State private var anima = false
//    @State private var navBarHidden = true
//    @State private var isAction = false
//    @State private var isLoading = true
//    var pageHeight:CGFloat
//    init(pageHeight:CGFloat){
//        UINavigationBar.appearance().barTintColor = UIColor(Color.init("navBarBlack").opacity(0.85))
//        UINavigationBar.appearance().tintColor = .white
//        self.pageHeight = pageHeight
//        UINavigationController().interactivePopGestureRecognizer?.isEnabled = false
//
//    }
//
//    var body: some View {
//        NavigationLink(
//            destination: WebImages(navBarHidden: $navBarHidden, isAction: $isAction, isLoading: $isLoading),
//            isActive: $isAction){
//            ZStack{
//                PlayerScroll(anima: $anima, navBarHidden: $navBarHidden, isAction: $isAction, value: $value, isLoading: $isLoading, data: $data, reload: $reload, topbar: $topbar, pageHeight: pageHeight)
//                    .onAppear(perform: {
//                        data[0].videoPlayer.play()
//                        data[0].videoPlayer.actionAtItemEnd = .none
//
//                        //Add this view to NotificationCentre and tell all of those evnet
//                        //Chage Replay to true
//
//                        //get the time period of the play back control
//                        data[0].videoPlayer.addPeriodicTimeObserver(forInterval: .init(seconds: 1.0, preferredTimescale: 1), queue: .main){ _ in
//                            self.value =
//                                (Float(data[0].videoPlayer.currentTime().seconds / data[0].videoPlayer.currentItem!.duration.seconds))
//
//                        }
//
//                        NotificationCenter.default.addObserver(forName: Notification.Name.AVPlayerItemDidPlayToEndTime, object: data[0].videoPlayer.currentItem, queue: .main){ _ in
//                            data[0].videoReplay = true
//                            data[0].videoPlayer.seek(to: .zero)
//                            data[0].videoPlayer.play()
//                            //                print(trainerList[0].videoPlayer.currentTime().seconds)
//                        }
//                    })
//
//                TopBar(topbar: $topbar)
//
//
//
//            }
//
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .navigationTitle("")
//        .navigationBarTitle("")
//        .navigationBarHidden(navBarHidden)
//        .onAppear{
//            UINavigationController().setNavigationBarHidden(navBarHidden, animated: true)
//        }
//
//
//
//    }
//
//}
//
//struct PlayerScroll: View {
//    @Binding var anima:Bool
//    @Binding var navBarHidden:Bool
//    @Binding var isAction:Bool
//    @Binding var value:Float
//    @Binding var isLoading:Bool
//    @Binding  var data : [Trailer]
//    @Binding var reload : Bool
//    @Binding var topbar:Int
//    var pageHeight :CGFloat
//    var body: some View {
//        Group{
//
//            PlayerScrollView(trailerList: $data, reload: $reload, value:$value, isAnimation: $anima ,pageHegiht: pageHeight){
//                LazyVStack(spacing:0){
//                    ForEach(0..<data.count){ i in
//                        ZStack{
//                            Player(VideoPlayer: data[i].videoPlayer)
//                                .frame(height:pageHeight)
//                            //  .offset(y:-7)
//                            MovieIntrol(trailer: data[i], isAnimation: $anima, isActive: $isAction, navBarHidden: $navBarHidden,isLoading:$isLoading)
//                            VStack{
//                                Spacer()
//                                VideoProgressBar(value: $value, player: $data[i].videoPlayer)
//                                //.offset(y:-7)
//
//                            }
//                        }
//                        .onDisappear{
//                         //   data[i].videoPlayer.pause()
//                        }
//                    }
//                }
//                .edgesIgnoringSafeArea(.all)
//            }
//            .edgesIgnoringSafeArea(.all)
//        }
//    }
//}
