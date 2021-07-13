//
//  AutoScroll.swift
//  IOS_DEV
//
//  Created by 張馨予 on 2021/5/18.
//

import SwiftUI
import UIKit

struct AutoScroll_V: View
{
    let scSize = UIScreen.main.bounds
    var body: some View
    {
        VStack()
        {
            SearchBar(text: .constant(""))
                .position(x: 195, y: 50)
                .padding(.top, 70)
                .clipped()
                .ignoresSafeArea(edges: .top)
            
            ScrollView(.horizontal,showsIndicators: false)
            {
                HStack()
                {
                    VStack()
                    {
                        SearchButtom(ImageName: "wa")
                        SearchButtom(ImageName: "ha")
                        SearchButtom(ImageName: "hh")
                    }
                    VStack()
                    {
                        SearchButtom(ImageName: "ja")
                        SearchButtom(ImageName: "ka")
                        SearchButtom(ImageName: "ta")
                    }
                    VStack()
                    {
                        SearchButtom(ImageName: "me")
                        SearchButtom(ImageName: "wa")
                        SearchButtom(ImageName: "ha")
                    }
                    VStack()
                    {
                        SearchButtom(ImageName: "ja")
                        SearchButtom(ImageName: "ka")
                        SearchButtom(ImageName: "ta")
                    }
                    VStack()
                    {
                        SearchButtom(ImageName: "wa")
                        SearchButtom(ImageName: "ha")
                        SearchButtom(ImageName: "hh")
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, height: 360)
            //.background(Color.black)
            
            HStack()
            {
                Button(action: {print("test")})
                {
                    HStack()
                    {
                        Text("ImageName")
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                        .padding(.top)
                        .frame(width: 100, height: 105)
                        
                    }
                    .frame(width: 100, height: 105, alignment: .leading)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 2, x: 1.0, y: 1.0)
                    .padding(.top, 50)
                    .padding(.horizontal,20)
                }
                .foregroundColor(.black)
                
                
                VStack()
                {
                   
                    Text("Genre:")
                        .font(.title)
                    Text("Actor:")
                        .font(.title)
                    Text("Director:")
                        .font(.title)
                    
                }
                .padding(.top,48)
                Spacer()
                

            }
            Button(action: {print("test")})
            {
                HStack{
                    Spacer()
                    Text("Search")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    
                    Spacer()
                }
                .frame(width: 120, height: 20, alignment: .center)
                .padding(.vertical,15)
                .background(Color.orange)
                .cornerRadius(20)
                .padding(.leading,scSize.width*2/4)
                .padding(.top,20)
            }
        }
        
    }
}

struct AutoScroll_V_Previews: PreviewProvider
{
    static var previews: some View
    {
        AutoScroll_V()
            .preferredColorScheme(.dark)
    }
}
