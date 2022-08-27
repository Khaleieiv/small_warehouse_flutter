import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/common/config/localization.dart';
import 'package:small_warehouse/common/presentation/navigation/route_names.dart';
import 'package:small_warehouse/home/presentation/pages/home_page.dart';
import 'package:small_warehouse/list_warehouse/presentation/pages/list_warehouse_page.dart';
import 'package:small_warehouse/rent/presentation/pages/rent_page.dart';

class MyBottomAppBar extends StatefulWidget {
  const MyBottomAppBar({Key? key}) : super(key: key);

  @override
  State<MyBottomAppBar> createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  final _advancedDrawerController = AdvancedDrawerController();

  int selectedPage = 0;
  final _pageNum = [
    const HomePage(),
    const ListWarehousePage(),
    const RentPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: true,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const _DrawerPage(),
      child: Scaffold(
        body: _pageNum[selectedPage],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.tealAccent,
          items: [
            TabItem(
              icon: Icons.home,
              title: context.getString('my_bottom_app_bar.home'),
            ),
            TabItem(
              icon: Icons.warehouse_outlined,
              title: context.getString('my_bottom_app_bar.warehouse'),
            ),
            TabItem(
              icon: Icons.shopping_basket_outlined,
              title: context.getString('my_bottom_app_bar.rent'),
            ),
          ],
          initialActiveIndex: selectedPage,
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}

class _DrawerPage extends StatelessWidget {
  const _DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale nextLocale = Localization.getNextLocale(context)!;
    final authNotifier = context.watch<AuthNotifier>();
    final userData = authNotifier.currentUser;

    final labelLocalization =
        context.getString('my_bottom_app_bar.localization');
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (userData != null)
              UserAccountsDrawerHeader(
                accountName: Text(userData.name.toString()),
                accountEmail: Text(userData.email.toString()),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.android),
                ),
              ),
            const Divider(),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.profilePage);
              },
              leading: const Icon(Icons.account_circle_rounded),
              title: Text(context.getString('my_bottom_app_bar.profile')),
            ),
            ListTile(
              onTap: () {
                EzLocalizationBuilder.of(context)!.changeLocale(nextLocale);
              },
              leading: const Icon(Icons.language),
              title: Text('$labelLocalization - ${nextLocale.languageCode}'),
            ),
            const Spacer(
              flex: 8,
            ),
            ListTile(
              onTap: () {
                authNotifier.signOut();
                Navigator.pushNamed(context, RouteNames.loginPage);
              },
              leading: const Icon(Icons.login_outlined),
              title: const Text(''),
            ),
            const Spacer(),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Column(
                  children: const [
                    Text('Terms of Service | Privacy Policy'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Copyright © 2022'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
