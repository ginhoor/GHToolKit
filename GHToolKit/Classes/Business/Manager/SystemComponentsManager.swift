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
    /// 最近一次显示评分视图的日期
    case lastestRateDisplayDate
}

extension SystemComponentPreference: UserDefaultPreference { }

public class SystemComponentManager: NSObject {
    public static let shared = SystemComponentManager()
    private let networkManager = NetworkReachabilityManager()
    private override init() {}

    public var appStoreID: String = ""
    public var feedbackEmail: String = ""
    public var appIcon: UIImage?

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
        guard SystemComponentPreference.lastestRateDisplayDate.object == nil else {
            completion?(false)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showRate(completion: completion)
        }
    }

    private func showRate(completion: ((Bool) -> Void)? = nil) {
        guard let manager = networkManager, manager.isReachable else {
            completion?(false)
            return
        }
        let request = AF.request("http://apple.com", method: .get) { $0.timeoutInterval = 3 }
        request.response { (response) in
            switch response.result {
            case .success:
                SystemComponentPreference.lastestRateDisplayDate.save(object: Date())
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                    completion?(true)
                    return
                }
                completion?(false)
            case .failure:
                completion?(false)
            }
        }
    }

    func openAppstoreRatePage() {
        UIApplication.shared.gh.openUrl(String(format: rateUrlFormat, appStoreID))
    }

    func openAppstoreSubscriptionPage() {
        UIApplication.shared.gh.openUrl(subscriptionUrlPath)
    }
}

public extension SystemComponentManager {

    /// 分享Appstore链接
    /// - Parameters:
    ///   - vc: 用于展示的ViewController
    ///   - appIconImage: 链接相关的图标，为nil时会使用appIcon的配置
    ///   - eventParams: 自定义事件参数
    func shareApp(vc: UIViewController, appIconImage: UIImage? = nil, eventParams: [String: Any]? = nil) {
        Task.detached {
            var items = [Any]()
            if let url = URL(string: String(format: self.shareUrlPath, self.appStoreID)) {
                items.append(url)
            }
            if let activityVC = self.generateActivityVC(items: items, eventParams: eventParams) {
                Task { @MainActor in
                    vc.present(activityVC, animated: true)
                }
            }
        }
    }

    /// 分享Appstore链接
    /// - Parameters:
    ///   - vc: 用于展示的ViewController
    ///   - items: 分享资源
    ///   - eventParams: 自定义事件参数
    func shareApp(vc: UIViewController, items: [Any]?, eventParams: [String: Any]? = nil) {
        Task.detached {
            if let activityVC = self.generateActivityVC(items: items, eventParams: eventParams) {
                Task { @MainActor in
                    // 加上sourceView避免iPad中崩溃
                    activityVC.popoverPresentationController?.sourceView = vc.view
                    vc.present(activityVC, animated: true)
                }
            }
        }
    }

    @discardableResult
    func generateActivityVC(items: [Any]?, eventParams: [String: Any]? = nil,
                            types: [UIActivity.ActivityType] = [.postToFacebook,
                                                                .postToTwitter,
                                                                .postToWeibo,
                                                                .postToFlickr,
                                                                .postToVimeo,
                                                                .copyToPasteboard],
                            completion: ((_ success: Bool, _ eventParams: [String: Any]?) -> Void)? = nil) -> UIActivityViewController? {
        guard let items = items else { return nil }
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.excludedActivityTypes = types
        vc.completionWithItemsHandler = { (type, complete, _, error) in
            completion?(complete, eventParams)
        }
        return vc
    }
}
