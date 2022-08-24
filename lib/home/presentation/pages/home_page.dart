import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Spacer(),
          Text(
            'Welcome to SmallWarehouse!',
            style: TextStyle(
              letterSpacing: 1,
              fontStyle: FontStyle.italic,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Expanded(
            flex: 3,
            child: PrefetchImageDemo(),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Our warehouses are rented for storage of personal belongings and for storage of various cargoes and goods. Families keep strollers, seasonal items and old furniture. Summer residents often rent a storage container for lawn mowers and greenhouses, and athletes store motorcycles, bicycles and boats in the winter. Large containers are rented for furniture, household appliances and cargo: goods for sale in online stores, pallets, building materials and everything for repair.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black38,
              ),
            ),
          ),
          Spacer(),
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
    return Scaffold(
      body: CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        itemBuilder: (context, index, realIdx) {
          return Center(
            child: Image.asset(images[index], fit: BoxFit.cover, width: 1000),
          );
        },
      ),
    );
  }
}
