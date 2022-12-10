import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: screen(),
    );
  }

  Widget screen() {
    return Column(
      children: <Widget>[
        // the 'header'
        Container(
          decoration: BoxDecoration(
            color: dark.withOpacity(0.05),
            boxShadow: [
              BoxShadow(
                color: dark.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 20, right: 20, left: 20),
            child: Column(
              children: <Widget>[
                titleWithBack("About", context),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                sbh32(),
                aboutContent(),
                sbh40(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget aboutContent() {
    return Container();
  }
}