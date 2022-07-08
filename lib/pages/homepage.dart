import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui_test/components/bottom_sheet_description.dart';
import 'package:flutter_ui_test/cubits/selected_item/selected_item_cubit.dart';
import 'package:flutter_ui_test/utils/constant.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);
  List<SelectedItemCubit> selectedItemCubitList = [];
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
        child: SingleChildScrollView(
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
                      SelectedItemCubit selectedItemCubit = SelectedItemCubit();
                      selectedItemCubitList.add(selectedItemCubit);
                      return BlocProvider(
                        create: (context) => selectedItemCubit,
                        child: rowItemQuality(context),
                      );
                    })
              ],
            ),
          ),
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

  Widget rowButtonAllCommand() {
    return BlocProvider(
      create: (context) => SelectedItemCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<SelectedItemCubit, int>(
          builder: (context, currentIndex) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 25.5.w, vertical: 14.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000.r), color: white),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  qualityItemAllCommand(
                    asset: "assets/images/bad.svg",
                    name: "Bad All",
                    focusColor: red,
                    fontColor: red,
                    currentIndex: currentIndex,
                    index: 0,
                  ),
                  qualityItemAllCommand(
                    asset: "assets/images/skip.svg",
                    name: "Skip All",
                    focusColor: black,
                    fontColor: black,
                    currentIndex: currentIndex,
                    index: 1,
                  ),
                  qualityItemAllCommand(
                    asset: "assets/images/good.svg",
                    name: "Good All",
                    focusColor: green,
                    fontColor: green,
                    currentIndex: currentIndex,
                    index: 2,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget rowButtonCommand() {
    return Builder(builder: (context) {
      return BlocBuilder<SelectedItemCubit, int>(
        builder: (context, currentIndex) {
          print("CURRENTINDEX $currentIndex");
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.5.w, vertical: 14.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000.r),
                color: bgDefaultColor),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                qualityItem(
                  asset: "assets/images/bad.svg",
                  name: "Bad",
                  fontColor: greyTextColor,
                  focusColor: red,
                  currentIndex: currentIndex,
                  index: 0,
                ),
                qualityItem(
                  asset: "assets/images/skip.svg",
                  name: "Skip",
                  fontColor: greyTextColor,
                  focusColor: black,
                  currentIndex: currentIndex,
                  index: 1,
                ),
                qualityItem(
                  asset: "assets/images/good.svg",
                  name: "Good",
                  fontColor: greyTextColor,
                  focusColor: green,
                  currentIndex: currentIndex,
                  index: 2,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget qualityItem(
      {required String asset,
      required String name,
      required int index,
      required int currentIndex,
      required Color focusColor,
      Color fontColor = greyTextColor}) {
    return BlocBuilder<SelectedItemCubit, int>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            print("index $index");
            context.read<SelectedItemCubit>().changeSelectedItem(index);
          },
          child: qualityItemRaw(
            name: name,
            asset: asset,
            index: index,
            focusColor: focusColor,
            currentIndex: currentIndex,
            fontColor: fontColor,
          ),
        );
      },
    );
  }

  Widget qualityItemRaw({
    required String asset,
    required String name,
    required int index,
    required int currentIndex,
    required Color focusColor,
    Color fontColor = Colors.black87,
    bool isAllCommand = false,
  }) {
    return Container(
      color: (currentIndex == index && !isAllCommand)
          ? focusColor
          : Colors.transparent,
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            color: (currentIndex == index && !isAllCommand) ? white : null,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            name,
            style: TextStyle(
                color: (currentIndex == index && !isAllCommand)
                    ? white
                    : fontColor),
          ),
        ],
      ),
    );
  }

  Widget qualityItemAllCommand({
    required String asset,
    required String name,
    required int index,
    required int currentIndex,
    required Color focusColor,
    Color fontColor = Colors.black87,
  }) {
    return BlocBuilder<SelectedItemCubit, int>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            for (SelectedItemCubit selectedItemCubit in selectedItemCubitList) {
              selectedItemCubit.changeSelectedItem(index);
            }
            // context.read<SelectedItemCubit>().c
          },
          child: qualityItemRaw(
            asset: asset,
            name: name,
            index: index,
            currentIndex: currentIndex,
            focusColor: focusColor,
            fontColor: fontColor,
            isAllCommand: true,
          ),
        );
      },
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
