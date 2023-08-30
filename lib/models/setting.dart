class Setting {
  bool? status;
  SettingData? data;

  Setting({this.status, this.data});

  Setting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SettingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SettingData {
  String? appName;
  String? timezone;
  String? language;
  String? mode;
  String? facebook;
  String? instagram;
  String? telegram;
  String? youtube;
  String? description;
  String? enableAds;
  String? adsType;
  String? applicationId;
  String? appopenAdCode;
  String? bannerAdCode;
  String? nativeAdCode;
  String? interstitialAdCode;
  String? interstitialAdClick;
  String? privacyPolicy;
  String? termsConditions;

  SettingData(
      {this.appName,
      this.timezone,
      this.language,
      this.mode,
      this.facebook,
      this.instagram,
      this.telegram,
      this.youtube,
      this.description,
      this.enableAds,
      this.adsType,
      this.applicationId,
      this.appopenAdCode,
      this.bannerAdCode,
      this.nativeAdCode,
      this.interstitialAdCode,
      this.interstitialAdClick,
      this.privacyPolicy,
      this.termsConditions});

  SettingData.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    timezone = json['timezone'];
    language = json['language'];
    mode = json['mode'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    telegram = json['telegram'];
    youtube = json['youtube'];
    description = json['description'];
    enableAds = json['enable_ads'];
    adsType = json['ads_type'];
    applicationId = json['application_id'];
    appopenAdCode = json['appopen_ad_code'];
    bannerAdCode = json['banner_ad_code'];
    nativeAdCode = json['native_ad_code'];
    interstitialAdCode = json['interstitial_ad_code'];
    interstitialAdClick = json['interstitial_ad_click'];
    privacyPolicy = json['privacy_policy'];
    termsConditions = json['terms_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['timezone'] = timezone;
    data['language'] = language;
    data['mode'] = mode;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['telegram'] = telegram;
    data['youtube'] = youtube;
    data['description'] = description;
    data['enable_ads'] = enableAds;
    data['ads_type'] = adsType;
    data['application_id'] = applicationId;
    data['appopen_ad_code'] = appopenAdCode;
    data['banner_ad_code'] = bannerAdCode;
    data['native_ad_code'] = nativeAdCode;
    data['interstitial_ad_code'] = interstitialAdCode;
    data['interstitial_ad_click'] = interstitialAdClick;
    data['privacy_policy'] = privacyPolicy;
    data['terms_conditions'] = termsConditions;
    return data;
  }
}
