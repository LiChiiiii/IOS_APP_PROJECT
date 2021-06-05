//
//  SmaillCoverIcon.swift
//  IOS_DEV
//
//  Created by Jackson on 5/5/2021.
//

import SwiftUI
import SDWebImageSwiftUI




struct SmallCoverIcon: View {
    @State var Animating:Bool = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 10)
            .repeatForever(autoreverses: false)
    }
    var body: some View {
        
        ZStack{
            Circle()
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.init("navBarBlack").opacity(0.5))
                .blur(radius: 0.5)
            
            CenterIcon(isAnimating: Animating)
        }
        .animation(self.foreverAnimation)
        .onAppear{
            self.Animating = true
            
        }

    }
    
}

struct CenterIcon:View{
    var isAnimating : Bool
    
    var body: some View{
        ZStack{
            CircleText(radius: 65, text: "Avenger:EndGame",kerning: 15.0,width: 65,height: 65)
                .animation(.none)
                .rotationEffect(Angle(degrees: self.isAnimating ? -360.0 : 0.0))

                AnimatedImage(url:URL(string: "https://image.tmdb.org/t/p/original/thmDdDLQYrJJuhIYQIA4FDpi1E5.jpg"))
                    //   Image(systemName: "arrow.down.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundColor(.purple)
                    )
                    .frame(width: 40, height: 40)
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
        }
        
    }
}




struct SmaillCoverIcon_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            SmallCoverIcon()
        }
        
        
    }
}

