import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsTitle extends StatelessWidget {
  final String title;
  const NewsTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(bottom: 12.h),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
      ),
    );
  }
}
