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

//for Appstorage
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}


extension View{
    func HiddenKeyBoard(to:Any?,from:Any?,forEvent:UIEvent?){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: to, from: from, for: forEvent)
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
