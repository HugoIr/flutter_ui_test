import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui_test/components/bottom_sheet_description.dart';
import 'package:flutter_ui_test/components/three_dot_loading.dart';
import 'package:flutter_ui_test/cubits/quality_item/quality_item_cubit.dart';
import 'package:flutter_ui_test/utils/constant.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QualityItemCubit> qualityItemCubitList = [];
  ScrollController _scrollController = ScrollController();
  int maxQualityItemCount = 100;
  int currentQualityItemCount = 10;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        await Future.delayed(Duration(milliseconds: 1500), () {});
        if (currentQualityItemCount <= maxQualityItemCount - 10) {
          setState(() {
            currentQualityItemCount += 10;
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

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
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 24.h, bottom: 75.h),
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
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: currentQualityItemCount,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 16.h,
                      );
                    },
                    itemBuilder: (context, index) {
                      QualityItemCubit qualityItemCubit = QualityItemCubit();
                      qualityItemCubitList.add(qualityItemCubit);
                      return BlocProvider(
                        create: (context) => qualityItemCubit,
                        child: cardItemQuality(context, qualityItemCubit),
                      );
                    }),
                isLoading
                    ? Container(
                        width: 300.w, height: 100.w, child: ThreeDotLoading())
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar homepageAppBar() {
    return AppBar(
      title: Text(
        "Quality Control",
        style: TextStyle(fontSize: 20.sp),
      ),
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
          margin: EdgeInsets.only(left: 10.w),
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
      child: InkWell(
          onTap: () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          },
          child: buttonBlueDark(text: "Lanjut")),
    );
  }

  showEditDescription(
      BuildContext buildContext, QualityItemCubit qualityItemCubit) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: buildContext,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: BottomSheetDescription(qualityItemCubit: qualityItemCubit),
        );
      },
    );
  }

  Widget rowButtonAllCommand() {
    return BlocProvider(
      create: (context) => QualityItemCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<QualityItemCubit, QualityItemState>(
          builder: (context, state) {
            if (state is QualityItemLoaded) {
              return Container(
                padding: EdgeInsets.all(4.w),
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
                      currentIndex: state.index,
                      index: 0,
                    ),
                    qualityItemAllCommand(
                      asset: "assets/images/skip.svg",
                      name: "Skip All",
                      focusColor: black,
                      fontColor: black,
                      currentIndex: state.index,
                      index: 1,
                    ),
                    qualityItemAllCommand(
                      asset: "assets/images/good.svg",
                      name: "Good All",
                      focusColor: green,
                      fontColor: green,
                      currentIndex: state.index,
                      index: 2,
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        );
      }),
    );
  }

  Widget rowButtonCommand() {
    return Builder(builder: (context) {
      return BlocBuilder<QualityItemCubit, QualityItemState>(
        builder: (context, state) {
          if (state is QualityItemLoaded) {
            return Container(
              padding: EdgeInsets.all(4.w),
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
                    currentIndex: state.index,
                    index: 0,
                  ),
                  qualityItem(
                    asset: "assets/images/skip.svg",
                    name: "Skip",
                    fontColor: greyTextColor,
                    focusColor: black,
                    currentIndex: state.index,
                    index: 1,
                  ),
                  qualityItem(
                    asset: "assets/images/good.svg",
                    name: "Good",
                    fontColor: greyTextColor,
                    focusColor: green,
                    currentIndex: state.index,
                    index: 2,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    });
  }

  Container cardItemQuality(
      BuildContext context, QualityItemCubit qualityItemCubit) {
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
              Flexible(
                child: BlocBuilder<QualityItemCubit, QualityItemState>(
                  builder: (context, state) {
                    if (state is QualityItemLoaded) {
                      return Text(
                        "${state.name}",
                        style: textStyle1,
                      );
                    } else {
                      return Text(
                        "System iOS",
                        style: textStyle1,
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                  onTap: () {
                    showEditDescription(context, qualityItemCubit);
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

  Widget qualityItem(
      {required String asset,
      required String name,
      required int index,
      required int currentIndex,
      required Color focusColor,
      Color fontColor = greyTextColor}) {
    return BlocBuilder<QualityItemCubit, QualityItemState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<QualityItemCubit>().changeQualityItemIndex(index);
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000.r),
        color: (currentIndex == index && !isAllCommand)
            ? focusColor
            : Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: isAllCommand ? 21.w : 25.41.w, vertical: 6.h),
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
    return BlocBuilder<QualityItemCubit, QualityItemState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            for (QualityItemCubit qualityItemCubit in qualityItemCubitList) {
              qualityItemCubit.changeQualityItemIndex(index);
            }
            // context.read<QualityItemCubit>().c
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
