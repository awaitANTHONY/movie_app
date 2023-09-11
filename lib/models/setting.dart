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
  String? privacyPolicy;
  String? termsConditions;
  String? facebook;
  String? instagram;
  String? telegram;
  String? youtube;
  String? radioStreamUrl;
  String? radioTitle;
  String? radioTrack;
  String? radioCover;
  String? radioAboutUs;
  String? radioAboutImage;
  String? enableAds;
  String? adsType;
  String? applicationId;
  String? appopenAdCode;
  String? bannerAdCode;
  String? nativeAdCode;
  String? interstitialAdCode;
  String? interstitialAdClick;
  String? notificationType;
  String? enableDownload;

  SettingData(
      {this.appName,
      this.timezone,
      this.language,
      this.mode,
      this.privacyPolicy,
      this.termsConditions,
      this.facebook,
      this.instagram,
      this.telegram,
      this.youtube,
      this.radioStreamUrl,
      this.radioTitle,
      this.radioTrack,
      this.radioCover,
      this.radioAboutUs,
      this.radioAboutImage,
      this.enableAds,
      this.adsType,
      this.applicationId,
      this.appopenAdCode,
      this.bannerAdCode,
      this.nativeAdCode,
      this.interstitialAdCode,
      this.interstitialAdClick,
      this.notificationType,
      this.enableDownload});

  SettingData.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    timezone = json['timezone'];
    language = json['language'];
    mode = json['mode'];
    privacyPolicy = json['privacy_policy'];
    termsConditions = json['terms_conditions'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    telegram = json['telegram'];
    youtube = json['youtube'];
    radioStreamUrl = json['radio_stream_url'];
    radioTitle = json['radio_title'];
    radioTrack = json['radio_track'];
    radioCover = json['radio_cover'];
    radioAboutUs = json['radio_about_us'];
    radioAboutImage = json['radio_about_image'];
    enableAds = json['enable_ads'];
    adsType = json['ads_type'];
    applicationId = json['application_id'];
    appopenAdCode = json['appopen_ad_code'];
    bannerAdCode = json['banner_ad_code'];
    nativeAdCode = json['native_ad_code'];
    interstitialAdCode = json['interstitial_ad_code'];
    interstitialAdClick = json['interstitial_ad_click'];
    notificationType = json['notification_type'];
    enableDownload = json['enable_download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['timezone'] = timezone;
    data['language'] = language;
    data['mode'] = mode;
    data['privacy_policy'] = privacyPolicy;
    data['terms_conditions'] = termsConditions;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['telegram'] = telegram;
    data['youtube'] = youtube;
    data['radio_stream_url'] = radioStreamUrl;
    data['radio_title'] = radioTitle;
    data['radio_track'] = radioTrack;
    data['radio_cover'] = radioCover;
    data['radio_about_us'] = radioAboutUs;
    data['radio_about_image'] = radioAboutImage;
    data['enable_ads'] = enableAds;
    data['ads_type'] = adsType;
    data['application_id'] = applicationId;
    data['appopen_ad_code'] = appopenAdCode;
    data['banner_ad_code'] = bannerAdCode;
    data['native_ad_code'] = nativeAdCode;
    data['interstitial_ad_code'] = interstitialAdCode;
    data['interstitial_ad_click'] = interstitialAdClick;
    data['notification_type'] = notificationType;
    data['enable_download'] = enableDownload;
    return data;
  }
}
