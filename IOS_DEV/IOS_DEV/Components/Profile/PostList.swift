//
//  PostList.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/9/5.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct PostList:View{
    @State var cardShown : Bool = false
    
    var body:some View{
        
            ZStack(alignment: .trailing){
                
                
                Button(action: {
                    withAnimation(){
                        self.cardShown.toggle()
                    }
                })
                {
                    Image(systemName: "plus")
                        .rotationEffect(.degrees(cardShown ? 45 : 0))
                        .foregroundColor(.white)
                        .font(.system(size:22,weight: .bold))
                        .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
                        
                }
                .padding(20)
                .background(Color("ButtonRed"))
                .mask(Circle())
                .shadow(color: Color("ButtonRed"), radius: 5)
                .zIndex(10)
                
               
//                PostListCard(cardShown: self.$cardShown)
                
            }
        
            


    }

}


struct PostListCard : View{
    @Binding var cardShown : Bool
    @State private var cardOffset:CGFloat = 0
    var body : some View{
        VStack{
            Spacer()
            VStack(spacing:12){

                Capsule()
                    .fill(Color.gray)
                    .frame(width: 60, height: 4)

                Text("PREVIEW RESULT")
                    .bold()
                    .foregroundColor(.gray)
                VStack{
                    HStack(){
                        //Movie Image Cover Here
                        HStack(alignment:.top){
                            WebImage(url: URL(string: "https://www.themoviedb.org/t/p/original/4q2hz2m8hubgvijz8Ez0T2Os2Yv.jpg"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 135)
                                .cornerRadius(10)
                                .clipped()
                            //Movie Deatil

                            //OR MORE...
                            //Name,Genre,Actor,ReleaseDate,Time, Langauge etc
                            VStack(alignment:.leading,spacing:10){
                                Text("Name:A Quiet Place Part II")
                                    .bold()
                                    .font(.headline)
                                    .lineLimit(1)
                                Text("Genre:Science Fiction, Thriller")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                Text("Actor:Evelyn Abbott,Cillian Murphy")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                Text("Release:05/28/2021")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                Text("Time:1h37m")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            .padding(.top)


                        }
                        .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
                    }
                    VStack(alignment:.leading){
                        Text("Overview:")
                            .bold()
                            .font(.subheadline)
                            .lineLimit(1)

                        Text("Following the events at home, the Abbott family now face the terrors of the outside world. Forced to venture into the unknown, they realize that the creatures that hunt by sound are not the only threats that lurk beyond the sand path.")
                            .font(.footnote)
                            .lineLimit(3)

                    }
                    .padding(.horizontal)
                    HStack(spacing:45){

                        SmallRectButton(title: "Detail", icon: "ellipsis.circle"){
                            withAnimation(){
                                self.cardShown.toggle()
                            }
                        }

                        SmallRectButton(title: "More", icon: "magnifyingglass", textColor: .white, buttonColor: Color("BluttonBulue2")){
                            withAnimation(){
                                self.cardShown.toggle()
                            }
                        }

                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal,5)
                .padding(.top,10)
                .padding(.bottom)
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                //The preview result here
            }
            .padding(.top)
            .background(BlurView().clipShape(CustomeConer(coners: [.topLeft,.topRight])))
            .offset(y:cardOffset)
            .gesture(
                DragGesture()
                    .onChanged(self.onChage(value:))
                    .onEnded(self.onEnded(value:))
            )
            .offset(y:self.cardShown ? 0 : UIScreen.main.bounds.height)
        }
        .ignoresSafeArea()
        .background(Color
                        .black
                        .opacity(self.cardShown ? 0.3 : 0)
                        .onTapGesture {
                            withAnimation(){
                                self.cardShown.toggle()
                            }
                        }
                        .ignoresSafeArea().clipShape(CustomeConer(coners: [.topLeft,.topRight])))

    }

    private func onChage(value : DragGesture.Value){
        print(value.translation.height)
        if value.translation.height > 0 {
            self.cardOffset = value.translation.height
        }
    }

    private func onEnded(value : DragGesture.Value){
        if value.translation.height > 0 {
            withAnimation(){
                let cardHeight = UIScreen.main.bounds.height / 4

                if value.translation.height > cardHeight / 2.8 {
                    self.cardShown.toggle()
                }
                self.cardOffset = 0
            }
        }
    }

}

//struct CustomeConer : Shape {
//
//    var coners : UIRectCorner
//
//    func path(in rect: CGRect) -> Path {
//        //set coner and coner radius
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: coners, cornerRadii: CGSize(width: 30, height: 30))
//        return Path(path.cgPath)
//    }
//}

