//
//  WebImage.swift
//  IOS_DEV
//
//  Created by Jackson on 18/4/2021.
//

import SwiftUI
import SDWebImage
import Kingfisher

struct WebImage: View {
    //MOVIE URL
    @State private var size = 0.0
    var body: some View {
        ZStack(alignment:.topLeading){
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
         
                VStack{
                    GeometryReader{ proxy in
                        KFImage(URL(string: "https://image.tmdb.org/t/p/original/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0),Color.black.opacity(1)]), startPoint:.top, endPoint: .bottom)
                                
                            )
                            .offset(y:-proxy.frame(in:.global).minY)
                            .frame(width: proxy.frame(in:.global).maxX, height: proxy.frame(in:.global).minY+480)
                            .blur(radius:-proxy.frame(in:.global).minY / 10)
                        // .brightness(Double(proxy.frame(in:.global).minY) / 1000)
                    }
                    .frame(height:480)
                    //Detail Items
                    VStack(spacing:10){
                        
                        HStack{
                            Text("Movie Name")
                                .bold()
                                .font(.system(size:40))
                            
                            Spacer()
                            
                            HStack(spacing:5){
                                Text("9.0")
                                Image(systemName: "star.fill")
                                    .renderingMode(.original)
                            }
                        }
                        
                        
                        
                        HStack{
                            ZStack{
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Text("32")
                                    .foregroundColor(.red)
                            }
                            Divider()
                                .background(Color(UIColor.systemGray5))
                            
                            Text("2021")
                            Divider()
                                .background(Color(UIColor.systemGray5))
                            
                            Text("132mins")
                            Divider()
                                .background(Color(UIColor.systemGray5))
                            
                            Text("16+")
                            
                            Divider()
                                .background(Color(UIColor.systemGray5))
                            
                            Text("16+")
                            
                            Spacer()
                        }
                        .font(.system(size:12))
                        .foregroundColor(Color(UIColor.systemGray2))
                        .frame(height:12)
                        
                        
                        //ScrollView for more info
                 
                    }
                    .font(.system(.title3))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .offset(y:-180)
        //            .background(Color.black.edgesIgnoringSafeArea(.all))
        //            .padding(.top)
                   
                    
                    
                    
                    
                    
                }
                
        }
                
            Button(action:{
                //BackToHomePage
            }){
                
                ZStack{
                    Group{
                        HStack{
                            Image(systemName: "circle.fill")
                                .font(.system(size:32))
                                .foregroundColor(Color.white.opacity(0.3))
                                .padding(.bottom,20)
                                .offset(x:-3)
                                .padding(.horizontal)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .foregroundColor(Color.black.opacity(0.5))
                                .padding(.bottom,20)
                                .padding(.leading)
                            Spacer()
                            
                        }
                    }
                    .padding(.top,30)
                
                }
                
            }
            
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width)
        
    }
}


struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage()
    }
}
