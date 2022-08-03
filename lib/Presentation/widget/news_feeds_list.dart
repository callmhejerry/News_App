import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Domain/enities.dart';
import 'headline_cart.dart';
import 'trending_card.dart';
import './title.dart';

class NewsFeedList extends StatelessWidget {
  final List<HeadLineEntity> headlineList;
  final List<NewsEntity> allNewsList;
  const NewsFeedList({
    Key? key,
    required this.allNewsList,
    required this.headlineList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.h,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 16.w),
          sliver: const SliverToBoxAdapter(
            child: NewsTitle(title: "Headlines"),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 366.h,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: headlineList.length,
              itemBuilder: (context, index) {
                return HeadlineCard(
                  description: headlineList[index].description,
                  image: headlineList[index].urlToImage,
                  title: headlineList[index].title,
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.h,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 16.w),
          sliver: const SliverToBoxAdapter(
            child: NewsTitle(title: "Trending"),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TreandingCard(
                  description: allNewsList[index].description,
                  image: allNewsList[index].imageUrl,
                  title: allNewsList[index].title,
                );
              },
              childCount: allNewsList.length,
            ),
          ),
        )
      ],
    );
  }
}
