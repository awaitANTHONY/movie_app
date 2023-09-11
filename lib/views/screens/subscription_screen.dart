import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import '/controllers/subscription_controller.dart';
import '/utils/helpers.dart';
import '/consts/consts.dart';
import '/controllers/setting_controller.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  SubscriptionController subscriptionController = Get.find();
  SettingController settingController = Get.find();

  IAPItem? product;

  @override
  void initState() {
    super.initState();
    if (subscriptionController.products.isNotEmpty) {
      product = subscriptionController.products[0];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Subscription'),
        actions: [
          Obx(() {
            return !subscriptionController.isloading2.value
                ? TextButton(
                    onPressed: () {
                      subscriptionController.requestRestore();
                    },
                    child: Text(
                      'Restore'.tr,
                      style: AppStyles.heading.copyWith(
                        color: AppColors.text,
                        fontSize: AppSizes.size15,
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.text,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  );
          }),
          const SizedBox(width: 5),
        ],
      ),
      backgroundColor: AppColors.background2,
      body: subscriptionController.products.isNotEmpty
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: Container(
                        height: AppSizes.newSize(100),
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 30,
                          right: 30,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background2,
                        ),
                        child: Column(
                          children: [
                            // Text(
                            //   'Subscription'.tr,
                            //   style: AppStyles.heading.copyWith(
                            //     color: AppColors.text,
                            //     fontSize: AppSizes.newSize(3),
                            //   ),
                            // ),
                            SizedBox(height: AppSizes.newSize(3.5)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 25,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: 0.5,
                                ),
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: product?.localizedPrice,
                                      style: AppStyles.heading.copyWith(
                                        color: AppColors.text.withOpacity(0.8),
                                        fontSize: AppSizes.newSize(4.5),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '/monthly',
                                      style: AppStyles.text.copyWith(
                                        color: AppColors.text.withOpacity(0.7),
                                        fontSize: AppSizes.size16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: AppSizes.newSize(4)),
                            // Text(
                            //   'Start with 1 week free trial'.tr,
                            //   style: AppStyles.heading.copyWith(
                            //     color: AppColors.text.withOpacity(0.8),
                            //     fontSize: AppSizes.size18,
                            //   ),
                            // ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                subscriptionController
                                    .requestPurchase(product!);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Obx(() {
                                  return !subscriptionController.isloading.value
                                      ? Text(
                                          'Subscribe Now'.tr,
                                          style: AppStyles.heading.copyWith(
                                            color: AppColors.text,
                                            fontSize: AppSizes.size20,
                                          ),
                                        )
                                      : const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: AppColors.text2,
                                          ),
                                        );
                                }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (Platform.isAndroid)
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: AppStyles.text.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.8),
                                    fontSize: AppSizes.size15,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text:
                                          'Subscribe to "Remove Ads" through the app and remove ads for one year. If you choose to subscribe, you will be charged a yearly subscription fee according to the billing country of your account. Paynment will be charged to your payment account at the confirmation of purchase. The subsocription fee will be shown in the app before you complete the payment. Your payment account will automatically be charged within 24 hours before the end of the then-current subscription period. Your subscription will automatically renew every year unless auto-renew is turned off at least 24 hours prior to the end of the current period. You can manage your subscriptions and turn off auto-renew by going to your account settings on the Google Play after purchase. Any unused portion of a free trial period will be forfeited when the user purchases a subscription to that publication. By continuing, you agree to our',
                                    ),
                                    TextSpan(
                                      text: ' Privacy',
                                      style: AppStyles.text.copyWith(
                                        color: AppColors.primary,
                                        fontSize: AppSizes.size16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchURL(
                                            'https://ratvnetwork.net/privacy.html',
                                          );
                                        },
                                    ),
                                    const TextSpan(
                                      text: ' and ',
                                    ),
                                    TextSpan(
                                      text: 'Tems of Use.',
                                      style: AppStyles.text.copyWith(
                                        color: AppColors.primary,
                                        fontSize: AppSizes.size16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchURL(
                                            'https://ratvnetwork.net/terms.html',
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              )
                            else
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: AppStyles.text.copyWith(
                                    color: AppColors.text.withOpacity(0.8),
                                    fontSize: AppSizes.size15,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'After subscribing to the package, you will gain access to exclusive premium video content. \n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.size16,
                                      ),
                                    ),
                                    const TextSpan(
                                      text:
                                          'Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user\'s Account Settings after purchase. No cancellation of the current subscription is allowed during active subscription period. Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.',
                                    ),
                                    TextSpan(
                                      text: ' Privacy',
                                      style: AppStyles.text.copyWith(
                                        color: AppColors.primary,
                                        fontSize: AppSizes.size16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchURL(
                                            'https://ratvnetwork.net/privacy.html',
                                          );
                                        },
                                    ),
                                    const TextSpan(
                                      text: ' and ',
                                    ),
                                    TextSpan(
                                      text: 'Tems of Use.',
                                      style: AppStyles.text.copyWith(
                                        color: AppColors.primary,
                                        fontSize: AppSizes.size16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchURL(
                                            'https://ratvnetwork.net/terms.html',
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              color: AppColors.background2,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppSizes.newSize(5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      'No Subscription Packages Found.'.tr,
                      style: AppStyles.heading.copyWith(
                        color: AppColors.text.withOpacity(0.8),
                        fontSize: AppSizes.size18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
