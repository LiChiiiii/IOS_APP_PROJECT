//
//  MovieOTT.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/24.
//


import SwiftUI
import SafariServices


struct MovieOTT: View {

    let movieTitle: String
    @ObservedObject private var movieResourceState = MovieResourceState()

    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieResourceState.isLoading, error: self.movieResourceState.error) {
                self.movieResourceState.fetchMovieResource(query:movieTitle )
            }

            MovieOTTView(OTT: self.movieResourceState.resource)
            
        }
        .onAppear {
            self.movieResourceState.fetchMovieResource(query: movieTitle)
        }
    }
}



struct MovieOTTView:View {
    
    let OTT: [ResourceResponse]
    @State private var selected: ResourceResponse?
  
    
    var body: some View {

        VStack{

           
            Text("OTT").font(.headline)
            Spacer()
            
            ForEach(OTT, id:\.ott) { resource in
                Button(action: {
                    self.selected = resource
                }) {
                    HStack {
                        Link(destination: URL(string: resource.result[0].href)!){
                            Text(resource.ott)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                    Spacer()

                    Divider()
                        .background(Color.gray)
                }
            }
  
            
            Spacer(minLength: 80)
    
        }
//        .sheet(item: self.$selected) { resource in
//            SafariView(url: URL(string: resource.result[0].href)!)
//
//        }

        
    }
}



struct MovieResource_Previews: PreviewProvider {
    static var previews: some View {
        MovieOTTView(OTT: OTTurl)
            .preferredColorScheme(.dark)
    }
}
