import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../HomePage/Screens/details_screen.dart';

class TreandingCard extends StatelessWidget {
  final String image;
  final String description;
  final String title;
  final String content;
  final int index;
  const TreandingCard({
    Key? key,
    required this.description,
    required this.image,
    required this.title,
    required this.content,
    required this.index,
  }) : super(key: key);

  void toDetailsScreens(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsScreen(
          description: description,
          image: image,
          title: title,
          content: content,
          index: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toDetailsScreens(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13.r),
              child: Hero(
                tag: index,
                child: CachedNetworkImage(
                  imageUrl: image,
                  // cacheKey: image,
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      height: 100.r,
                      fit: BoxFit.cover,
                      width: 100.r,
                      filterQuality: FilterQuality.high,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "assets/Mask.png",
                      height: 100.r,
                      fit: BoxFit.cover,
                      width: 100.r,
                    );
                  },
                  fadeInCurve: Curves.easeIn,
                  fadeInDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.center,
                  placeholder: (context, url) {
                    return Container(
                      color: const Color.fromARGB(255, 221, 221, 221),
                      height: 100.r,
                      width: 100.r,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.27,
                      letterSpacing: 0.21.w,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: const Color(0xff3c3c43).withOpacity(0.60),
                      fontSize: 12.sp,
                      height: 1.33,
                      letterSpacing: -0.24.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
