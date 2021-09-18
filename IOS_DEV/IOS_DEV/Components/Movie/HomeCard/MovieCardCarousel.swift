//
//  MovieCardCarousel.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/8.
//

import SwiftUI


struct MovieCardCarousel: View{
    var movies:[Movie]
    let genreID : Int
    @State private var isCardSelectedMovie:Bool = false
    private func getScale(geo : GeometryProxy)->CGFloat{
       var scale:CGFloat = 1.0
       let x = geo.frame(in: .global).minX
       
       let newScale = abs(x)
       if newScale < 100{
           scale = 1 + (100 - newScale) / 500
       }
       
       return scale
   }
   
    
   var body: some View
   {
    
//       ScrollView(.horizontal, showsIndicators: false)
//       {
//           
//        
//           HStack(spacing: 30)
//           {
            
            VStack{
               
                GeometryReader { proxy in
                    let scaleValue = getScale(geo: proxy)
                    

                    MovieCoverCardStack(isCardSelectedMovie: $isCardSelectedMovie, movies: movies, genreID: genreID)
                            .rotation3DEffect(Angle(degrees:Double(proxy.frame(in: .global).minX - 30)  / -20), axis: (x: 0, y: 20.0, z: 0))
                            .scaleEffect(CGSize(width: scaleValue, height: scaleValue))
                    .onTapGesture {
                            withAnimation(){
                                self.isCardSelectedMovie.toggle()
                            }
                        }
                    .fullScreenCover(isPresented: $isCardSelectedMovie, content: {
                        MovieCardGesture( movies: movies,currentMovie: movies.last, backHomePage: $isCardSelectedMovie)
                    })
                    

                 
                    
                    
               }
                .frame(width: 275)
                
              
                
                
    
             
                
                
            }
            




//           } //hstack
//           .padding(.vertical,50)
//           .padding(.horizontal,28)
//           .padding(.top,50)
//
//
//           }//scrollview
//           .frame(height:600)
       
   }
    

    
    
}


struct MovieCardCarousel_Previews: PreviewProvider
{
   static var previews: some View
   {
    MovieCardCarousel(movies: stubbedMovie, genreID: 28)
              .preferredColorScheme(.dark)
    
   }
}


