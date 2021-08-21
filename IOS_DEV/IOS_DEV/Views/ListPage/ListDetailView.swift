//
//  ListDetailView.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/8/2.
//

import SwiftUI
import UIKit

struct GetListDetailView: View {

    @ObservedObject private var movieDetailState = MovieDetailState()
    @Binding var todo:Bool
    @State private var showView:Bool = false
    var count:Int
    var listDetail:[ListDetail]
    @State var movies:[Movie] = [Movie]()

    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: listDetail[0].movie!.id)
            }

            if self.showView == true {
                ListDetailView(todo: self.$todo, listDetail: listDetail,currentMovie: movies.last, movies: movies, currentList: listDetail.last)
            }
        }
        .onAppear {
            for index in 0...(count-1) {
                self.movieDetailState.loadMovie(id: listDetail[index].movie!.id)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    if movieDetailState.movie != nil {
                        movies.append(self.movieDetailState.movie!)
                        self.showView = true
                    }
                })
                
                sleep(1)
                
            }

            

        }
    }
}


struct ListDetailView: View
{
    @Binding var todo:Bool  //go back ListView
    let imageLoader = ImageLoader()
    @State var listDetail:[ListDetail] //allow as to remove
    @State var currentMovie:Movie?
    @State var movies : [Movie]  //allow as to remove
    @State var currentList:ListDetail?
    @State var gestureState = CardGesture.CardGestureState.inactive
    var body: some View {
        ZStack(){


            ForEach(movies){movie in
                if self.movies.reversed().firstIndex(where: {$0.id == movie.id}) == 0{
                    //render the current item as CoverGesture view

                    CardGesture(
                        DragState: self.$gestureState,
                        onTapGesture: {},
                        willEndTranslation: {(translation) in},
                        EndTranslation: {(direction) in
                            self.getEndPostion(direction: direction)
                        }, movie: movie)
                    
                }else{
                    TheCard(movie: movie)
                        .frame(width:245)
                        .scaleEffect( 1 - CGFloat(self.movies.reversed().firstIndex(where: {$0.id == movie.id})!) * 0.03 + self.calculateScale())
                        .padding(.top,1 - CGFloat(self.movies.reversed().firstIndex(where: {$0.id == movie.id})!) * 16)
                        .animation(.spring())

                }

            }


            GeometryReader{proxy in
                    Button(action:{
                        withAnimation(){
                            self.todo.toggle()
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
                              , y: proxy.frame(in: .local).minY + 10)
                
                if currentMovie != nil
                {
                    Text(currentMovie!.title)
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .font(.system(size: 25))
                        .position(x: proxy.frame(in: .local).midX
                                  , y: proxy.frame(in: .local).minY + 100)
                    
                    self.renderCurrentInfo()
                    .position(x: proxy.frame(in: .local).midX
                              , y: proxy.frame(in: .local).maxY - 100)
                    
                }


            }




        }
        .background(FullMovieCoverBackground(urlPath: self.currentMovie?.posterPath ?? "/oOZITZodAja6optBgLh8ZZrgzbb.jpg").blur(radius: 50))

    }


    func renderCurrentInfo() -> some View{
        ZStack{

                VStack(spacing:10){

                    Text(self.currentMovie!.ratingText)
                        .foregroundColor(.yellow)
                        .font(.system(size: 23))
                    
                    Text(self.currentList!.text)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .font(.system(size: 20))
                    
                }
                .frame(width:300)
                .multilineTextAlignment(.center)
                .opacity(self.gestureState.isDragging ? 0 : 1)
                .animation(.easeInOut)
            

        }

    }

    func getEndPostion(direction:CardGesture.EndTranslationPostion){
        if direction == .left || direction == .right{
            //TODO
            //remove the last movie in array and set current movie

            _ = self.movies.popLast()
            currentMovie = self.movies.last
            _ = self.listDetail.popLast()
            currentList = self.listDetail.last


        }
    }

    func calculateScale()->CGFloat{
        //when dragging it will affect other card behind
        return CGFloat(abs(self.gestureState.translation.width / 6000))
    }
}
