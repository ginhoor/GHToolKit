//
//  AsyncTaskInfo.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/11/23.
//

import Foundation

public class AsyncTaskInfo {
    public var running: Bool = false
    public var currentRetryCount: Int = 0
    public var retryMaxCount: Int = 3
    public var syncQueue = DispatchQueue(label: "\(type(of: AsyncTaskInfo.self))-sync-\(UUID().uuidString)")
    public init() { }
}

public extension AsyncTaskInfo {
    func begin() { running = true }
    func end() { running = false }
    func continueRetry() -> Bool {
        if currentRetryCount < retryMaxCount {
            currentRetryCount += 1
            return true
        } else {
            currentRetryCount = 0
            end()
            return false
        }
    }
}
