import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui_test/components/bottom_sheet_description.dart';
import 'package:flutter_ui_test/utils/constant.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff13243E),
      appBar: homepageAppBar(),
      bottomNavigationBar: bottomNavBar(context),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          color: bgDefaultColor,
        ),
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Text(
                      "Quality Control IN",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Klik Kotak untuk merubah Kondisi QC",
                      style: TextStyle(
                        color: Color(0xff828C97),
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    rowButtonAllCommand(),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 16.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          return rowItemQuality(context);
                        })
                  ],
                ),
              ),
            ),
            // Positioned(
            //     bottom: 0.0,
            //     left: 0.0,
            //     right: 0.0,
            //     child: bottomNavBar(context))
          ],
        ),
      ),
    );
  }

  AppBar homepageAppBar() {
    return AppBar(
      title: Text("Quality Control"),
      centerTitle: true,
      toolbarHeight: 82.h,
      backgroundColor: Color(0xff13243E),
      leading: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: white.withOpacity(0.1), width: 1.w)),
          padding: EdgeInsets.all(12.43.r),
          // margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: SvgPicture.asset("assets/images/back.svg")),
    );
  }

  Container bottomNavBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 16.h,
        bottom: 40.h,
      ),
      height: 112.h,
      color: white,
      child: buttonBlueDark(text: "Lanjut"),
    );
  }

  Container rowItemQuality(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "System IOS",
                style: textStyle1,
              ),
              GestureDetector(
                  onTap: () {
                    showEditDescription(context);
                  },
                  child: SvgPicture.asset("assets/images/deskripsi 2.svg")),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          rowButtonCommand(),
        ],
      ),
    );
  }

  showEditDescription(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: BottomSheetDescription(),
        );
      },
    );
  }

  Container rowButtonAllCommand() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.5.w, vertical: 14.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000.r), color: white),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerRowItem(
            asset: "assets/images/bad.svg",
            name: "Bad All",
            fontColor: red,
          ),
          headerRowItem(
            asset: "assets/images/skip.svg",
            name: "Skip All",
            fontColor: black,
          ),
          headerRowItem(
            asset: "assets/images/good.svg",
            name: "Good All",
            fontColor: green,
          ),
        ],
      ),
    );
  }

  Container rowButtonCommand() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.5.w, vertical: 14.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000.r), color: bgDefaultColor),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerRowItem(
            asset: "assets/images/bad.svg",
            name: "Bad",
            fontColor: red,
          ),
          headerRowItem(
            asset: "assets/images/skip.svg",
            name: "Skip",
            fontColor: black,
          ),
          headerRowItem(
            asset: "assets/images/good.svg",
            name: "Good",
            fontColor: green,
          ),
        ],
      ),
    );
  }

  Widget headerRowItem(
      {required String asset,
      required String name,
      Color fontColor = Colors.black87}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 25.5.w, vertical: 14.h),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            name,
            style: TextStyle(color: fontColor),
          ),
        ],
      ),
    );
  }
}

Container buttonBlueDark({
  required String text,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  return Container(
    alignment: Alignment.center,
    padding: padding,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r), gradient: gradientBlueDark),
    child: Text(
      text,
      style: textStyle1.copyWith(color: white),
    ),
  );
}
