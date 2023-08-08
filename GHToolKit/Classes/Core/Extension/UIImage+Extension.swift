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

    /// 异步解码图片，再加载
    /// - Parameter path: a file URL that references the local file or directory at path.
    /// - Parameter imageMaxPixelSize: 图片的最大像素质
    static func loadImage(filePath: String, imageMaxPixelSize: CGFloat? = nil) async -> UIImage? {
        let imageURL = URL(fileURLWithPath: filePath) as CFURL

        var options: CFDictionary?
        if let imageMaxPixelSize = imageMaxPixelSize {
            options = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceThumbnailMaxPixelSize: imageMaxPixelSize
            ] as CFDictionary
        }

        guard let source: CGImageSource = CGImageSourceCreateWithURL(imageURL, nil),
              let imageRef: CGImage = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

        let img = UIImage(cgImage: imageRef)
        return img
    }
}
