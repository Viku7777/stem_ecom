import 'package:cattel_feed/Helper/colors.dart';
import 'package:cattel_feed/Helper/nextscreen.dart';
import 'package:cattel_feed/Helper/textstyle.dart';
import 'package:cattel_feed/helper/icon.dart';
import 'package:cattel_feed/resource/component/appbar_component.dart';
import 'package:cattel_feed/resource/component/custom_text.dart';
import 'package:cattel_feed/resource/component/icon_with_gradinet.dart';
import 'package:cattel_feed/view/screens/account_setting/app_settings/app_settings_view.dart';
import 'package:cattel_feed/view/screens/account_setting/app_settings/edit_profile/user_profile_setting.dart';
import 'package:cattel_feed/view/screens/account_setting/help_centre/help_view.dart';
import 'package:cattel_feed/view/screens/account_setting/my_favorites/favorites.dart';
import 'package:cattel_feed/view/screens/account_setting/my_orders/my_order_view.dart';
import 'package:cattel_feed/view/screens/account_setting/privacy_policy/privacy_policy_view.dart';
import 'package:cattel_feed/view/screens/account_setting/refer_earn/refer_earn_view.dart';
import 'package:cattel_feed/view/auth/screens/loginwithNumber.dart';
import 'package:cattel_feed/view_model/controller/logged_in_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountHomeView extends StatefulWidget {
  static String routes = "/account_&_settings";
  const AccountHomeView({super.key});

  @override
  State<AccountHomeView> createState() => _AccountHomeViewState();
}

class _AccountHomeViewState extends State<AccountHomeView> {
  List screens = [
    {
      "icon": Icons.favorite_border_outlined,
      "name": "My Favorites",
      "route": FavoritesItemView.routes,
    },
    {
      "icon": Icons.shopping_cart_outlined,
      "name": "My Orders",
      "route": MyOrderView.routes,
    },
    {
      "icon": Icons.currency_rupee_outlined,
      "name": "Refer & Earn",
      "route": ReferEarnView.routes,
    },
    {
      "icon": Icons.settings_outlined,
      "name": "App Settings",
      "route": AppSettingView.routes,
    },
    {
      "icon": Icons.privacy_tip_outlined,
      "name": "Privacy Policy",
      "route": PrivacyPolicyView.routes,
    },
    {
      "icon": Icons.star,
      "name": "Rate us",
      "route": "",
    },
    {
      "icon": Icons.help_outline_sharp,
      "name": "Help Centre",
      "route": HelpView.routes,
    },
  ];
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoggedInUserController>();
    bool loggedInUserInfo =
        controller.userModel.toString().isNotEmptyAndNotNull;
    return Scaffold(
      appBar: customAppbar("Account & settings", isActionButtonShow: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (loggedInUserInfo) {
                  nextscreen(context, UserProfileSettingView.routes);
                } else {
                  nextscreenRemove(context, LoginWithNumber.routes);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                color: AppColors.greythinColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000.sp),
                      child: loggedInUserInfo &&
                              controller.userModel!.image
                                  .toString()
                                  .isNotEmptyAndNotNull
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(1000.sp),
                              child: Image.network(
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                                controller.userModel!.image.toString(),
                                fit: BoxFit.cover,
                                height: 55.sp,
                                width: 55.sp,
                              ),
                            )
                          : Image.asset(
                              IconsClass.personIcon,
                              fit: BoxFit.cover,
                              height: 55.sp,
                              width: 55.sp,
                            ),
                    ),
                    10.w.widthBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customtextWithGradentColor(
                            loggedInUserInfo
                                ? controller.userModel!.name
                                : "Sign In / Sign Up",
                            GetTextTheme.fs16_bold),
                        5.h.heightBox,
                        customText(
                            loggedInUserInfo
                                ? controller.userModel!.bio.toString()
                                : "Sign in to view and update your profile and preferences",
                            GetTextTheme.fs10_regular,
                            maxline: 1)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1.5),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: screens.length,
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1.5),
              itemBuilder: (context, index) => ListTile(
                onTap: () => !loggedInUserInfo
                    ? nextscreenRemove(context, LoginWithNumber.routes)
                    : nextscreen(context, screens[index]["route"]),
                leading: customIconWithGradient(screens[index]["icon"]),
                title: Text(
                  screens[index]["name"],
                  style: GetTextTheme.fs16_regular,
                ),
              ),
            ),
            10.h.heightBox,
            Column(
              children: [
                Text("Designed and Developed by",
                    style: GetTextTheme.fs10_regular),
                3.h.heightBox,
                Image.asset(
                  "assets/icon/hexaLogo.png",
                  height: 23.h,
                  width: 90.w,
                ),
                35.h.heightBox,
              ],
            )
          ],
        ),
      ),
    );
  }
}
