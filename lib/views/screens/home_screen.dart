import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/views/widgets/home_category_widget.dart';
import 'package:movie_app/views/widgets/home_channel_widget.dart';
import '/views/widgets/slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SliderWidget(),
          HomeCategoryWidget(),
          HomeSliderWidget(),
        ],
      ),
    );
  }
}
