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
    internal let manager: FileManager
    internal init(_ manager: FileManager) {
        self.manager = manager
    }
}

public extension GHFileManagerExtension {
    /// 单位：MB
    static func fileMBSize(_ url: URL) -> Double  {
        return Double(fileSize(url)) / 1000.0 / 1000.0
    }

    /// 单位：Byte
    static func fileSize(_ url: URL) -> UInt64  {
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


public extension GHFileManagerExtension {

    func sandboxDocumentURL() -> URL {
        let paths = self.manager.urls(for: .documentDirectory, in: .userDomainMask)
        let dir = paths[0]
        return dir
    }

    func sandboxCacheURL() -> URL {
        let paths = self.manager.urls(for: .cachesDirectory, in: .userDomainMask)
        let dir = paths[0]
        return dir
    }

    func sandboxTmpURL() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }

    func sandboxlibraryURL() -> URL {
        let paths = self.manager.urls(for: .libraryDirectory, in: .userDomainMask)
        let dir = paths[0]
        return dir
    }

    /// 创建路径
    func createDirectoryIfNotExist(dirPath: String, deleteFirstIfExist: Bool = false) throws {
        let dirURL = URL(string: dirPath)
        guard let dirURL = dirURL else { return }
        try createDirectoryIfNotExist(dirURL: dirURL, deleteFirstIfExist: deleteFirstIfExist)
    }

    /// 创建文件夹
    func createDirectoryIfNotExist(dirURL: URL, deleteFirstIfExist: Bool = false) throws {
        if !deleteFirstIfExist && self.manager.fileExists(atPath: dirURL.path) { return }
        try self.deleteFile(fileURL: dirURL)
        try self.manager.createDirectory(atPath: dirURL.path, withIntermediateDirectories: true, attributes: nil)
    }

    /// 查询类型
    enum GetResourceURLsMode {
        case onlyGetFile
        case onlyGetDirectory
    }

    struct FileResourceModel {
        public var creationDate: Date
        public var isDirectory: Bool
        public var fileURL: URL
    }

    /// 获得路径内的文件/文件夹
    func getResourceModels(pathURL: URL,
                           mode: GetResourceURLsMode,
                           options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles, .skipsSubdirectoryDescendants]) throws -> [FileResourceModel] {
        let resourceKeys: [URLResourceKey] = [.isDirectoryKey, .creationDateKey]
        let tmpEnumerator = self.manager.enumerator(at: pathURL,
                                                    includingPropertiesForKeys: resourceKeys,
                                                    options: options,
                                                    errorHandler: nil)
        guard let enumerator = tmpEnumerator else { return [] }

        var resourceURLs: [FileResourceModel] = []
        for case let fileURL as URL in enumerator {
            let resourceValues = try fileURL.resourceValues(forKeys: Set(resourceKeys))
            if let isDirectory = resourceValues.isDirectory,
               let creationDate = resourceValues.creationDate {
                let model = FileResourceModel(creationDate: creationDate, isDirectory: isDirectory, fileURL: fileURL)
                if mode == .onlyGetFile && !isDirectory {
                    resourceURLs.append(model)
                } else if mode == .onlyGetDirectory && isDirectory {
                    resourceURLs.append(model)
                }
            }
        }
        return resourceURLs
    }
    /// 获得路径内的文件/文件夹
    func getResourceURLs(pathURL: URL,
                         mode: GetResourceURLsMode,
                         options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles, .skipsSubdirectoryDescendants]) throws -> [URL] {

        let models = try getResourceModels(pathURL: pathURL, mode: mode, options: options)
        let results = models.sorted { $0.creationDate < $1.creationDate }
        return results.map { $0.fileURL }
    }

    /// 文件删除
    @discardableResult
    func deleteFile(fileURL: URL) throws -> Bool {
        guard self.manager.fileExists(atPath: fileURL.path) else { return false }
        try self.manager.removeItem(at: fileURL)
        return true
    }

    /// 文件移动
    @discardableResult
    func moveFile(atURL: URL, toURL: URL) throws -> Bool {
        guard self.manager.fileExists(atPath: atURL.path) else {
            return false
        }
        try self.deleteFile(fileURL: toURL)
        try self.manager.moveItem(at: atURL, to: toURL)
        return true
    }

    /// 文件拷贝
    @discardableResult
    func copy(atURL: URL, toURL: URL) throws -> Bool {
        if atURL == toURL {
            return true
        }

        guard FileManager.default.fileExists(atPath: atURL.path) else {
            return false
        }

        try self.deleteFile(fileURL: toURL)
        let toDir = toURL.deletingLastPathComponent()
        try createDirectoryIfNotExist(dirURL: toDir)
        try self.manager.copyItem(at: atURL, to: toURL)

        return true
    }

    /// 输出字符串到文件
    func outputTextToFile(fileURL: URL, contentText: String, breakIfExist: Bool = false) throws {

        if breakIfExist && self.manager.fileExists(atPath: fileURL.path) {
            return
        }

        let dir = fileURL.deletingLastPathComponent()
        try createDirectoryIfNotExist(dirURL: dir)
        try contentText.write(to: fileURL, atomically: true, encoding: .utf8)
    }

    /// 输出二进制数据到文件
    func outputDataToFile(fileURL: URL, data: Data, breakIfExist: Bool = false) throws {
        if breakIfExist && self.manager.fileExists(atPath: fileURL.path) {
            return
        }

        let dir = fileURL.deletingLastPathComponent()
        try createDirectoryIfNotExist(dirURL: dir)
        try data.write(to: fileURL)
    }

    /// 输出JSON二进制数据到文件
    func outputJSONDataToFile<T: Encodable>(fileURL: URL, data: T, breakIfExist: Bool = false) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        let jsonData = try encoder.encode(data)
        try outputDataToFile(fileURL: fileURL, data: jsonData, breakIfExist: breakIfExist)
    }
}

public extension GHFileManagerExtension {
    /// 文件属性
    func attributes(path: String) -> [FileAttributeKey: Any]? {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: path)
            return attributes
        } catch {
            return nil
        }
    }

    func creationDate(path: String) -> Date? {
        guard let attributes = attributes(path: path),
              let creationDate = attributes[.creationDate] as? Date else {
            return nil
        }

        return creationDate
    }

    func modificationDate(path: String) -> Date? {
        guard let attributes = attributes(path: path),
              let modificationDate = attributes[.modificationDate] as? Date else {
            return nil
        }
        return modificationDate
    }

    func filesize(path: String) -> UInt64? {
        guard let attributes = attributes(path: path),
              let size = attributes[.size] as? UInt64 else {
            return nil
        }
        return size
    }

}
