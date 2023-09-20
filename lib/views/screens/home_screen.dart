import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          HomeSliderWidget(),
        ],
      ).animate().fade().scale().move(
            delay: 600.ms,
            duration: 600.ms,
          ),
    );
  }
}
