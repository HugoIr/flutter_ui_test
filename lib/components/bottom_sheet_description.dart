import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui_test/pages/homepage.dart';
import 'package:flutter_ui_test/utils/constant.dart';

class BottomSheetDescription extends StatelessWidget {
  const BottomSheetDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 318.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
        color: bgDefaultColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(child: greyPullBar()),
          SizedBox(height: 30.h),
          Text(
            "Keterangan IN",
            style: textStyle1.copyWith(fontSize: 16.sp),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: bgTextInput,
            ),
            padding: EdgeInsets.only(bottom: 40.h),
            child: TextField(
              cursorColor: Colors.black12,
              decoration: InputDecoration(
                hintText: "Tambahan Keterangan QC ",
                hintStyle: TextStyle(color: greyHintTextColor, fontSize: 16.sp),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          buttonBlueDark(
            text: "Simpan",
            padding: EdgeInsets.symmetric(vertical: 17.h),
          )
        ],
      ),
    );
  }

  Container greyPullBar() {
    return Container(
      height: 8.h,
      width: 64.w,
      decoration: BoxDecoration(
          color: white2, borderRadius: BorderRadius.circular(100.r)),
    );
  }
}
