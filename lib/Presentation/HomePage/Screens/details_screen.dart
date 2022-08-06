import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  final String content, title, image, description;
  final int index;
  const DetailsScreen({
    Key? key,
    required this.content,
    required this.title,
    required this.image,
    required this.description,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: index,
              child: CachedNetworkImage(
                imageUrl: image,
                // cacheKey: image,
                imageBuilder: (context, imageProvider) {
                  return Image(
                    image: imageProvider,
                    height: 400.h,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    filterQuality: FilterQuality.high,
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.asset(
                    "assets/Mask.png",
                    height: 400.h,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
                // fadeInCurve: Curves.easeIn,
                // fadeInDuration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                placeholder: (context, url) {
                  return Container(
                    color: const Color.fromARGB(255, 221, 221, 221),
                    height: 400.h,
                    width: double.maxFinite,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.27,
                  letterSpacing: 0.21.w,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Text(
                content,
                style: TextStyle(
                  color: const Color(0xff3c3c43).withOpacity(0.60),
                  fontSize: 15.sp,
                  height: 1.33,
                  letterSpacing: -0.24.w,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
