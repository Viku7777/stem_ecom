// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:cattel_feed/Helper/colors.dart';
import 'package:cattel_feed/Helper/textstyle.dart';
import 'package:cattel_feed/backend/dummyData.dart';

import 'package:cattel_feed/controller/item_details_controller/item_view_controller.dart';
import 'package:cattel_feed/model/item_model.dart';
import 'package:cattel_feed/view/screens/homepage/item_details/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemViewTiel extends StatelessWidget {
  ItemModel items;
  bool showMore;
  ItemViewTiel({super.key, required this.items, this.showMore = false});

  @override
  var itemdetailsCotroller = Get.put(ItemDetailsController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ItemModel item = dummyitemList
            .firstWhere((element) => element.itemid == items.itemid);
        itemdetailsCotroller.updateItem(item);
        // Get.to(() => ItemDetailsView());
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemDetailsView(),
        ));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.sp),
                        topRight: Radius.circular(10.sp)),
                    child: Image.network(
                      items.images[0],
                      fit: BoxFit.cover,
                      height: Get.height,
                      width: Get.width,
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    right: 5.w,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child:
                          GetBuilder<ItemListController>(builder: (controller) {
                        bool isFav = controller.allitems
                            .firstWhere(
                                (element) => element.itemid == items.itemid)
                            .isFav;
                        return IconButton(
                            onPressed: () {
                              controller.updateFavItem(
                                items.itemid,
                              );
                            },
                            icon: isFav
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_border),
                            color: AppColors.redColor);
                      }),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    items.productName,
                    style: GetTextTheme.fs14_regular,
                  ),
                  Text(
                    "Free Delivery",
                    style: GetTextTheme.fs10_regular
                        .copyWith(color: const Color(0xffB5B5B5)),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹ ${items.oldprice.toInt()}",
                        style: GetTextTheme.fs18_medium.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: const Color(0xffB5B5B5),
                          fontSize: showMore ? 13.sp : 18.sp,
                        ),
                      ),
                      10.w.widthBox,
                      Text(
                        "₹ ${items.currentprice}",
                        style: GetTextTheme.fs18_bold.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: showMore ? 13.sp : 18.sp),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: showMore ? 8.sp : 11.sp,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          log(rating);
                        },
                      ),
                      5.w.widthBox,
                      Text(
                        "4.2 / 5.0",
                        style: GetTextTheme.fs10_regular,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}