import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainLayout(),
      bottomNavigationBar: bottomNav(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }

  Widget mainLayout() {
    return Text('d');
  }

  Widget bottomNav() {
    return Text('d');
  }
}