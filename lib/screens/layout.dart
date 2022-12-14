import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/screens/balance_screens/balance_screen.dart';
import 'package:money_tracker/screens/plan_screens/plan_screen.dart';
import 'package:money_tracker/screens/report_screens/report_screen.dart';
import 'package:money_tracker/screens/transaction_screens/transaction_screen.dart';
import 'package:money_tracker/screens/transaction_screens/add_transaction_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int pageIndex = 0;
  List<Widget> screens = [
    const TransactionScreen(),
    const ReportScreen(),
    const PlanScreen(),
    const BalanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainLayout(),
      bottomNavigationBar: bottomNav(),
      // add a new transaction
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget mainLayout() {
    // switch between main screens
    return IndexedStack(
      index: pageIndex,
      children: screens
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
    setState(() {
      pageIndex = index;
    });
  }
}