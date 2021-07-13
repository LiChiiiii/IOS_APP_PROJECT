//
//  MoreMovieView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/5.
//


import SwiftUI
import SDWebImageSwiftUI

struct MoreMovieView: View {

    let Colums = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LazyVGrid(columns:Colums){
            MovieItem(url: "https://image.tmdb.org/t/p/original/A1Gy5HX3DKGaNW1Ay30NTIVJqJ6.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original//6Wdl9N6dL0Hi0T1qJLWSz6gMLbd.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/6vcDalR50RWa309vBH1NLmG2rjQ.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/AoWY1gkcNzabh229Icboa1Ff0BM.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/9kg73Mg8WJKlB9Y2SAJzeDKAnuB.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/1UCOF11QCw8kcqvce8LKOO6pimh.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/6KErczPBROQty7QoIsaa6wJYXZi.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/h3oT6lZcYC2khtZnzHBgqthj5W.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
            MovieItem(url: "https://image.tmdb.org/t/p/original/zoeKREZ2IdAUnXISYCS0E6H5BVh.jpg")
                .padding(.vertical)
                .padding(.horizontal,3)
        }
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    
    }
    
   
}

struct MoreMovieView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            MoreMovieView()
        }
    }
}

struct MovieItem:View {
    var url:String
    var body: some View {
        Button(action:{
            //ToShowSelectedMovie
        }){
            VStack{
                WebImage(url: URL(string: url))
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple, lineWidth: 1)
                    )

                
                
                VStack(spacing:5){
                    Text("Movie Name")
                        .bold()
                        .font(.subheadline)
                    Text("Type1.Type2.Type3")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
            }
            .foregroundColor(.white)
            
        }
        .buttonStyle(PlainButtonStyle())

    }
}
