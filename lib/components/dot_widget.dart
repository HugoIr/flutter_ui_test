import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui_test/utils/constant.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: blackDotColor),
      height: 10.w,
      width: 10.w,
    );
  }
}
