//
//  GestureDetailVeiw.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/8/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct GestureDetailVeiw: View {

    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    @Binding var navBarHidden:Bool
    @Binding var isAction : Bool
    @Binding var isLoading : Bool
    @Binding var isPresented : Bool
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }

            if movieDetailState.movie != nil {
                
                GestureDetail(movie: self.movieDetailState.movie!, navBarHidden: $navBarHidden, isAction: $isAction, isLoading: $isLoading, isPresented:$isPresented)

            }
        }
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}


struct GestureDetail: View {
   
    let movie: Movie
    //MOVIE URL
    @State private var size = 0.0
    @State private var opacity = 0.0
    @State private var showMovieName = false
    @State private var showAnimation = false
    @Binding var navBarHidden:Bool
    @Binding var isAction : Bool
    @Binding var isLoading : Bool
    @Binding var isPresented : Bool
    @State private var isAppear:Bool = false
    
    //     var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
        
        NavigationView{
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
                        
                      
                        Button(action:{
                            withAnimation(){
                                self.isPresented.toggle()
                            }

                        }){
                            ZStack{
                                Circle()
                                    .frame(width:30,height:30)
                                    .opacity(0.5)
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                            }
                            .foregroundColor(.black)

                        }
                        .position(x: proxy.frame(in: .local).maxX - 40
                                  , y: proxy.frame(in: .local).minY + 60)


                         

                        
                    }
                    .frame(height: 510)
                    //.frame(height:480 - 150)
                    .animation(.spring(),value:showAnimation)
                    //                        Detail Items
                    
                   
                    
//                    MovieInfoDetail(myMovieList: <#[List]#>, movie: movie)
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
//            .navigationTitle("")
//            .navigationBarTitle("")
//            .navigationBarItems(trailing:showBarItem(imgURL: movie.posterURL, name:movie.title).opacity(showMovieName ? 1 : 0).animation(.linear).transition(.flipFromBottom))
            .navigationBarHidden(true)
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
                print("XD")
    //            UIScrollView.appearance().bounces = false
            }
        }
        
        
    }
    
    func loading(){
        DispatchQueue.main.asyncAfter(deadline:.now() + 1.25){
            self.isLoading = false
        }
    }
}
