//
//  SwiftUIView.swift
//  new
//
//  Created by 張馨予 on 2021/1/28.
//

import SwiftUI
 
let screen = UIScreen.main.bounds //取得螢幕尺寸
 
 
struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}
 
 
let sectionData1 = Section(
    title: "劉以豪",
    text: "高淇淇老公",
    logo: "豪",
    image: Image("hh"),
    color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
)
let sectionData2 = Section(
    title: "易烊千璽",
    text: "Jackson的好朋友",
    logo: "璽",
    image: Image("ja"),
    color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
)
 
let sectionData3 = Section(
    title: "劉以豪",
    text: "高淇淇老公",
    logo: "豪",
    image: Image("hh"),
    color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
)
 
 
let sectionData = [sectionData1,sectionData2,sectionData3]
 

 
 
struct SectionView: View
{
    var section: Section
    
    var body: some View
    {
        VStack
        {
            HStack(alignment: .top)
            {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.black)
                Spacer()
                //Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 570)
        .background(section.image)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.7), radius: 5, x: 0, y: 5)
    }
}
 


 
struct CardScroll: View
{
    var body: some View
    {
        
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(spacing: 35)
            {
                            ForEach(sectionData) { item in
                                GeometryReader { geometry in
                                    SectionView(section: item)
                                        .rotation3DEffect(Angle(degrees:
                                            Double(geometry.frame(in: .global).minX - 50) / -20
                                        ), axis: (x: 0, y: 10, z: 0))
                                }
                                .frame(width: 250, height: 570)
                            }
                        }
                        .padding(50)
                        .padding(.bottom, 30)
                        .frame(height:800)
        }
        .offset(y: -30)
    }
}
struct CardsView: View
{
    var body: some View
    {
        List{
            CardScroll()
        }
    }
}
 
 
struct Cards_Previews: PreviewProvider
{
    static var previews: some View
    {
        CardsView()
            
    }
}

