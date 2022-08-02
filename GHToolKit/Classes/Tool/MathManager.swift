//
//  MathManager.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/8/2.
//

import Foundation

public class MathManager {
    public static let shared = MathManager()
    private init() {}
}

public extension MathManager {
    /// 处理小数点
    /// - Parameters:
    ///   - pointPosition: 小数点后保留几位，默认不处理
    static func formatDouble(_ value: Double ,_ pointPosition: Int) -> Double  {
        guard pointPosition > 0 else {
            return value
        }
        var p = 10
        for _ in 0 ..< pointPosition-1 {
            p *= 10
        }
        let result: Int = Int(ceil(value * Double(p)))
        return Double(result) / Double(p)
    }
}
