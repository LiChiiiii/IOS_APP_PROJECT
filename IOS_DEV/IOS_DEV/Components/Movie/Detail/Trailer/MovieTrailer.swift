//
//  MovieTrailer.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/12.
//

import SwiftUI
import SafariServices


struct MovieTrailer: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                TrailerView(movie: self.movieDetailState.movie!)
            }
        }
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}



struct TrailerView:View {
    
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?
  
    
    var body: some View {
     
            
            List {  //List會讓這塊無法顯示在頁面上 

                if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                    Text("Trailers").font(.headline)
                    
                    Spacer()
                    
                    Divider()
                        .background(Color.gray)
                    
                    ForEach(movie.youtubeTrailers!) { trailer in
                        Button(action: {
                            self.selectedTrailer = trailer
                        }) {
                            HStack {
                                Text(trailer.name)
                                Spacer()
                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(Color(UIColor.systemBlue))
                            }
                        }
                    }
                }
            
            }
            .sheet(item: self.$selectedTrailer) { trailer in
                SafariView(url: trailer.youtubeURL!)
            
            }
       
        
    }
}

struct MovieTrailer_Previews: PreviewProvider {
    static var previews: some View {
        MovieTrailer(movieId: 399566)
            .preferredColorScheme(.dark)
    }
}
