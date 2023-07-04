//
//  UIImage+Extension.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/4/1.
//

import Foundation
import AXVToolKit

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

    func compressedImageData(maxSize: CGFloat = 2048) -> Data? {
        if img.size.width > maxSize || img.size.height > maxSize {
            let thumbnail = img.axv.generateThumbnail(maxPixelSize: maxSize, scale: 1)
            return thumbnail?.jpegData(compressionQuality: 0.8)
        } else {
            return img.jpegData(compressionQuality: 0.8)
        }
    }
}

public extension GHTKUIImageExtension {

    func scaleIfNeeded(maxInputImageSize: CGFloat? = nil, hasAlpha: Bool? = nil) -> UIImage {
        var isOpaque = img.getImageFormat() != .PNG
        if let hasAlpha = hasAlpha {
            isOpaque = !hasAlpha
        }

        var actualSize = img.size
        if let maxInputImageSize = maxInputImageSize {
            let scaleSize = CGSize(width: maxInputImageSize, height: maxInputImageSize)
            if max(img.size.width, img.size.height) > maxInputImageSize {
                actualSize = img.size.axv.scaleAspectFit(wrapperSize: scaleSize)
            }
        }
        return img.axv
            .redraw(actualSize: actualSize, isOpaque: isOpaque, scale: 1) ?? img
    }

    func scaleIfNeeded(specificSize: CGSize? = nil, hasAlpha: Bool? = nil) -> UIImage {
        var isOpaque = img.getImageFormat() != .PNG
        if let hasAlpha = hasAlpha {
            isOpaque = !hasAlpha
        }

        var actualSize = img.size
        if let specificSize = specificSize {
            actualSize = specificSize
        }
        return img.axv
            .redraw(actualSize: actualSize, isOpaque: isOpaque, scale: 1) ?? img
    }

}
