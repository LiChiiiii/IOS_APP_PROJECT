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
    var listDetail:[ListDetail]

    //現在只能抓一個電影的照片
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: listDetail[0].movie!.id)
            }

            if movieDetailState.movie != nil {
                
                //ListDetailView(todo: Binding<Bool>)
            }
        }
        .onAppear {
            self.movieDetailState.loadMovie(id: listDetail[0].movie!.id)
        }
    }
}


struct ListDetailView: View
{
    @Binding var todo:Bool
    var listDetail:[ListDetail]
    var movie:Movie
    
    var body: some View
    {
        
        
        Spacer()
    
        Button(action:{
            withAnimation(){
                todo.toggle()

            }
        }){
            HStack {
                Image(systemName: "arrow.backward")
                    .font(.title)
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.bottom,20)
                    .padding(.leading)
                Spacer()

            }
        }
    
        
        ScrollView
        {
           
            HStack(spacing: 0)
            {
                Text("test")
            }
            
        }
       
        
    }
}
