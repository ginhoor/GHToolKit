//
//  UIImageExtension.swift
//  EnhancerKit
//
//  Created by 大帅 on 2022/8/1.
//

import Foundation
import UIKit
import SDWebImage
import AXVToolKit

public extension UIImage {
    func saveByFormat(destinationURL: URL, quality: CGFloat = 1.0) throws {
        if getImageFormat() == .PNG {
            try axv.savePNG(destinationURL: destinationURL)
        } else {
            try axv.saveJPEG(destinationURL: destinationURL, quality: quality)
        }
    }

    static func decode(image: UIImage? = nil, contentsOfFile file: String? = nil, qos: DispatchQoS.QoSClass = .default) async -> (UIImage?, Bool) {
        var originalImage: UIImage?
        if let image = image {
            originalImage = image
        } else if let file = file,
                  let image = UIImage(contentsOfFile: file) {
            originalImage = image
        }

        if let image = originalImage {
            if image.sd_isDecoded {
                return (image, true)
            } else {
                if let decodeImg = UIImage.sd_decodedImage(with: image) {
                    return (decodeImg, true)
                } else {
                    return (image, false)
                }
            }
        } else {
            return (nil, false)
        }
    }

    static func decodeImage(image: UIImage? = nil, contentsOfFile file: String? = nil, qos: DispatchQoS.QoSClass = .default, decodeClosure: ((_ image: UIImage?, _ isDecoded: Bool) -> Void)? = nil) {

        DispatchQueue.global(qos: qos).async {
            var originalImage: UIImage?

            if let image = image {
                originalImage = image
            } else if let file = file,
                      let image = UIImage(contentsOfFile: file)
            {
                originalImage = image
            }

            if let image = originalImage {
                if image.sd_isDecoded {
                    DispatchQueue.main.async {
                        decodeClosure?(image, true)
                    }
                } else {
                    if let decodeImg = UIImage.sd_decodedImage(with: image) {
                        DispatchQueue.main.async {
                            decodeClosure?(decodeImg, true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            decodeClosure?(image, false)
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    decodeClosure?(nil, false)
                }
            }
        }
    }

}

// MARK: - Image Format

public extension UIImage {

    enum ImageFormat: String {
        case Unknown
        case JPEG
        case PNG
        case GIF
        case TIFF
        case WebP
        case HEIC
        case HEIF

        public var extensionName: String {
            return self.rawValue.lowercased()
        }
    }

    func getImageFormat() -> ImageFormat {
        guard let data = self.sd_imageData() else {
            return .Unknown
        }

        var buffer = [UInt8](repeating: 0, count: 1)
        data.copyBytes(to: &buffer, count: 1)

        switch buffer {
        case [0xFF]: return .JPEG
        case [0x89]: return .PNG
        case [0x47]: return .GIF
        case [0x49], [0x4D]: return .TIFF
        case [0x52] where data.count >= 12:
            if let str = String(data: data[0...11], encoding: .ascii), str.hasPrefix("RIFF"), str.hasSuffix("WEBP") {
                return .WebP
            }
        case [0x00] where data.count >= 12:
            if let str = String(data: data[8...11], encoding: .ascii) {
                let HEICBitMaps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                if HEICBitMaps.contains(str) {
                    return .HEIC
                }
                let HEIFBitMaps = Set(["mif1", "msf1"])
                if HEIFBitMaps.contains(str) {
                    return .HEIF
                }
            }
        default:
            break
        }
        return .Unknown
    }

}
