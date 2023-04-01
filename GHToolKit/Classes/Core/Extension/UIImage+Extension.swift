//
//  UIImage+Extension.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/4/1.
//

import Foundation

public extension UIImage {
    var gh: GHTKUIImageExtension { return GHTKUIImageExtension(self) }
    static var GH: GHTKUIImageExtension.Type { return GHTKUIImageExtension.self }
}

public struct GHTKUIImageExtension {
    internal let img: UIImage
    internal init(_ img: UIImage) { self.img = img }
}


public extension GHTKUIImageExtension {
    func resizableImage(resizingMode: UIImage.ResizingMode = .tile, withCapInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> UIImage {
        return img.resizableImage(withCapInsets: withCapInsets, resizingMode: resizingMode)
    }
}
