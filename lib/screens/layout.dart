import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainLayout(),
      bottomNavigationBar: bottomNav(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
        onPressed: () {
          setTabs(4);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget mainLayout() {
    return IndexedStack(
      index: pageIndex,
      children: const <Widget>[
        Center(
          child: Text("Tramsactions"),
        ),
        Center(
          child: Text("Reports"),
        ),
        Center(
          child: Text("Plans"),
        ),
        Center(
          child: Text("Balance"),
        ),
      ],
    );
  }

  Widget bottomNav() {
    List<IconData> iconItems = [
      // transactions
      Icons.calendar_month,
      // reports
      Icons.graphic_eq,
      // plans
      Icons.wallet,
      // balance
      Icons.person,
    ];

    return AnimatedBottomNavigationBar(
      icons: iconItems,
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black54,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      leftCornerRadius: 10,
      iconSize: 24,
      rightCornerRadius: 10,
      onTap: (index) {
        setTabs(index);
      }
    );
  }

  setTabs(index) {
    // ignore: unused_element
    setState() {
      pageIndex = index;
    }
  }
}