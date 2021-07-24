//
//  ActorAvatarList.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/5.
//


import SwiftUI
import SDWebImageSwiftUI

struct ActorAvatarList: View {
    var actorList : [Person]
    var body:some View{
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(){
                
               Avatar(actorList: actorList[0])
                        
                
            }
            
        }
    }
}

//struct ActorAvatarList_Previews: PreviewProvider {
//    static var previews: some View {
//        ActorAvatarList(actorList: ActorLists)
//    }
//}

struct Avatar:View{
    var actorList : Person
    var body:some View{
        VStack(spacing:5){
            WebImage(url: actorList.ProfileImageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(lineWidth: 1.0)
                        .foregroundColor(.purple)

                )
            
            Group{
                Text(actorList.name)
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                //    .multilineTextAlignment(.center)
                    .frame(width:120)
                
                Text(actorList.name)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
    }
}
