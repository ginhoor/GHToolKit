//
//  UIImageView+Extension.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/8/8.
//

import Foundation


public extension UIImageView {
    var gh: GHUIImageViewExtension {
        return GHUIImageViewExtension(self)
    }

    static var Gh: GHUIImageViewExtension.Type {
        return GHUIImageViewExtension.self
    }
}

public struct GHUIImageViewExtension {
    internal let imgV: UIImageView
    internal init(_ imgV: UIImageView) {
        self.imgV = imgV
    }
}

public extension GHUIImageViewExtension {
    /// 异步解码图片，再加载
    /// - Parameter path: a file URL that references the local file or directory at path.
    /// - Parameter imageMaxPixelSize: 图片的最大像素质
    public func loadImage(filePath: String, imageMaxPixelSize: CGFloat? = nil) async {
        let img = await UIImage.GH.loadImage(filePath: filePath, imageMaxPixelSize: imageMaxPixelSize)
        Task { @MainActor in
            self.imgV.image = img
        }
    }

}
