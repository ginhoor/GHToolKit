//
//  SystemComponentsManager.swift
//  RetouchKit
//
//  Created by 大帅 on 2022/7/19.
//

import Foundation
import MessageUI
//import GHViewKit
import AXVToolKit
//import GHToolKit
import Alamofire
import StoreKit

public enum SystemComponentPreference: String {

    /// 最近一次 请求应用内评分
    case latestReqeustRateDisplayDate
    /// 最近一次 显示应用内评分
    case latestRateDisplayDate
    /// 最近一次 请求App Store评论
    case latestReqeustOpenAppstoreRatePageDate
    /// 最近一次 打开App Store评论
    case latestOpenAppstoreRatePageDate
}

extension SystemComponentPreference: UserDefaultPreference { }

public class SystemComponentManager: NSObject {
    public static let shared = SystemComponentManager()
    private let networkManager = NetworkReachabilityManager()
    private override init() {}

    public var appStoreID: String = ""
    public var feedbackEmail: String = ""
    public var appIcon: UIImage?

    public var reqeustRateDisplayInterval: TimeInterval = 24 * 60 * 60 * 1000
    public var showRateDisplayInterval: TimeInterval = 7 * 24 * 60 * 60 * 1000

    public var reqeustOpenAppstoreRatePageInterval: TimeInterval = 24 * 60 * 60 * 1000
    public var openAppstoreRatePageInterval: TimeInterval = 15 * 24 * 60 * 60 * 1000

    public let rateUrlFormat: String = "itms-apps://itunes.apple.com/app/id%@?mt=8&action=write-review"
    public let subscriptionUrlPath: String = "https://apps.apple.com/account/subscriptions"
    // 可追溯来源: "https://itunes.apple.com/app/apple-store/id994788581?pt=118483256&ct=share&mt=8"
    public let shareUrlPath: String = "https://itunes.apple.com/app/id%@"
}

public extension SystemComponentManager {

    func sendFeedbackMail(vc: UIViewController) {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController(title: GHToolKitString.emailSettingIsWrongTips, message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: GHToolKitString.ok, style: .default, handler: { action in
                UIApplication.shared.gh.openEmailSetting()
            }))
            vc.present(alert, animated: true, completion: nil)
            return
        }
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([feedbackEmail])
        let body = "\n\n\n\n\n\nFrom:\n" +
        "\(AppInfo.bundleID)(\(AppInfo.appVersion))\n" +
        "\(UIDevice.Gh.type)(\(UIDevice.current.systemVersion))\n" +
        "\(Locale.preferredLanguages.first ?? ""))\n"

        mailVC.setMessageBody(body, isHTML: false)
        mailVC.modalPresentationStyle = .fullScreen
        vc.present(mailVC, animated: true, completion: nil)
    }
}

extension SystemComponentManager: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if result == .sent {
                let alert = UIAlertController(title: GHToolKitString.thanksForFeedback, message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: GHToolKitString.ok, style: .default, handler: { action in }))
                UIViewController.Axv.currentViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

public extension SystemComponentManager {

    func showRateAlert(completion: ((Bool) -> Void)? = nil) {
        let now = Date.now.timeIntervalSince1970
        if let reqDate = SystemComponentPreference.latestReqeustRateDisplayDate.object as? Date,
           now - reqDate.timeIntervalSince1970 <= reqeustRateDisplayInterval {
            DispatchQueue.main.async {
                completion?(false)
            }
            return
        }

        SystemComponentPreference.latestReqeustRateDisplayDate.save(object: Date())
        if let actionDate = SystemComponentPreference.latestRateDisplayDate.object as? Date,
           now - actionDate.timeIntervalSince1970 <= showRateDisplayInterval {
            DispatchQueue.main.async {
                completion?(false)
            }
            return
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.checkNetwork { success in
                guard success else {
                    completion?(false)
                    return
                }
                SystemComponentPreference.latestRateDisplayDate.save(object: Date())
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                    completion?(true)
                    return
                }
                completion?(false)
            }
        }
    }


    func openAppstoreRatePage(intervalOfHours: Int = 24 * 15, completion: ((Bool) -> Void)? = nil) {
        let now = Date.now.timeIntervalSince1970
        if let reqDate = SystemComponentPreference.latestReqeustOpenAppstoreRatePageDate.object as? Date,
           now - reqDate.timeIntervalSince1970 <= reqeustOpenAppstoreRatePageInterval {
            DispatchQueue.main.async {
                completion?(false)
            }
            return
        }

        SystemComponentPreference.latestReqeustOpenAppstoreRatePageDate.save(object: Date())
        if let actionDate = SystemComponentPreference.latestOpenAppstoreRatePageDate.object as? Date,
           now - actionDate.timeIntervalSince1970 <= openAppstoreRatePageInterval {
            DispatchQueue.main.async {
                completion?(false)
            }
            return
        }

        checkNetwork { [weak self] success in
            guard let self = self else { return }
            guard success else {
                completion?(false)
                return
            }
            SystemComponentPreference.latestOpenAppstoreRatePageDate.save(object: Date())
            UIApplication.shared.gh.openUrl(String(format: self.rateUrlFormat, self.appStoreID), completion: completion)
        }
    }

    func openAppstoreSubscriptionPage() {
        UIApplication.shared.gh.openUrl(subscriptionUrlPath)
    }

    private func checkNetwork(completion: @escaping (Bool) -> Void) {
        guard let manager = networkManager, manager.isReachable else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        let request = AF.request("http://apple.com", method: .options) { $0.timeoutInterval = 3 }
        request.response { (response) in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }

}

public extension SystemComponentManager {

    /// 分享Appstore链接
    /// - Parameters:
    ///   - vc: 用于展示的ViewController
    ///   - appIconImage: 链接相关的图标，为nil时会使用appIcon的配置
    ///   - eventParams: 自定义事件参数
    func shareApp(from: UIViewController, eventParams: [String: Any]? = nil) {
        Task { @MainActor in
            var items = [Any]()
            if let url = URL(string: String(format: self.shareUrlPath, self.appStoreID)) {
                items.append(url)
            }
            if let activityVC = self.generateActivityVC(from: from, items: items, eventParams: eventParams) {
                Task { @MainActor in
                    from.present(activityVC, animated: true)
                }
            }
        }
    }

    /// 分享更多
    /// - Parameters:
    ///   - vc: 用于展示的ViewController
    ///   - items: 分享资源
    ///   - eventParams: 自定义事件参数
    func shareMore(from: UIViewController, items: [Any]?, eventParams: [String: Any]? = nil) {
        Task { @MainActor in
            if let activityVC = self.generateActivityVC(from: from, items: items, eventParams: eventParams) {
                Task { @MainActor in
                    from.present(activityVC, animated: true)
                }
            }
        }
    }

    @discardableResult
    func generateActivityVC(from: UIViewController, items: [Any]?, eventParams: [String: Any]? = nil,
                            types: [UIActivity.ActivityType] = [.postToFacebook,
                                                                .postToTwitter,
                                                                .postToWeibo,
                                                                .postToFlickr,
                                                                .postToVimeo,
                                                                .copyToPasteboard],
                            completion: ((_ success: Bool, _ eventParams: [String: Any]?) -> Void)? = nil) -> UIActivityViewController? {
        guard let items = items else { return nil }

        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = from.view
        vc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height, width: 0, height: 0)
        vc.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        vc.excludedActivityTypes = types
        vc.completionWithItemsHandler = { (type, complete, _, error) in
            completion?(complete, eventParams)
        }
        return vc
    }
}
