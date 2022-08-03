// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news_app/logic/internet_bloc/internet_bloc.dart';
// import 'package:news_app/logic/internet_bloc/internet_state.dart';

// import '../../Domain/enities.dart';
// import '../../logic/news_bloc.dart/news_bloc.dart';
// import '../../logic/news_bloc.dart/news_event.dart';

// class NewsApp extends StatefulWidget {
//   const NewsApp({Key? key}) : super(key: key);

//   @override
//   State<NewsApp> createState() => _NewsAppState();
// }

// class _NewsAppState extends State<NewsApp> with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   int currentIndex = 0;
//   final List<Widget> _tabs = [
//     const Text(
//       "Politics",
//       style: TextStyle(
//         color: Colors.black,
//       ),
//     ),
//     const Text(
//       "Sport",
//       style: TextStyle(
//         color: Colors.black,
//       ),
//     ),
//     const Text(
//       "Bitcoin",
//       style: TextStyle(
//         color: Colors.black,
//       ),
//     ),
//     const Text(
//       "Entertainment",
//       style: TextStyle(
//         color: Colors.black,
//       ),
//     ),
//     const Text(
//       "Finance",
//       style: TextStyle(
//         color: Colors.black,
//       ),
//     ),
//   ];
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: _tabs.length,
//       initialIndex: 0,
//       vsync: this,
//       animationDuration: const Duration(milliseconds: 500),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         actions: const [
//           Icon(
//             Icons.search,
//             color: Colors.black,
//             size: 25,
//           ),
//           SizedBox(
//             width: 25,
//           ),
//           Icon(
//             Icons.notifications_none_rounded,
//             color: Colors.black,
//             size: 25,
//           ),
//           SizedBox(
//             width: 20,
//           ),
//         ],
//         bottom: TabBar(
//           tabs: _tabs,
//           controller: _tabController,
//           isScrollable: true,
//           labelColor: Colors.black,
//           indicatorSize: TabBarIndicatorSize.label,
//           automaticIndicatorColorAdjustment: true,
//           indicatorColor: Colors.black,
//           indicatorWeight: 5,
//           labelPadding: const EdgeInsets.symmetric(
//             vertical: 10,
//             horizontal: 15,
//           ),
//           unselectedLabelColor: Colors.grey,
//           unselectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.normal,
//           ),
//           labelStyle: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 17,
//           ),
//         ),
//         title: const Text(
//           "News",
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: BlocListener<InternetBloc, InternetState>(
//         listener: (context, state) {
//           if (state.status == InternetStatus.disconnected) {
//             // _scaffoldKey.currentState!.showSnackBar(
//             //   const SnackBar(
//             //     content: Text(
//             //       "You're not connected , please check your connection",
//             //     ),
//             //   ),
//             // );
//             ScaffoldMessenger.of(context).clearSnackBars();
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(
//                   "You are not connected, please check ypur connection",
//                 ),
//                 backgroundColor: Colors.red,
//                 duration: Duration(seconds: 2),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           }
//         },
//         child: TabBarView(
//           controller: _tabController,
//           children: const [
//             PoliticsPage(),
//             Sport(),
//             BitCoinPage(),
//             Entertainment(),
//             Finance(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NewsList extends StatefulWidget {
//   final List<NewsEntity> newsList;
//   const NewsList({Key? key, required this.newsList}) : super(key: key);

//   @override
//   State<NewsList> createState() => _NewsListState();
// }

// class _NewsListState extends State<NewsList> {
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();

//     // _scrollController.addListener(() {
//     //   print(_scrollController.position.maxScrollExtent);
//     // });
//   }

//   late ScrollController _scrollController;

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       color: Colors.black,
//       onRefresh: () {
//         NewsBloc<BitCoinPage> bloc = context.read<NewsBloc<BitCoinPage>>();
//         // print(_scrollController.position.pixels);
//         return Future.sync(() {
//           bloc.add(ReloadNewsEvent());
//         });
//       },
//       child: ListView.separated(
//         physics: const AlwaysScrollableScrollPhysics(),
//         controller: _scrollController,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         itemBuilder: (context, index) {
//           return NewsPost(
//             author: widget.newsList[index].author,
//             description: widget.newsList[index].description,
//             imageUrl: widget.newsList[index].imageUrl,
//             title: widget.newsList[index].title,
//           );
//         },
//         itemCount: widget.newsList.length,
//         separatorBuilder: (context, index) => const SizedBox(
//           height: 15,
//         ),
//       ),
//     );
//   }
// }

// class NewsPost extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String author;
//   final String description;
//   const NewsPost({
//     Key? key,
//     required this.author,
//     required this.description,
//     required this.imageUrl,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.grey,
//             offset: Offset(-1, -1),
//             blurRadius: 5,
//           ),
//           BoxShadow(
//             offset: Offset(1, -1),
//             color: Colors.grey,
//             blurRadius: 5,
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           CachedNetworkImage(
//             errorWidget: (context, url, error) {
//               return const Center(
//                 child: Text("Image failed loading"),
//               );
//             },
//             imageUrl: imageUrl,
//             imageBuilder: (context, imageProvider) {
//               return Container(
//                 height: 210,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                   ),
//                   image: DecorationImage(
//                     image: imageProvider,
//                     filterQuality: FilterQuality.high,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//             filterQuality: FilterQuality.high,
//             placeholder: (context, url) {
//               return const SizedBox(
//                 height: 200,
//                 width: double.maxFinite,
//                 child: Center(
//                   child: CircularProgressIndicator.adaptive(),
//                 ),
//               );
//             },
//             fadeInDuration: const Duration(seconds: 1),
//             alignment: Alignment.center,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   description,
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 17,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   maxLines: 2,
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     "~$author",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       overflow: TextOverflow.ellipsis,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PoliticsPage extends StatelessWidget {
//   const PoliticsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class Sport extends StatelessWidget {
//   const Sport({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class Entertainment extends StatelessWidget {
//   const Entertainment({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class Finance extends StatelessWidget {
//   const Finance({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
