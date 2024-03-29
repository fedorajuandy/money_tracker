import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/text_formats.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/models/balance.dart';
import 'package:money_tracker/operations/balance_operation.dart';
import 'package:money_tracker/widgets/title.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final balanceOperation = BalanceOperation();
  DateTime now = DateTime.now();

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
        // header
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
                Row(
                  children: <Widget>[
                    title("Balance"),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationVersion: "v1.0",
                          applicationIcon: const Image(
                            image: AssetImage('logos/app_logo.png'),
                            height: 50,
                            width: 50,
                          ),
                          applicationLegalese: "© 2019130032 - Fedora Yoshe Juandy, ${now.year}",
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: Column(
                                children: const <Widget>[
                                  Text("An application for recording daily transactions and planning budgets."),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.info_outline_rounded,
                            color: primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // main screen
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                sbh32(),
                fat(),
                sbh40(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget fat() {
    return FirebaseAnimatedList(
      query: balanceOperation.getQuery(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final b = Balance.fromJson(json);
        return balance(b.getAmount());
      },
      physics: const ScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget balance(double amount) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: amount >= 0 ? primary : red,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: secondary.withOpacity(0.01),
              spreadRadius: 10,
              blurRadius: 3,
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // upper part (subtitle)
                  const Text(
                    "Total money",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white
                    ),
                  ),
                  sbh12(),
                  // bottom part (amount)
                  Text(
                    CurrencyFormat.convertToIdr(amount, 2),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
