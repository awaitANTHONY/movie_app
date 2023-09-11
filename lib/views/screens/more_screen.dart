import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/views/widgets/video_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen(this.title, this.items, {super.key});
  final String title;
  final List<Movie> items;

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: AppSizes.newSize(6),
        leading: SizedBox(
          width: AppSizes.newSize(4),
          child: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(widget.title),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          var item = widget.items[index];
          return index % 2 == 0
              ? VideoWidget(item: item)
              : VideoWidget2(item: item);
        },
        separatorBuilder: (context, index) {
          return 10.0.spaceY;
        },
        itemCount: widget.items.length,
      ),
    );
  }
}
