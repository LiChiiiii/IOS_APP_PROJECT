//
//  MovieListView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/8.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var nowPlayingState = MovieListState()
    @StateObject private var upcomingState = MovieListState()
    @StateObject private var topRatedState = MovieListState()
    @StateObject private var popularState = MovieListState()
    
    @StateObject var genreTypeState = GenreTypeState()
    @StateObject var genreTypeState2 = GenreTypeState()
    @StateObject var genreTypeState3 = GenreTypeState()
    @StateObject var genreTypeState4 = GenreTypeState()
    @StateObject var genreTypeState5 = GenreTypeState()
    @Binding var showHomePage:Bool
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                ScrollView(.horizontal, showsIndicators: false)
                {
                    LazyHStack(spacing: 30)
                    {
                        //one
                        Group {
                            if genreTypeState.movies != nil {
                                MovieCardCarousel(movies: genreTypeState.movies!,genreID:28)
                                    .environmentObject(genreTypeState)
                                    
                
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
                                    .environmentObject(genreTypeState2)
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
                                    .environmentObject(genreTypeState3)
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
                                    .environmentObject(genreTypeState4)
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
                                    .environmentObject(genreTypeState5)
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
                .frame(height:600)
                
            }.onAppear{
                self.genreTypeState.genreType(genreID:28)
                self.genreTypeState2.genreType(genreID:16)
                self.genreTypeState3.genreType(genreID:12)
                self.genreTypeState4.genreType(genreID:35)
                self.genreTypeState5.genreType(genreID:80)
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
        .navigationBarTitle("Discovery")
        .toolbar{
            
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
                            .foregroundColor(.white)
                        
                        Text("Trailer")
                            .bold()
                            .foregroundColor(.white)
                            .font(.footnote)
                        
                    }
                    .foregroundColor(.black)
            
                        
                }
            }
        }
        .padding(.bottom,5)
       
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(showHomePage: .constant(false))
    }
}

