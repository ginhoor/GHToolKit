//
//  UIInsets+Extension.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/4/22.
//

import Foundation

public extension UIEdgeInsets {
    var ghInsets: GHTKUIEdgeInsetsExtension { return GHTKUIEdgeInsetsExtension(self) }
    static var GHInsets: GHTKUIEdgeInsetsExtension.Type { return GHTKUIEdgeInsetsExtension.self }
}

public struct GHTKUIEdgeInsetsExtension {
    internal let insets: UIEdgeInsets
    internal init(_ insets: UIEdgeInsets) { self.insets = insets }
}

public extension GHTKUIEdgeInsetsExtension {
    static func all(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }

    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

}
