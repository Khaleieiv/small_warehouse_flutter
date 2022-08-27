import 'package:carousel_slider/carousel_slider.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(context.getString('home.label'),
              style: const TextStyle(
                letterSpacing: 1,
                fontStyle: FontStyle.italic,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          const PrefetchImageDemo(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text( context.getString('home.text'),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black38,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class PrefetchImageDemo extends StatefulWidget {
  const PrefetchImageDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrefetchImageDemoState();
  }
}

class _PrefetchImageDemoState extends State<PrefetchImageDemo> {
  final List<String> images = [
    'assets/images/warehouse_1.jpg',
    'assets/images/warehouse_2.jpg',
    'assets/images/warehouse_3.jpg',
    'assets/images/warehouse_4.jpg',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imageUrl in images) {
        precacheImage(AssetImage(imageUrl), context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          itemBuilder: (context, index, realIdx) {
            return Center(
              child: Image.asset(images[index], fit: BoxFit.cover,),
            );
          },
        ),
    );
  }
}
