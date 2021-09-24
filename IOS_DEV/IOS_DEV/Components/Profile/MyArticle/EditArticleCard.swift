//
//  EditArticleCard.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/9/25.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI



struct EditArticleCard:View{
    @ObservedObject private var forumController = ForumController()
    @Binding var editAction : Bool
    @State var title : String
    @State var text : String
    @State var article : Article

    var body:some View{

        VStack{

            VStack{
                Text("編輯文章")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Spacer(minLength: 0)
            }
            .padding([.top],40)

            //--------標題---------//
            VStack(alignment: .center, spacing: 15) {
                Text("Article Title ")
                    .foregroundColor(.white)
                    .font(.system(size: 20).bold())

                TextField("your title", text: $title )
                    .font(.system(size: 22))
                    .padding()
                    .background(Color(.gray).opacity(0.1))

            }
            .padding()

            Divider()
                .padding(.horizontal)
            Spacer(minLength: 0)

            //--------內文---------//
            VStack(alignment: .center, spacing: 15) {
                Text("Article Text ")
                    .foregroundColor(.white)
                    .font(.system(size: 20).bold())

                TextEditor(text: $text )
                    .font(.system(size: 22))
                    .padding()
                    .background(Color(.gray).opacity(0.1))
                    .frame(height:300)

            }
            .padding()



            //--------save button---------//

            HStack(spacing: 15) {
                Button(action: {
                    self.forumController.PutArticle(articleID: article.id!, Title: self.title, Text: self.text, LikeCount: article.LikeCount)
                    self.editAction.toggle()
                })
                {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(40)

                }
                .disabled(self.title == "" || self.text == "" ? true : false)
                .opacity(self.title == "" || self.text == "" ? 0.5 : 1)

                
                Button(action: {
                    self.editAction.toggle()
                })
                {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .padding()
                    
                }


            }
            .padding()

        }
//        .background(Color.black.opacity(0.6))
    }

}

//struct EditArticleCard_Previews: PreviewProvider {
//    static var previews: some View {
//        EditArticleCard()
//
//
//    }
//}
