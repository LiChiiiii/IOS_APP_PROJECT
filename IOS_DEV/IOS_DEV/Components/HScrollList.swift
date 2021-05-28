//
//  HScrollList.swift
//  IOS_DEV
//
//  Created by Jackson on 22/4/2021.
//

import SwiftUI

struct Info:Identifiable
{
    var id = UUID()
    let movieScore:String
    let Age:String
    let Leaderboard:String
    let movieLanguage:String
    let movieByte:String
}

let data1 = Info(
    movieScore:"4",
    Age:"15+",
    Leaderboard:"#1",
    movieLanguage:"ZH",
    movieByte:"2.9"
)
let data2 = Info(
    movieScore:"4",
    Age:"18+",
    Leaderboard:"#2",
    movieLanguage:"ZH",
    movieByte:"0.9"
)
let data3 = Info(
    movieScore:"4",
    Age:"3+",
    Leaderboard:"#5",
    movieLanguage:"ZH",
    movieByte:"1.9"
)

let data = [data1,data2,data3]

struct InfoView: View
{
    var info :Info
    
    var body: some View
    {
        HStack(spacing:15)
        {
            VStack
            {
                Text("評分")
                Text(info.movieScore)
            }
            
            Divider()
            
            VStack
            {
                Text("年齡")
                Text(info.Age)
            }
            
            Divider()
            
            VStack
            {
                Text("語言")
                Text(info.movieLanguage)
            }
            
            Divider()
            
            VStack
            {
                Text("排行榜")
                Text(info.Leaderboard)
            }
            
            Divider()
            
            VStack
            {
                Text(info.movieByte)
                Text("GB")
            }
            
            Divider()
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 55)
        
    }
}

struct Scroll: View
{
    var body: some View
    
    {
        let full_Screen = UIScreen.main.bounds.size
        
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(spacing:15)
            {
                ForEach(data) { item in
                    GeometryReader { geometry in
                        InfoView(info: item)
                            .rotation3DEffect(Angle(degrees:
                                Double(geometry.frame(in: .global).minX - 50) / -20
                            ), axis: (x: 0, y: 10, z: 0))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                }
            }
            
        }
        .frame(width: full_Screen.width, height: 70)
    }
    
}

struct HScrollList: View
{
    var body: some View
    {
        List{
            Scroll()
        }
    }
}


struct HScrollList_Previews: PreviewProvider
{
    static var previews: some View
    {
        HScrollList()
    }
}
