// ignore_for_file: use_build_context_synchronously

import 'package:cattel_feed/Helper/nextscreen.dart';
import 'package:cattel_feed/repository/firebase_repository/firebase_repository.dart';
import 'package:cattel_feed/resource/component/showloading.dart';
import 'package:cattel_feed/view/auth/screens/loginwithNumber.dart';
import 'package:cattel_feed/view_model/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    selectRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: InkWell(
              onTap: () => nextscreenRemove(context, LoginWithNumber.routes),
              child: const Text("Splash Screen")),
        ),
        GetBuilder<SplashController>(
          builder: (controller) {
            if (controller.isloading) {
              return const ShowLoading();
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    ));
  }

  selectRoutes() async {
    var spalashController = Get.find<SplashController>();
    spalashController.getData(context);
  }
}
