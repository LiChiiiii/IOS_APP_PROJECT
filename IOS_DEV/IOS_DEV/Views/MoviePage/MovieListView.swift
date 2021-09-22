//
//  MovieListView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/8.
//

import SwiftUI

struct MovieListView: View {
    
    
//    @StateObject
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
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false){
            
         
            VStack{
                ScrollView(.horizontal, showsIndicators: false)
                {
                    
                 
                    HStack(spacing: 30)
                    {
                        //one
                        Group {
                            if genreTypeState.movies != nil {
                                MovieCardCarousel(movies: genreTypeState.movies!,genreID:28)
                
                            } else {
                                LoadingView(isLoading: self.genreTypeState.isLoading, error: self.genreTypeState.error) {
                                    self.genreTypeState.genreType(
                                        genreID:28)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //two
                        Group {
                            if genreTypeState2.movies != nil {
                                MovieCardCarousel(movies: genreTypeState2.movies!,genreID:16)
                            } else {
                                LoadingView(isLoading: self.genreTypeState2.isLoading, error: self.genreTypeState2.error) {
                                    self.genreTypeState2.genreType(
                                        genreID:16)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //three
                        Group {
                            if genreTypeState3.movies != nil {
                                MovieCardCarousel(movies: genreTypeState3.movies!,genreID:12)
                            } else {
                                LoadingView(isLoading: self.genreTypeState3.isLoading, error: self.genreTypeState3.error) {
                                    self.genreTypeState3.genreType(
                                        genreID:12)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //four
                        Group {
                            if genreTypeState4.movies != nil {
                                MovieCardCarousel(movies: genreTypeState4.movies!,genreID:35)
                            } else {
                                LoadingView(isLoading: self.genreTypeState4.isLoading, error: self.genreTypeState4.error) {
                                    self.genreTypeState4.genreType(
                                        genreID:35)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                        //five
                        Group {
                            if genreTypeState5.movies != nil {
                                MovieCardCarousel(movies: genreTypeState5.movies!,genreID:80)
                            } else {
                                LoadingView(isLoading: self.genreTypeState5.isLoading, error: self.genreTypeState5.error) {
                                    self.genreTypeState5.genreType(
                                        genreID:80)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                        
                    } //hstack
                    .padding(.vertical,50)
                    .padding(.horizontal,28)
                    .padding(.top,50)


                }//scrollview
                .frame(height:535)
                
            }.onAppear{
                self.genreTypeState.genreType(genreID:28)
                self.genreTypeState2.genreType(genreID:16)
                self.genreTypeState3.genreType(genreID:12)
                self.genreTypeState4.genreType(genreID:35)
                self.genreTypeState5.genreType(genreID:80)

            }
            
        
            
            
                
            VStack{
              
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCarousel(title: "Now Playing", movies: nowPlayingState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if upcomingState.movies != nil {
                        MoviePosterCarousel(title: "Upcoming", movies: upcomingState.movies!)
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
        .navigationBarTitle("Discovery")
        .toolbar{
            ToolbarItemGroup(placement:.navigationBarLeading){
                HStack{
                    Image("LogoIconsBlack")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:100)
                        .offset(x:-15)
                    
                }
            }
            
            ToolbarItemGroup(placement:.navigationBarTrailing){
                Button(action:{
                    withAnimation(){
                        //TO trailer view
                        showHomePage.toggle()
                    }
                }){
                    
                    VStack(spacing:5){
                        Image(systemName: "arrowtriangle.forward.square.fill")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Tariler")
                            .bold()
                            .font(.footnote)
                        
                    }
                    .foregroundColor(.black)
            
                        
                }
            }
        }//toolbar

       
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(showHomePage: .constant(false))
    }
}

