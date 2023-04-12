//
//  UIImage+Debug.swift
//  RetouchKit
//
//  Created by 大帅 on 2023/3/27.
//

import Foundation
import UIKit

public extension UIImage {
    func debug_saveImg(filename: String) {
        let url = FileManager.default.axv.sandboxDocumentURL().appendingPathComponent(filename)
        try? self.saveByFormat(destinationURL: url)
        print("[dd] \(filename): \(url)")
    }
}
