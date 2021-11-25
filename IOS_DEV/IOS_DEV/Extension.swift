//
//  Extension.swift
//  IOS_DEV
//
//  Created by Jackson on 20/4/2021.
//


import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension String{
    func widthOfStr(Font font:UIFont) ->CGFloat{
        let fontAttr = [NSAttributedString.Key.font:font]
        let size = self.size(withAttributes: fontAttr)
        return size.width
    }
    
}


extension Font{
    static func CourgetteRegular(size: CGFloat)->Font{
        .custom("Courgette-Regular", size: size)
    }
    
    static func TekoBoldFont(size:CGFloat)->Font{
        .custom("Teko-Bold", size:size)
    }
}
//
struct setCourgetteRegularFont : ViewModifier{
    var size : CGFloat
    func body(content: Content) -> some View {
        content.font(Font.CourgetteRegular(size: size))
    }
}

struct setTekoBoldFont : ViewModifier{
    var size : CGFloat
    func body(content: Content) -> some View {
        content.font(Font.TekoBoldFont(size: size))
    }
}

extension View{
    func CourgetteRegularFont(size:CGFloat = 18)-> some View{
        ModifiedContent(content: self, modifier:setCourgetteRegularFont(size: size) )
    }
    
    func TekoBoldFontFont(size:CGFloat = 18)-> some View{
        ModifiedContent(content: self, modifier:setTekoBoldFont(size: size) )
    }
}
