// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum GHToolKitString {
    /// Are you sure to delete the project?
    public static let alertDeleteProjectTitle = GHToolKitString.tr("Localizable", "alert_delete_project_title", fallback: "Are you sure to delete the project?")
    /// Exit without saving
    public static let alertNotSaveProjectActionSubmit = GHToolKitString.tr("Localizable", "alert_not_save_project_action_submit", fallback: "Exit without saving")
    /// Are you sure to exit without saving?
    public static let alertNotSaveProjectMsg = GHToolKitString.tr("Localizable", "alert_not_save_project_msg", fallback: "Are you sure to exit without saving?")
    /// Photo Not Saved
    public static let alertNotSaveProjectTitle = GHToolKitString.tr("Localizable", "alert_not_save_project_title", fallback: "Photo Not Saved")
    /// Annually
    public static let annually = GHToolKitString.tr("Localizable", "annually", fallback: "Annually")
    /// Cancel
    public static let cancel = GHToolKitString.tr("Localizable", "cancel", fallback: "Cancel")
    /// Continue
    public static let `continue` = GHToolKitString.tr("Localizable", "continue", fallback: "Continue")
    /// Try Free and Subscribe
    public static let tryFreeAndSubscribe = GHToolKitString.tr("Localizable", "try_free_and_subscribe", fallback: "Try Free and Subscribe")
    /// Delete
    public static let delete = GHToolKitString.tr("Localizable", "delete", fallback: "Delete")
    /// Dismiss
    public static let dismiss = GHToolKitString.tr("Localizable", "dismiss", fallback: "Dismiss")
    /// Photo has been saved
    public static let hudCongratulationsSubtitle = GHToolKitString.tr("Localizable", "hud_congratulations_subtitle", fallback: "Photo has been saved")
    /// Congratulations！
    public static let hudCongratulationsTitle = GHToolKitString.tr("Localizable", "hud_congratulations_title", fallback: "Congratulations！")
    /// You’re offline, please check out your Internet connection.
    public static let hudErrorOffline = GHToolKitString.tr("Localizable", "hud_error_offline", fallback: "You’re offline, please check out your Internet connection.")
    /// Image download failed.
    /// Please try again later.
    public static let hudErrorPhotoDownload = GHToolKitString.tr("Localizable", "hud_error_photo_download", fallback: "Image download failed.\nPlease try again later.")
    /// Oops! Image processing failed.
    public static let hudErrorTitleNetwork = GHToolKitString.tr("Localizable", "hud_error_title_network", fallback: "Oops! Image processing failed.")
    /// Please check your internet connection.
    public static let hudErrorSubtitleNetwork = GHToolKitString.tr("Localizable", "hud_error_subtitle_network", fallback: "Please check your internet connection.")
    /// Please try again later.
    public static let hudErrorSubtitleUniversal = GHToolKitString.tr("Localizable", "hud_error_subtitle_universal", fallback: "Please try again later.")
    /// Oops! Failed to access the image.
    public static let hudErrorTitleClientUniversal = GHToolKitString.tr("Localizable", "hud_error_title_client_universal", fallback: "Oops! Failed to access the image.")
    /// Oops! AI server is a little bit busy now.
    public static let hudErrorTitleServerUniversal = GHToolKitString.tr("Localizable", "hud_error_title_server_universal", fallback: "Oops! AI server is a little bit busy now.")
    /// Progress
    public static let hudProgressTitle = GHToolKitString.tr("Localizable", "hud_progress_title", fallback: "Progress")
    /// Lifetime
    public static let lifetime = GHToolKitString.tr("Localizable", "lifetime", fallback: "Lifetime")
    /// month
    public static let month = GHToolKitString.tr("Localizable", "month", fallback: "month")
    /// Monthly
    public static let monthly = GHToolKitString.tr("Localizable", "monthly", fallback: "Monthly")
    /// More
    public static let more = GHToolKitString.tr("Localizable", "more", fallback: "More")
    /// OK
    public static let ok = GHToolKitString.tr("Localizable", "ok", fallback: "OK")
    /// Premium
    public static let premiumTitle = GHToolKitString.tr("Localizable", "premium_title", fallback: "Premium")
    /// Privacy Policy
    public static let privacyPolicy = GHToolKitString.tr("Localizable", "privacy_policy", fallback: "Privacy Policy")
    /// Purchase failed, please check your Apple ID settings.
    public static let purchaseFailedTips = GHToolKitString.tr("Localizable", "purchase_failed_tips", fallback: "Purchase failed, please check your Apple ID settings.")
    /// %@ days free, then %@
    public static func purchaseFreeFormat(_ p1: Any, _ p2: Any) -> String {
        return GHToolKitString.tr("Localizable", "purchase_free_format", String(describing: p1), String(describing: p2), fallback: "%@ days free, then %@")
    }
    /// Succeed in purchase
    public static let purchaseSuccess = GHToolKitString.tr("Localizable", "purchase_success", fallback: "Succeed in purchase")
    /// Restore
    public static let restore = GHToolKitString.tr("Localizable", "restore", fallback: "Restore")
    /// Failed to restore
    public static let restoreFail = GHToolKitString.tr("Localizable", "restore_fail", fallback: "Failed to restore")
    /// Succeed in restore
    public static let restoreSuccess = GHToolKitString.tr("Localizable", "restore_success", fallback: "Succeed in restore")
    /// Done
    public static let settingVcItemDoneTitle = GHToolKitString.tr("Localizable", "setting_vc_item_done_title", fallback: "Done")
    /// About
    public static let settingVcListAboutTitle = GHToolKitString.tr("Localizable", "setting_vc_list_about_title", fallback: "About")
    /// Contact Us
    public static let settingVcListContactUsTitle = GHToolKitString.tr("Localizable", "setting_vc_list_contact_us_title", fallback: "Contact Us")
    /// Rate
    public static let settingVcListRateTitle = GHToolKitString.tr("Localizable", "setting_vc_list_rate_title", fallback: "Rate")
    /// Share
    public static let settingVcListShareTitle = GHToolKitString.tr("Localizable", "setting_vc_list_share_title", fallback: "Share")
    /// Setting
    public static let settingVcTitle = GHToolKitString.tr("Localizable", "setting_vc_title", fallback: "Setting")
    /// Subscription expired
    public static let subscriptionExpired = GHToolKitString.tr("Localizable", "subscription_expired", fallback: "Subscription expired")
    /// Terms of Use
    public static let termsOfUse = GHToolKitString.tr("Localizable", "terms_of_use", fallback: "Terms of Use")
    /// Version
    public static let version = GHToolKitString.tr("Localizable", "version", fallback: "Version")
    /// week
    public static let week = GHToolKitString.tr("Localizable", "week", fallback: "week")
    /// Weekly
    public static let weekly = GHToolKitString.tr("Localizable", "weekly", fallback: "Weekly")
    /// year
    public static let year = GHToolKitString.tr("Localizable", "year", fallback: "year")
    /// Thanks for the feedback!
    public static let thanksForFeedback = GHToolKitString.tr("Localizable", "thanks_for_feedback", fallback: "Thanks for the feedback!")
    /// Email service is incorrect, please check your email account in Settings.
    public static let emailSettingIsWrongTips = GHToolKitString.tr("Localizable", "email_setting_is_wrong_tips", fallback: "Email service is incorrect, please check your email account in Settings.")
    /// Save Photo
    public static let savePhotoTitle = GHToolKitString.tr("Localizable", "save_photo_title", fallback: "Save Photo")
    /// Original
    public static let original = GHToolKitString.tr("Localizable", "original", fallback: "Original")
    /// Freeform
    public static let freeform = GHToolKitString.tr("Localizable", "freeform", fallback: "Freeform")
    /// Square
    public static let square = GHToolKitString.tr("Localizable", "square", fallback: "Square")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details
extension GHToolKitString {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }

}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    let path = Bundle(for: BundleToken.self).path(forResource: "language", ofType: "bundle") ?? ""
    let bundle = Bundle(path: path) ?? Bundle(for: BundleToken.self)
    return bundle
  }()
}
// swiftlint:enable convenience_type
