//
//  UIColor+SwiftUI.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/6/8.
//

import Foundation
import SwiftUI
public extension UIColor {
    var gh: GHUIColorSwiftUIExt { return GHUIColorSwiftUIExt(self) }
    static var Gh: GHUIColorSwiftUIExt.Type { return GHUIColorSwiftUIExt.self }
}

public struct GHUIColorSwiftUIExt {
    internal let color: UIColor
    internal init(_ color: UIColor) { self.color = color }
}

public extension GHUIColorSwiftUIExt {
    var swiftUIColor: Color { return Color(uiColor: color) }
}
