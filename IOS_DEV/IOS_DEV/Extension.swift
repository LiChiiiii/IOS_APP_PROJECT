//
//  Extension.swift
//  IOS_DEV
//
//  Created by Jackson on 20/4/2021.
//


import Foundation
import SwiftUI

extension String{
    func widthOfStr(Font font:UIFont) ->CGFloat{
        let fontAttr = [NSAttributedString.Key.font:font]
        let size = self.size(withAttributes: fontAttr)
        return size.width
    }
}
