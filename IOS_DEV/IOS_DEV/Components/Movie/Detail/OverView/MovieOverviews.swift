//
//  MovieOverview.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/8.
//

import Foundation
import SwiftUI

struct MovieOverviews:View {
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?
    let imageLoader = ImageLoader()
    
    var body:some View{
        
            VStack(spacing:5){
                VStack(spacing:10){
                    HStack(alignment:.bottom){
                        Text("Plot Summary:")
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    
                    //just support at most 5 line
                    
                    ExpandableText(movie.overview, lineLimit: 5)
                }
                .padding(.horizontal,10)

                
                Spacer()
                
                HStack {
                    if !movie.ratingText.isEmpty {
                        Text(movie.ratingText).foregroundColor(.yellow)
                    }
                    Text(movie.scoreText)
                }
                
                Spacer()
                
                Divider()
                    .background(Color.gray)

                
                Group{
                    VStack(spacing:10){
                        HStack(alignment:.bottom){
                            Text("Movie Capture:")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal,10)
                        
                        MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                    }

                    Spacer()
                    
                    Divider()
                        .background(Color.gray)
                    
                    VStack(spacing:10){
                        HStack(alignment:.bottom){
                            Text("Movie Cast:")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal,10)

                        ActorAvatarList(actorList: ActorLists)

                    }
                    
                    Spacer()

//                    Divider()
//                        .background(Color.gray)
//
//                    MovieInfoView(movie: movie)
//                        .padding(.horizontal,10)
                    
                    
                }
                
                
                
            }
            .foregroundColor(.gray)
        
    }
}



struct ExpandableText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    private var text: String

    let lineLimit: Int

    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
    }

    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? "less" : "more"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing:5) {
            Text(text)
                .lineLimit(expanded ? nil : lineLimit)
                .background(
                    Text(text).lineLimit(lineLimit)
                        .background(GeometryReader { visibleTextGeometry in
                            ZStack { //large size zstack to contain any size of text
                                Text(self.text)
                                    .background(GeometryReader { fullTextGeometry in
                                        Color.clear.onAppear {
                                            self.truncated = fullTextGeometry.size.height > visibleTextGeometry.size.height
                                        }
                                    })
                            }
                            .frame(height: .greatestFiniteMagnitude)
                        })
                        .hidden() //keep hidden
            )
            if truncated {
                Button(action: {
                    withAnimation {
                        expanded.toggle()
                    }
                }){
                    Text(moreLessText)
                        .font(.body)
                        .foregroundColor(.white)
                        
                }
            }
        }
        .font(.subheadline)
        .foregroundColor(Color(UIColor.systemGray3))
    }
}



struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}
