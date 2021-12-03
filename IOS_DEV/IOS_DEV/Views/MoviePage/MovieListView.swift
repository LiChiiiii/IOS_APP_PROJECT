//
//  MovieListView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/8.
//

import SwiftUI

struct MovieListView: View {
    //Manager this in a class
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    @ObservedObject var genreTypeState = GenreTypeState()
    @ObservedObject var genreTypeState2 = GenreTypeState()
    @ObservedObject var genreTypeState3 = GenreTypeState()
    @ObservedObject var genreTypeState4 = GenreTypeState()
    @ObservedObject var genreTypeState5 = GenreTypeState()
    
    @Binding var showHomePage:Bool
    @Binding var isLogOut : Bool
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                ScrollView(.horizontal, showsIndicators: false)
                {
                    LazyHStack(spacing: 30)
                    {
                        //one
                        Group {
                            if genreTypeState.genreMovies != nil {
                                MovieCardCarousel(movies: genreTypeState.genreMovies!,genreID:GenreType.Action.rawValue)
                                    .environmentObject(genreTypeState)
                                    
                
                            } else {
                                LoadingView(isLoading: self.genreTypeState.isLoading, error: self.genreTypeState.error) {
//                                    self.genreTypeState.genreType(
//                                        genreID:28)
                                    self.genreTypeState.getGenreCard(genre: .Action)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //two
                        Group {
                            if genreTypeState2.genreMovies != nil {
                                MovieCardCarousel(movies: genreTypeState2.genreMovies!,genreID:GenreType.Animation.rawValue)
                                    .environmentObject(genreTypeState2)
                            } else {
                                LoadingView(isLoading: self.genreTypeState2.isLoading, error: self.genreTypeState2.error) {
//                                    self.genreTypeState2.genreType(
//                                        genreID:16)
                                    self.genreTypeState2.getGenreCard(genre: .Animation)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //three
                        Group {
                            if genreTypeState3.genreMovies != nil {
                                MovieCardCarousel(movies: genreTypeState3.genreMovies!,genreID:GenreType.Adventure.rawValue)
                                    .environmentObject(genreTypeState3)
                            } else {
                                LoadingView(isLoading: self.genreTypeState3.isLoading, error: self.genreTypeState3.error) {
//                                    self.genreTypeState3.genreType(
//                                        genreID:12)
                                    self.genreTypeState3.getGenreCard(genre: .Adventure)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //four
                        Group {
                            if genreTypeState4.genreMovies != nil {
                                MovieCardCarousel(movies: genreTypeState4.genreMovies!,genreID:GenreType.Comedy.rawValue)
                                    .environmentObject(genreTypeState4)
                            } else {
                                LoadingView(isLoading: self.genreTypeState4.isLoading, error: self.genreTypeState4.error) {
//                                    self.genreTypeState4.genreType(
//                                        genreID:35)
                                    self.genreTypeState4.getGenreCard(genre: .Comedy)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //five
                        Group {
                            if genreTypeState5.genreMovies != nil {
                                MovieCardCarousel(movies: genreTypeState5.genreMovies!,genreID:GenreType.Crime.rawValue)
                                    .environmentObject(genreTypeState5)
                            } else {
                                LoadingView(isLoading: self.genreTypeState5.isLoading, error: self.genreTypeState5.error) {
//                                    self.genreTypeState5.genreType(
//                                        genreID:80)
                                    self.genreTypeState5.getGenreCard(genre: .Crime)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                    } //hstack
                    .padding(.vertical,50)
                    .padding(.horizontal,28)
                    .padding(.top,50)


                }//scrollview
                .frame(height:600)
                
            }.onAppear{
                self.genreTypeState.getGenreCard(genre: .Action)
//                self.genreTypeState.genreType(genreID:28)
                self.genreTypeState2.getGenreCard(genre: .Animation)
//                self.genreTypeState2.genreType(genreID:16)
                self.genreTypeState3.getGenreCard(genre: .Adventure)
//                self.genreTypeState3.genreType(genreID:12)
                self.genreTypeState4.getGenreCard(genre: .Comedy)
//                self.genreTypeState4.genreType(genreID:35)
                self.genreTypeState5.getGenreCard(genre: .Crime)
//                self.genreTypeState5.genreType(genreID:80)
            }

            LazyVStack{
              
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCarousel(title: "Now Playing", movies: nowPlayingState.movies!)
                            .padding(.bottom)
                        
                    } else {
                        LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                Group {
                    if upcomingState.movies != nil {
                        MoviePosterCarousel(title: "Upcoming", movies: upcomingState.movies!)
                            .padding(.bottom)
                    } else {
                        LoadingView(isLoading: self.upcomingState.isLoading, error: self.upcomingState.error) {
                            self.upcomingState.loadMovies(with: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                
                Group {
                    if topRatedState.movies != nil {
                        MoviePosterCarousel(title: "Top Rated", movies: topRatedState.movies!)
                            .padding(.bottom)
                        
                    } else {
                        LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                            self.topRatedState.loadMovies(with: .topRated)
                        }
                    }
                    
                    
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if popularState.movies != nil {
                        MoviePosterCarousel(title: "Popular", movies: popularState.movies!)
                            .padding(.bottom)
                        
                    } else {
                        LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                
            
            }
            .onAppear {
                self.nowPlayingState.loadMovies(with: .nowPlaying)
                self.upcomingState.loadMovies(with: .upcoming)
                self.topRatedState.loadMovies(with: .topRated)
                self.popularState.loadMovies(with: .popular)
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarTitle("\(NowUserName), \(getTime())")
        .toolbar{
            ToolbarItemGroup(placement:.navigationBarLeading){
                Button(action:{
                    withAnimation(){
                        //TO trailer view
                        withAnimation{
                            isLogOut.toggle()
                            UserDefaults.standard.set("", forKey: "userToken")
                        }
    
                    }
                }){
                    HStack(spacing:5){
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("登出")
                            .bold()
                            .font(.footnote)
                        
                    }
                    .foregroundColor(.white)
            
                        
                }

            }
            
            ToolbarItemGroup(placement:.navigationBarTrailing){
                Button(action:{
                    withAnimation(){
                        //TO trailer view
                        showHomePage.toggle()
                    }
                }){
                    
                    HStack{
                        Image(systemName: "arrowtriangle.forward.square.fill")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("預告片")
                            .bold()
                            .font(.footnote)
                        
                    }
                    .foregroundColor(.white)
            
                        
                }
            }
            

        }//toolbar
//        .onAppear(){
//            APIService.shared.getMovieCardInfoByGenre(genre: .Action){ result in
//                switch(result){
//                case .success(let response):
//                    print(response.results)
//
//                case .failure(let err):
//                    print(err.localizedDescription)
//                }
//            }
//        }

        
    }
    
    func getTime() -> String{
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour{
        case 6..<12:
            return "早上好!"
        case 12:
            return "中午好!"
        case 13..<17:
            return "下午好!"
        case 17..<22:
            return "傍晚好!"
        default:
            return "晚上好!"
        }

    }
}

//struct MovieListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListView(showHomePage: .constant(false))
//    }
//}
//
