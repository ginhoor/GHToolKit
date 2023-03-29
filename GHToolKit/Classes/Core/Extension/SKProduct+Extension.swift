//
//  SKProduct+Extension.swift
//  GHPurchaseKit
//
//  Created by 大帅 on 2022/11/17.
//

import Foundation
import StoreKit
import GHToolKit

public extension SKProduct {
    /// 检测产品是否有免费试用期
    /// See `SKProductDiscount` class documentation
    var hasFreeTrial: Bool {
        self.introductoryPrice?.price == 0
    }

    /// 转换成**近似**年订阅的价格。可以用来与年订阅价格比较，计算 “ 节省 X%”
    /// 基于 'subscriptionPeriod.unit '，如果不是订阅则为Nil。
    var oneYearApproximateSubscriptionPrice: Double? {
        guard let subscriptionPeriod = self.subscriptionPeriod else { return nil }
        let multiplier: Double
        switch subscriptionPeriod.unit {
        case .day:
            multiplier = 365
        case .week:
            multiplier = 52.1429
        case .month:
            multiplier = 12
        case .year:
            multiplier = 1
        @unknown default:
            return nil
        }
        return multiplier * self.price.doubleValue
    }
}

public extension SKProduct.PeriodUnit {

    func localUnitString() -> String {
        switch self {
        case .day:
            return "day"
        case .week:
            return GHToolKitString.week
        case .month:
            return GHToolKitString.month
        case .year:
            return "year"
        @unknown default:
            return ""
        }
    }
}


extension SKProduct.PeriodUnit: Comparable {



    public static func < (lhs: SKProduct.PeriodUnit, rhs: SKProduct.PeriodUnit) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

public extension Collection where Iterator.Element == SKProduct {
    /// 是否存在月订阅
    var hasMonthlySubscriptions: Bool { return self.contains(where: { $0.subscriptionPeriod?.unit == .month }) }
    /// 是否存在年订阅
    var hasAnnualSubscriptions: Bool { return self.contains(where: { $0.subscriptionPeriod?.unit == .year }) }


    /// 计算 年订阅 与 月订阅 的每年差价
    /// - Returns: 如果 年订阅 或者 月订阅的数量大于 1 ，则返回 0
    func calculatedPotentialDiscount() -> Double {
        let annualSubscriptions = self.filter { $0.subscriptionPeriod?.unit == .year }
        let monthlySubscriptions = self.filter { $0.subscriptionPeriod?.unit == .month && $0.subscriptionPeriod?.numberOfUnits == 1 }

        if annualSubscriptions.count > 1 || monthlySubscriptions.count > 1 { return 0 }
        guard let annualSubscriptionPrice = annualSubscriptions.first?.oneYearApproximateSubscriptionPrice,
              let monthlySubscriptionPrice = monthlySubscriptions.first?.oneYearApproximateSubscriptionPrice else {
            return 0
        }
        return 1 - annualSubscriptionPrice / monthlySubscriptionPrice
    }
}
