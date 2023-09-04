// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '/consts/consts.dart';
// import '/models/channel.dart';
// import '/services/ads_service.dart';
// import '/utils/helpers.dart';
// import '/views/screens/channel_details_screen.dart';

// import 'custom_clipper_widget.dart';
// import 'favourite_widget.dart';

// class ChannelWidget extends StatelessWidget {
//   const ChannelWidget({
//     super.key,
//     required this.item,
//     this.isLast = false,
//     this.isBorderShow = true,
//   });

//   final ChannelData item;
//   final bool isLast;
//   final bool isBorderShow;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         AdsService.showInterstitialAd(() {
//           Get.to(() => ChannelDetailsScreen(item));
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: isBorderShow
//               ? Border(
//                   top: BorderSide(
//                     color: AppColors.border,
//                     width: 0.5,
//                   ),
//                   bottom: isLast
//                       ? BorderSide(
//                           color: AppColors.border,
//                           width: 0.5,
//                         )
//                       : BorderSide.none,
//                 )
//               : null,
//         ),
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Expanded(
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 4,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(10),
//                         bottomLeft: Radius.circular(10),
//                       ),
//                       child: ClipPath(
//                         clipper: CustomClipperWidget(),
//                         child: cachedNetworkImage(
//                           item.image!,
//                           width: double.infinity,
//                           height: AppSizes.newSize(11),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                   10.0.spaceX,
//                   Expanded(
//                     flex: 7,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.name!,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: AppSizes.size16,
//                             color:
//                                 Theme.of(context).textTheme.bodyLarge!.color!,
//                             height: 1,
//                           ),
//                           textAlign: TextAlign.left,
//                           maxLines: 1,
//                         ),
//                         Text(
//                           item.categoryName!,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: AppSizes.size14,
//                             color: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .color!
//                                 .withOpacity(.7),
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                         3.0.spaceY,
//                         Text(
//                           removeAllHtmlTags(item.description!),
//                           style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: AppSizes.size12,
//                             color: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .color!
//                                 .withOpacity(.6),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           textAlign: TextAlign.justify,
//                           maxLines: 2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             15.0.spaceX,
//             Align(
//               alignment: Alignment.topLeft,
//               child: FavouriteWidget(item: item),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
