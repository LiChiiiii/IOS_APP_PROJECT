//
//  NavBar.swift
//  IOS_DEV
//
//  Created by Jackson on 17/4/2021.
//

import SwiftUI

//Working Process
struct NavBar: View {
    var body: some View {

            HStack{
                Spacer()
                Button(action:{
                    //index 0
                }){
                    VStack(spacing:5){
                        Text("Home")
                        
                        
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 30, height:30)
                            
                    }
                    .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action:{
                    //index 0
                }){
                    VStack(spacing:5){
                        Text("Home")
                        
                        
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 30, height:30)
                            
                    }
                    .foregroundColor(.white)
                }
                Spacer()
                Button(action:{
                    //index 0
                }){
                    VStack(spacing:5){
                        Text("Home")
                        
                        
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 30, height:30)
                            
                    }
                    .foregroundColor(.white)
                }
                Spacer()
                Button(action:{
                    //index 0
                }){
                    VStack(spacing:5){
                        Text("Home")
                        
                        
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 30, height:30)
                            
                    }
                    .foregroundColor(.white)
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: 70)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            NavBar()
        }
    }
}
