// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum GHToolKitString {
  /// Are you sure to delete the project?
  public static let alertDeleteProjectTitle = GHToolKitString.tr("Localizable", "alert_delete_project_title")
  /// Exit without saving
  public static let alertNotSaveProjectActionSubmit = GHToolKitString.tr("Localizable", "alert_not_save_project_action_submit")
  /// Are you sure to exit without saving?
  public static let alertNotSaveProjectMsg = GHToolKitString.tr("Localizable", "alert_not_save_project_msg")
  /// Photo Not Saved
  public static let alertNotSaveProjectTitle = GHToolKitString.tr("Localizable", "alert_not_save_project_title")
  /// Cancel
  public static let cancel = GHToolKitString.tr("Localizable", "cancel")
  /// Continue
  public static let `continue` = GHToolKitString.tr("Localizable", "continue")
  /// Select a photo and let the magic happen
  public static let createTipsSubtitle = GHToolKitString.tr("Localizable", "create_tips_subtitle")
  /// Let’s go!
  public static let createTipsTitle = GHToolKitString.tr("Localizable", "create_tips_title")
  /// Delete
  public static let delete = GHToolKitString.tr("Localizable", "delete")
  /// Dismiss
  public static let dismiss = GHToolKitString.tr("Localizable", "dismiss")
  /// Save Image
  public static let enhanceResultListChannelTitle1 = GHToolKitString.tr("Localizable", "enhance_result_list_channel_title_1")
  /// Share to Instagram
  public static let enhanceResultListChannelTitle2 = GHToolKitString.tr("Localizable", "enhance_result_list_channel_title_2")
  /// More
  public static let enhanceResultListChannelTitle3 = GHToolKitString.tr("Localizable", "enhance_result_list_channel_title_3")
  /// Save Video
  public static let enhanceResultListChannelTitle4 = GHToolKitString.tr("Localizable", "enhance_result_list_channel_title_4")
  /// Result 1
  public static let enhanceResultSegementTitle1 = GHToolKitString.tr("Localizable", "enhance_result_segement_title_1")
  /// Result 2
  public static let enhanceResultSegementTitle2 = GHToolKitString.tr("Localizable", "enhance_result_segement_title_2")
  /// Video
  public static let enhanceResultSegementTitle3 = GHToolKitString.tr("Localizable", "enhance_result_segement_title_3")
  /// Failed
  public static let hudAdRewardFailed = GHToolKitString.tr("Localizable", "hud_ad_reward_failed")
  /// Photo +%@
  public static func hudAdRewardSuccess(_ p1: Any) -> String {
    return GHToolKitString.tr("Localizable", "hud_ad_reward_success", String(describing: p1))
  }
  /// Your design has been saved
  public static let hudCongratulationsSubtitle = GHToolKitString.tr("Localizable", "hud_congratulations_subtitle")
  /// Congratulations！
  public static let hudCongratulationsTitle = GHToolKitString.tr("Localizable", "hud_congratulations_title")
  /// You’re offline, please check out your Internet connection.
  public static let hudErrorOffline = GHToolKitString.tr("Localizable", "hud_error_offline")
  /// Image download failed.
  /// Please try again later.
  public static let hudErrorPhotoDownload = GHToolKitString.tr("Localizable", "hud_error_photo_download")
  /// Please check your internet connection.
  public static let hudErrorSubtitleNetwork = GHToolKitString.tr("Localizable", "hud_error_subtitle_network")
  /// Please try again later.
  public static let hudErrorSubtitleUniversal = GHToolKitString.tr("Localizable", "hud_error_subtitle_universal")
  /// Oops! Image processing failed.
  public static let hudErrorTitle5003 = GHToolKitString.tr("Localizable", "hud_error_title_5003")
  /// Oops! Image download failed.
  public static let hudErrorTitle5004 = GHToolKitString.tr("Localizable", "hud_error_title_5004")
  /// Oops! AI connot recognize your image correctly.
  public static let hudErrorTitle5008 = GHToolKitString.tr("Localizable", "hud_error_title_5008")
  /// Oops! Failed to access the image.
  public static let hudErrorTitleClientUniversal = GHToolKitString.tr("Localizable", "hud_error_title_client_universal")
  /// Oops! Image processing failed.
  public static let hudErrorTitleNetwork = GHToolKitString.tr("Localizable", "hud_error_title_network")
  /// Oops! AI server is a little bit busy now.
  public static let hudErrorTitleServerUniversal = GHToolKitString.tr("Localizable", "hud_error_title_server_universal")
  /// Progress
  public static let hudProgressTitle = GHToolKitString.tr("Localizable", "hud_progress_title")
  /// Welcome to Pixelance!
  public static let launchGuideTitle0 = GHToolKitString.tr("Localizable", "launch_guide_title_0")
  /// Enhance for Better Qualities
  public static let launchGuideTitle1 = GHToolKitString.tr("Localizable", "launch_guide_title_1")
  /// Enhance for Special Moments
  public static let launchGuideTitle2 = GHToolKitString.tr("Localizable", "launch_guide_title_2")
  /// Enhance for Valuable Memories
  public static let launchGuideTitle3 = GHToolKitString.tr("Localizable", "launch_guide_title_3")
  /// Let your memories shine again!
  public static let launchPurchaseUnlockTips = GHToolKitString.tr("Localizable", "launch_purchase_unlock_tips")
  /// Unlock unlimited photo enhancements
  public static let launchPurchaseUnlockTitle = GHToolKitString.tr("Localizable", "launch_purchase_unlock_title")
  /// Monthly
  public static let monthly = GHToolKitString.tr("Localizable", "monthly")
  /// Get More
  public static let more = GHToolKitString.tr("Localizable", "more")
  /// OK
  public static let ok = GHToolKitString.tr("Localizable", "ok")
  /// Please don’t close App or lock your device
  public static let prepareEnhanceSubtitle = GHToolKitString.tr("Localizable", "prepare_enhance_subtitle")
  /// Preparing your image...
  public static let prepareEnhanceTitleStep1 = GHToolKitString.tr("Localizable", "prepare_enhance_title_step1")
  /// All good!
  /// AI is just getting ready...
  public static let prepareEnhanceTitleStep2 = GHToolKitString.tr("Localizable", "prepare_enhance_title_step2")
  /// Hold on a second.
  /// AI is reconstructing the details...
  public static let prepareEnhanceTitleStep3 = GHToolKitString.tr("Localizable", "prepare_enhance_title_step3")
  /// Thank you!
  public static let previewRateFinishTitle = GHToolKitString.tr("Localizable", "preview_rate_finish_title")
  /// Rate the result
  public static let previewRateTitle = GHToolKitString.tr("Localizable", "preview_rate_title")
  /// Save
  public static let previewSaveTitle = GHToolKitString.tr("Localizable", "preview_save_title")
  /// Watch an ad
  public static let previewSaveWithAdTitle = GHToolKitString.tr("Localizable", "preview_save_with_ad_title")
  /// Without ads and limits
  public static let previewSaveWithoutAdsSubtitle = GHToolKitString.tr("Localizable", "preview_save_without_ads_subtitle")
  /// Save without ads
  public static let previewSaveWithoutAdsTitle = GHToolKitString.tr("Localizable", "preview_save_without_ads_title")
  /// Privacy Policy
  public static let privacyPolicy = GHToolKitString.tr("Localizable", "privacy_policy")
  /// Watch a Video to Unlock Once
  public static let purchaseEditLimitedActionAd = GHToolKitString.tr("Localizable", "purchase_edit_limited_action_ad")
  /// Get Unlimited Now
  public static let purchaseEditLimitedActionGo = GHToolKitString.tr("Localizable", "purchase_edit_limited_action_go")
  /// Upgrade to get unlimited photo enhancements.
  public static let purchaseEditLimitedSubtitle = GHToolKitString.tr("Localizable", "purchase_edit_limited_subtitle")
  /// You’re out of edits
  public static let purchaseEditLimitedTitle = GHToolKitString.tr("Localizable", "purchase_edit_limited_title")
  /// Purchase failed, please check your Apple ID settings.
  public static let purchaseFailedTips = GHToolKitString.tr("Localizable", "purchase_failed_tips")
  /// Free
  public static let purchaseFree = GHToolKitString.tr("Localizable", "purchase_free")
  /// %@ days free, then %@
  public static func purchaseFreeFormat(_ p1: Any, _ p2: Any) -> String {
    return GHToolKitString.tr("Localizable", "purchase_free_format", String(describing: p1), String(describing: p2))
  }
  /// month
  public static let purchaseMonth = GHToolKitString.tr("Localizable", "purchase_month")
  /// Succeed in purchase
  public static let purchaseSuccess = GHToolKitString.tr("Localizable", "purchase_success")
  /// Enable free trial
  public static let purchaseTrialSubtitle1 = GHToolKitString.tr("Localizable", "purchase_trial_subtitle1")
  /// Free trial enabled
  public static let purchaseTrialTitle = GHToolKitString.tr("Localizable", "purchase_trial_title")
  /// Not sure yet?
  public static let purchaseTrialTitle1 = GHToolKitString.tr("Localizable", "purchase_trial_title1")
  /// week
  public static let purchaseWeek = GHToolKitString.tr("Localizable", "purchase_week")
  /// Restore
  public static let restore = GHToolKitString.tr("Localizable", "restore")
  /// Failed to restore
  public static let restoreFail = GHToolKitString.tr("Localizable", "restore_fail")
  /// Succeed in restore
  public static let restoreSuccess = GHToolKitString.tr("Localizable", "restore_success")
  /// Done
  public static let settingVcItemDoneTitle = GHToolKitString.tr("Localizable", "setting_vc_item_done_title")
  /// About
  public static let settingVcListAboutTitle = GHToolKitString.tr("Localizable", "setting_vc_list_about_title")
  /// Contact Us
  public static let settingVcListContactUsTitle = GHToolKitString.tr("Localizable", "setting_vc_list_contact_us_title")
  /// Facebook
  public static let settingVcListFacebookTitle = GHToolKitString.tr("Localizable", "setting_vc_list_facebook_title")
  /// Instagram
  public static let settingVcListInstagramTitle = GHToolKitString.tr("Localizable", "setting_vc_list_instagram_title")
  /// Rate
  public static let settingVcListRateTitle = GHToolKitString.tr("Localizable", "setting_vc_list_rate_title")
  /// Share
  public static let settingVcListShareTitle = GHToolKitString.tr("Localizable", "setting_vc_list_share_title")
  /// Social Media
  public static let settingVcListSocialGroupTitle = GHToolKitString.tr("Localizable", "setting_vc_list_social_group_title")
  /// Help & Support
  public static let settingVcListSupportGroupTitle = GHToolKitString.tr("Localizable", "setting_vc_list_support_group_title")
  /// Unlimited photo enhancements
  public static let settingVcListVipTitle = GHToolKitString.tr("Localizable", "setting_vc_list_vip_title")
  /// Setting
  public static let settingVcTitle = GHToolKitString.tr("Localizable", "setting_vc_title")
  /// OK, got it
  public static let submitActionTitle = GHToolKitString.tr("Localizable", "submit_action_title")
  /// Subscription expired
  public static let subscriptionExpired = GHToolKitString.tr("Localizable", "subscription_expired")
  /// Terms of Use
  public static let termsOfUse = GHToolKitString.tr("Localizable", "terms_of_use")
  /// 👏 Portrait, low-resolution and old photos
  public static let tipsVcSubtitle1 = GHToolKitString.tr("Localizable", "tips_vc_subtitle1")
  /// ❌ High resolution, severaly damaged and difficult to recognize the face
  public static let tipsVcSubtitle2 = GHToolKitString.tr("Localizable", "tips_vc_subtitle2")
  /// Tips for Best Results
  public static let tipsVcTitle = GHToolKitString.tr("Localizable", "tips_vc_title")
  /// Out of enhancements
  public static let userTrailBannerNoCountSubtitle = GHToolKitString.tr("Localizable", "user_trail_banner_no_count_subtitle")
  /// Free plan: %@ photos left
  public static func userTrailBannerSubtitle(_ p1: Any) -> String {
    return GHToolKitString.tr("Localizable", "user_trail_banner_subtitle", String(describing: p1))
  }
  /// %@ Photos
  public static func userTrailBannerTitle(_ p1: Any) -> String {
    return GHToolKitString.tr("Localizable", "user_trail_banner_title", String(describing: p1))
  }
  /// Version
  public static let version = GHToolKitString.tr("Localizable", "version")
  /// Weekly
  public static let weekly = GHToolKitString.tr("Localizable", "weekly")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension GHToolKitString {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
