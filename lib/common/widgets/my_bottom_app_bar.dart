import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:small_warehouse/auth/presentation/pages/login_page.dart';
import 'package:small_warehouse/home/presentation/pages/home_page.dart';
import 'package:small_warehouse/list_warehouse/presentation/pages/list_warehouse_page.dart';

class MyBottomAppBar extends StatefulWidget {
  const MyBottomAppBar({Key? key}) : super(key: key);

  @override
  State<MyBottomAppBar> createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  int selectedPage = 0;
  final _pageNum = [const HomePage(),const ListWarehousePage(),const LoginPage() , const LoginPage() ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageNum[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.tealAccent,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.warehouse_outlined, title: 'Warehouse'),
          TabItem(icon: Icons.shopping_basket_outlined, title: 'Rent'),
          TabItem(icon: Icons.list, title: 'Settings'),
        ],
        initialActiveIndex: selectedPage,
        onTap: (int index){
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}