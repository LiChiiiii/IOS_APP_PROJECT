//
//  ListDetailScroll.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/9/7.
//

import SwiftUI

struct ListDetailScroll: View {
    var body: some View {
        
        ListDetails()
    }
}

struct ListDetailScroll_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailScroll()
           
    }
}

struct ListDetails : View {
    
    @State var menu = 0
    @State var page = 0
    
    var body: some View{
        
        ZStack{
            
            Color(.black).edgesIgnoringSafeArea(.all)
            
            VStack{
                
                ZStack{
                    
                    HStack{
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("Menu")
                                .renderingMode(.original)
                                .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Image("pic")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Text("Food Items")
                        .font(.system(size: 22))
                }
                
//                HStack(spacing: 15){
//
//                    Button(action: {
//
//                        self.menu = 0
//
//                    }) {
//
//                        Text("Chinese")
//                            .foregroundColor(self.menu == 0 ? .white : .black)
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 20)
//
//                    }
//                    .background(self.menu == 0 ? Color.black : Color.white)
//                    .clipShape(Capsule())
//
//                    Button(action: {
//
//                        self.menu = 1
//
//                    }) {
//
//                        Text("Italian")
//                            .foregroundColor(self.menu == 1 ? .white : .black)
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 20)
//
//                    }
//                    .background(self.menu == 1 ? Color.black : Color.white)
//                    .clipShape(Capsule())
//
//                    Button(action: {
//
//                        self.menu = 2
//
//                    }) {
//
//                        Text("Mexican")
//                            .foregroundColor(self.menu == 2 ? .white : .black)
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 20)
//
//                    }
//                    .background(self.menu == 2 ? Color.black : Color.white)
//                    .clipShape(Capsule())
//                }
//                .padding(.top, 30)
                
                GeometryReader{g in
                    
                    // Simple Carousel List....
                    // Using GeomtryReader For Getting Remaining Height...
                    
                    
                    ListDetailPage(page: self.$page)
                    

                }

            }
            .padding(.vertical)
        }
    }
}

struct ListDetailPage : View {
    
    @Binding var page : Int
    @State private var currentPage = 0
    
    var body: some View{
        
        ScrollView(.init()){
            TabView(selection: $currentPage){
                ForEach(data){i in
                    
                    ListDetailCard(page: self.$currentPage, width: UIScreen.main.bounds.width, data: i)
  

                    
                }
            
            }
            
            .edgesIgnoringSafeArea(.all)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear(perform: {
                UIScrollView.appearance().alwaysBounceVertical = false
            })
            .onDisappear(perform: {
                UIScrollView.appearance().alwaysBounceVertical = true
            })

        }
        
    }
}

struct ListDetailCard : View {
    
    @Binding var page : Int
    var width : CGFloat
    var data : Type
    
    var body: some View{
        
        VStack{
            
            VStack{
                
                Text(self.data.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,20)
                
                Text(self.data.cName)
                    .foregroundColor(.gray)
                    .padding(.vertical)
                
                Spacer(minLength: 0)
                
                Image(self.data.image)
                .resizable()
                .frame(width: self.width - (self.page == self.data.id ? 100 : 150), height: (self.page == self.data.id ? 250 : 200))
                    .cornerRadius(20)
                
                Text(self.data.price)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.top, 20)
                
                Button(action: {
                    
                }) {
                    
                    Text("Buy")
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                }
                .background(Color("Color"))
                .clipShape(Capsule())
                .padding(.top, 20)
                
                
                Spacer(minLength: 0)
                
                // For Filling Empty Space....
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 25)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.top, 25)
            .padding(.vertical, self.page == data.id ? 0 : 25)
            .padding(.horizontal, self.page == data.id ? 0 : 25)
            
            // Increasing Height And Width If Currnet Page Appears...
        }
        .frame(width: self.width)
        .animation(.default)
    }
}


struct Type : Identifiable {
    
    var id : Int
    var name : String
    var cName : String
    var price : String
    var image : String
}

var data = [

    Type(id: 0, name: "Soba Noodles", cName: "Chinese", price: "$25",image: "soba"),
    
    Type(id: 1, name: "Rice Stick Noodles", cName: "Italian", price: "$18",image: "rice"),
    
    Type(id: 2, name: "Hokkien Noodles", cName: "Chinese", price: "$55",image: "hokkien"),
    
    Type(id: 3, name: "Mung Bean Noodles", cName: "Chinese", price: "$29",image: "bean"),
    
    Type(id: 4, name: "Udon Noodles", cName: "Chinese", price: "$15",image: "udon")
]
