//
//  MovieCoverCardStack.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/8.
//

import SwiftUI
import SDWebImageSwiftUI


struct MovieCoverCardStack: View {
    
    @Binding var isCardSelectedMovie:Bool
    @State var isPress = false
    var movies : [Movie]
    var body: some View {
        VStack{
            ZStack{
                ForEach(0..<movies.count){index in
                    //at most 5 image only
                    if index >= movies.count - 8{
                        MovieCoverCard(movie: movies[index])
                            .frame(width:245)
                            .scaleEffect( 1 - CGFloat(self.movies.reversed().firstIndex(where: {$0.id == movies[index].id})!) * 0.03)
                            .padding(.top,1 - CGFloat(self.movies.reversed().firstIndex(where: {$0.id == movies[index].id})!) * 16)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 8, y: 8)
                        
                    }
                    
                    
                    
                }
            }
        
           
            Text("CoverStack.swift-37")
                .bold()
                .font(.body)
                .padding(.vertical)
          
                
                
        }
        .onTapGesture {
            withAnimation(){
                isCardSelectedMovie.toggle()
            }
        }
    }
}

struct MovieCoverCardStack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            MovieCoverCardStack(isCardSelectedMovie: .constant(false), movies: stubbedMovie)
        }
    }
}


