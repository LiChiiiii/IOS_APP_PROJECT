//
//  HScrollList.swift
//  IOS_DEV
//
//  Created by Jackson on 22/4/2021.
//

import SwiftUI

//GIVEN INFO OF CURRENT MOVIE
/*
 1.RANKING //No Need
 2.RELEASE DAY
 3.MOVIE TIME
 4.Movie Rate
 5.Movie Language
 6.Type
 
 ju
 
 */

struct HScrollList: View {
    var info:[DetailInfo]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment:.center,spacing:15){
                //DATE
                VStack(spacing:10){
                    Text("RELEASE DATE")
                        .bold()
                    Text("2012")
                        .font(.subheadline)
                        
                }
                .frame(minWidth:80)
 

                Divider()
                    .background(Color.gray)
                
                VStack(spacing:10){
                    Text("TIME")
                        .bold()
                    Text("162MINS")
                        .font(.subheadline)
                }
                .frame(minWidth:80)
     
                
                Divider()
                    .background(Color.gray)
                
                //LANGUAGE
                VStack(spacing:10){
                    Text("LANGUAGE")
                        .bold()
                    Text("ENG")
                        .font(.subheadline)
                }
                .frame(minWidth:80)
               
                
                Divider()
                    .background(Color.gray)
                
                VStack(spacing:10){
                    Text("RESTRICTED.LV")
                        .bold()
                    Text("13+")
                        .font(.subheadline)
                }
                .frame(minWidth:80)

                
//                Divider()
//                    .background(Color.gray)
                
//                VStack(spacing:10){
//                    Text("TYPE")
//                        .bold()
//                    Text("Action 3+")
//                        .font(.subheadline)
//
//                }
//                .frame(minWidth:80)
    
            
            }
            .frame(height: 50)
            .foregroundColor(.gray)
            
        }
        .foregroundColor(.white)
        
        
    }
}
    
struct HScrollList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            HScrollList(info: [.data,.time,.language,.rate])
        }
        
    }
}


enum DetailInfo:String {
    case data = "RELEASE DATE"
    case time = "TIME"
    case language = "LANGUAGE"
    case rate = "RESTRICTED.LV"
}
