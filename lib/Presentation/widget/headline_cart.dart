import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadlineCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const HeadlineCard({
    Key? key,
    required this.description,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14.w),
      child: SizedBox(
        width: 250.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: image,
                  cacheKey: "headline",
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const SizedBox.expand(
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                  fadeInCurve: Curves.easeIn,
                  fadeInDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.center,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: 24.h, left: 16.w, right: 16.w, top: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "FOR YOU",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.08.w,
                              height: 1.38,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.27,
                              letterSpacing: 0.35.w,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 11.sp,
                              height: 1.3,
                              // letterSpacing: -0.32.w,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
