//
//  NavBar.swift
//  IOS_DEV
//
//  Created by Jackson on 17/4/2021.
//

import SwiftUI

//Working Process
struct NavBar: View {
    @Binding var selectedIndex:Int
    var body: some View {
        HStack(alignment:.bottom,spacing:0){
                Spacer()
                NavItemButton(buttonIndex: 0, itemIcon: "film", itemText: "Home", isSelectedInt: $selectedIndex){
                    selectedIndex = 0
                }
            Spacer()
                NavItemButton(buttonIndex: 1, itemIcon: "message", itemText: "Group", isSelectedInt: $selectedIndex){
                    selectedIndex = 1
                }
                NavItemButton(buttonIndex: 2, itemIcon: "magnifyingglass", itemText: "Search", isSelectedInt: $selectedIndex){
                    selectedIndex = 2
                }
            Spacer()
                NavItemButton(buttonIndex: 3, itemIcon: "list.and.film", itemText: "My List", isSelectedInt: $selectedIndex){
                    selectedIndex = 3
                }
            Spacer()
                NavItemButton(buttonIndex: 4, itemIcon: "person", itemText: "Profile", isSelectedInt: $selectedIndex){
                    selectedIndex = 4
                }
            Spacer()
            }
            
            .padding(.top)
            .padding(.horizontal,10)
            .background(Color.init("navBarBlack"))
            .edgesIgnoringSafeArea(.all)
            .frame(width:UIScreen.main.bounds.width,height: 65)
        
        
            
        
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            NavBar(selectedIndex: .constant(0))
        }
    }
}

struct NavItemButton:View{
    var buttonIndex:Int
    var unselectColor:Color = Color.gray
    var selectColor:Color = Color.blue
    var itemIcon:String
    var itemText:String
    
    @Binding var isSelectedInt:Int
    
    var action:()->()
    var body:some View{
        Button(action:action){
            GeometryReader{ proxy in
                VStack(alignment:.center,spacing:10){
                    Image(systemName: itemIcon)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                      //  .resizable()
                    Text(itemText)
                        .frame(width: 50)
                        .font(.caption)

                }
            }
            .foregroundColor(isSelectedInt == buttonIndex ? selectColor : unselectColor)
            .font(.system(size: 18))
            
        }
    }
}
