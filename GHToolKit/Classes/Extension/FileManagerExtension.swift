//
//  FileManagerExtension.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/8/2.
//

import Foundation

public extension FileManager {
    var gh: GHFileManagerExtension {
        return GHFileManagerExtension(self)
    }

    static var Gh: GHFileManagerExtension.Type {
        return GHFileManagerExtension.self
    }
}

public struct GHFileManagerExtension {
    internal let manger: FileManager
    internal init(_ manger: FileManager) {
        self.manger = manger
    }
}

public extension GHFileManagerExtension {

    /// 单位：MB
    func fileMBSize(_ url: URL) -> Double  {
        return Double(fileSize(url)) / 1000.0 / 1000.0
    }

    /// 单位：Byte
    func fileSize(_ url: URL) -> UInt64  {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: url.path, isDirectory: &isDir)
        if isExists {
            if isDir.boolValue {
                if let enumerator = fileManager.enumerator(atPath: url.path) {
                    for subPath in enumerator {
                        let fullPath = url.path.appending("/\(subPath)")
                        do {
                            let attr = try fileManager.attributesOfItem(atPath: fullPath)
                            size += attr[FileAttributeKey.size] as? UInt64 ?? 0
                        } catch  {
                            print("error :\(error)")
                        }
                    }
                }
            } else {
                do {
                    let attr = try fileManager.attributesOfItem(atPath: url.path)
                    size += attr[FileAttributeKey.size] as? UInt64 ?? 0
                } catch  {
                    print("error :\(error)")
                }
            }
        }
        return size
    }
}
